import Poseidon.Util.Ring

/-!
# Basic Linear Algebra

This file contains some basic definitions needed 

NOTE : I apologize for this code, this is very bad Lean code and I am ashamed. 
The upside is it should be fast, and very easy to improve.
-/

variable (R : Type) [Ring R]

section vector

abbrev Vector := Array R

namespace Vector

variable {R} [OfNat R 0]

/-
NOTE : All these definitions only make sense when we know that the two arrays representing the
vectors have the same dimension. Otherwise you'll get nonsense. 

Look at `AbstractMatrix.lean` for a comment on the prefered solution where vectors carry their
length, which is currently blocked by some formalization of Array lemmas that still needs to be done
in the standard library.
-/

def add (v w : Vector R) : Vector R := v.zip w |>.map fun (x, y) => x + y

instance : Add (Vector R) := ⟨add⟩

def dot (v w : Vector R) : R := v.zip w |>.foldr (fun (x, y) acc => acc + x * y) 0

def scale (r : R) (v : Vector R) : Vector R := v.map fun x => x * r

def zero (R) [OfNat R 0] (dim : Nat) : Vector R := Array.mkArray dim 0

instance : HMul R (Vector R) (Vector R) := ⟨scale⟩

end Vector
end vector

section matrix

abbrev Matrix (R : Type) [Ring R] := Array $ Array R

namespace Matrix

variable {R}

def row (M : Matrix R) (i : Nat) : Vector R := Id.run do
  let mut answer : Vector R := #[]
  for col in M do
    answer := answer.push col[i]!
  return answer

def transpose (M : Matrix R) : Matrix R := Id.run do
  let rowNum := M[0]!.size
  let mut answer : Matrix R := #[]
  for idx in List.range rowNum do
    answer := answer.push (row M idx)
  return answer

def action (M : Matrix R) (v : Vector R) : Vector R :=
  M.zip v |>.foldl (fun v (col, r) => v + r * col) (Vector.zero R v.size)

def mul (M N : Matrix R) : Matrix R :=
  N.map (fun v => action M v)

end Matrix
end matrix