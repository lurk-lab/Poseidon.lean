import LSpec
import Poseidon.RoundConstants
import Poseidon.Parameters.Lurk4
import Poseidon.Parameters.PermX5_254_3
import Poseidon.Parameters.PermX5_254_5
import Poseidon.Parameters.PermX5_255_3
import Poseidon.Parameters.PermX5_255_5
import Poseidon.Parameters.RCTestPyProfiles

/-!
# Round Constant generation tests

This module contains tests for the round constant generator found in `Poseidon.RoundConstants`
-/

open LSpec Poseidon

/- This section tests the generation of constants from the profiles provided in the reference implementation -/
section ReferenceImplementation

def permX5_254_3_test := test "PermX5_254_3 Constants match" $ 
  generateRConstants true PermX5_254_3 == PermX5_254_3.roundConstants

def permX5_254_5_test := test "PermX5_254_5 Constants match" $
  generateRConstants true PermX5_254_5 == PermX5_254_5.roundConstants

def permX5_255_3_test := test "PermX5_255_3 Constants match" $ 
  generateRConstants true PermX5_255_3 == PermX5_255_3.roundConstants

def permX5_255_5_test := test "PermX5_255_5 Constants match" $ 
  generateRConstants true PermX5_255_5 == PermX5_255_5.roundConstants

def refTest : TestSeq := group "Reference implementation" $ 
  permX5_254_3_test ++ permX5_254_5_test ++ permX5_255_3_test ++ permX5_255_5_test

end ReferenceImplementation

/- This section tests the generation of constants against those generated by the Python implementation -/
section PythonImplementation

def pyTest64 := test "64-bit test profile constants match" $
  generateRConstants false pyProfile64 == py64RC

def pyTest255 := test "255-bit test profile constants match" $
  generateRConstants false pyProfile255 == py255RC

def pyTest : TestSeq := group "Python implementation" $
  pyTest64 ++ pyTest255

end PythonImplementation

/- This section tests the generation of constants used in the Poseidon implementation used by Filecoin -/
section FilecoinImplementation

def rustTest : TestSeq := test "Rust implementation constants match" $
  generateRConstants false Lurk4.Profile == Lurk4.roundConstants

end FilecoinImplementation

def main : IO UInt32 := do
  IO.println "---------------------------------"
  IO.println "Testing round constant generation"
  IO.println "---------------------------------"
  lspecIO $ refTest ++ pyTest ++ rustTest
