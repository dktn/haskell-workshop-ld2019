module Main where

import Test.Tasty
import Test.Tasty.ExpectedFailure

import qualified Workshop.LensSpec as LensSpec
import qualified Workshop.JsonSpec as JsonSpec
import qualified Workshop.RWSSpec  as RWSSpec

main :: IO ()
main = do
  lensUnitTests <- LensSpec.unitTests
  jsonUnitTests <- JsonSpec.unitTests
  rwsUnitTests  <- RWSSpec.unitTests
  -- hint: add expectFail before a set of test to make the tests pass
  defaultMain $ testGroup "All tests"
    -- [ lensUnitTests
    -- , LensSpec.propertyTests
    -- , jsonUnitTests
    -- , rwsUnitTests
    -- ]
    [ ]
