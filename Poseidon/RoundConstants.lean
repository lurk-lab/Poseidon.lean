import Poseidon.Profile
import YatimaStdLib.ByteArray
import YatimaStdLib.Monad
import YatimaStdLib.Zmod

/-!
# Generates the Poseidon Round Constants

This module contains the main function `Poseidon.generateRConstants` which generates the
un-optimized round constants used by the Poseidon hash function in the `ARC` layer of each round.

The additional `usingRef : Bool` paramter is used to distinguish round constants generated by the
reference schema from the schema commonly used in other implementations.

Pre-computed round constants are included for select hash profiles in `Poseidon.Parameters`. 
-/

private def fieldBits (isPrime : Bool) : UInt64 := if isPrime then 1 else 0

private def lurkSBoxBits : Int → UInt64
  | -1 => 2
  |  3 => 0
  |  5 => 1
  |  _ => 3

private def refSBoxBits : Int → UInt64
  | .ofNat   _ => 0
  | .negSucc _ => 1

private def fieldSizeBits (prime : Nat) : UInt64 := prime.log2 + 1 |>.toUInt64

private def padOne (u : UInt64) : Nat → UInt64
  | 0     => u
  | n + 1 => (u <<< 1) + 1 |> (padOne · n)

/--
The initial internal state for the round constant generation algorithm. 

`usingRef` refers to whether the initial state should follow the schema used in the reference
implementation or that used in other commonly included 

`isPrime` is used to determine whether the base field is an odd prime or not. At this point `GF(2ⁿ)`
hashing is not supported, and this parameters is included only for completeness
-/
private def grainStateInit (usingRef isPrime : Bool) (a : Int) (prime : Nat) 
                           (t fullRound partialRound : UInt64) := 
  let sBoxBits := if usingRef then refSBoxBits else lurkSBoxBits
  ByteArray.mk $
    (fieldBits isPrime) |> (· <<< (4 : UInt64))
                        |> (· + sBoxBits a)
                        |> (· <<< (12 : UInt64))
                        |> (· + fieldSizeBits prime)
                        |> (· <<< (12 : UInt64))
                        |> (· + t)
                        |> (· <<< (10 : UInt64))
                        |> (· + fullRound)
                        |> (· <<< (10 : UInt64))
                        |> (· + partialRound)
                        |> (padOne · 14)
                        |>.toByteArray.data.reverse
                        |>.push 0xff
                        |>.push 0xff

namespace Poseidon

/--
The internal state used in round constant generation
-/
structure RCState (p : Nat) where
  bitRound : Array Bit
  state  : ByteArray
  rndCon : Array (Zmod p)

/--
Initialization of the internal state.

`usingRef` refers to whether the initial state should follow the schema used in the reference
implementation or that used in other commonly included 
-/
def RCState.init (usingRef : Bool) (prof : Poseidon.HashProfile) : RCState prof.p where
  bitRound := #[]
  state := grainStateInit usingRef true prof.a 
                               prof.p
                               prof.t.toUInt64 
                               prof.fullRounds.toUInt64 
                               prof.partRounds.toUInt64
  rndCon := #[]

abbrev RoundConstantM (profile : Poseidon.HashProfile) := StateM (RCState profile.p)

namespace RoundConstantM

def notEnoughConst : RoundConstantM prof Bool := 
  get >>= fun s => pure $ s.rndCon.size < (prof.fullRounds + prof.partRounds)*prof.t

def notEnoughBits : RoundConstantM prof Bool :=
  get >>= fun s => pure $ s.bitRound.size < prof.p.log2 + 1

def extractBit : RoundConstantM prof Bit := do
  let stt := (← get).state
  let bits := #[stt.getBit 62, stt.getBit 51, stt.getBit 38, 
                stt.getBit 23, stt.getBit 13, stt.getBit 0]
  return Bit.arrayXOr bits

def generateBitArray : RoundConstantM prof Unit := do
  modify fun ⟨_, s, rC⟩ => ⟨#[], s, rC⟩
  Monad.repeatWhile notEnoughBits do
    let b₁ ← extractBit
    modify (fun ⟨br, s, rc⟩ => ⟨br, s.shiftAdd b₁, rc⟩)
    let b₂ ← extractBit
    modify (fun ⟨br, s, rc⟩ => ⟨br, s.shiftAdd b₂, rc⟩)
    if b₁ == .one then
      modify fun ⟨bR, s, rC⟩ => ⟨bR.push b₂, s, rC⟩
    else
      pure ()

end RoundConstantM

open RoundConstantM in
/--
The main round constant generation algorithm.
-/
def runGeneration (prof : Poseidon.HashProfile) : RoundConstantM prof Unit := do 
  for _ in [:160] do
    let b ← extractBit
    modify (fun ⟨br, s, rc⟩ => ⟨br, s.shiftAdd b, rc⟩)
  Monad.repeatWhile notEnoughConst do
    generateBitArray
    let c := Bit.arrayToNat (← get).bitRound
    if c < prof.p then 
      modify fun ⟨bR, s, rC⟩ => ⟨bR, s, rC.push c⟩
    else
      return ()
  return ()

/--
This is the user-facing function used to generate the round constants used as an input for the
Poseidon hashing function.

`usingRef` refers to whether the initial state should follow the schema used in the reference
implementation or that used in other commonly included. Generally this should be taken to be `false`
unless it is necessary to match the reference implementation.
-/
def generateRConstants (usingRef : Bool) (profile : Poseidon.HashProfile) : Array (Zmod profile.p) :=
   Id.run <| Prod.snd <$> runGeneration profile (.init usingRef profile) |>.rndCon
