module Main where

import Test.Tasty
import Test.Tasty.ExpectedFailure

import qualified Workshop.LensSpec as LensSpec
import qualified Workshop.JsonSpec as JsonSpec
import qualified Workshop.RWSSpec  as RWSSpec
import qualified Workshop.TreeSpec as TreeSpec

main :: IO ()
main = do
  lensUnitTests <- LensSpec.unitTests
  jsonUnitTests <- JsonSpec.unitTests
  rwsUnitTests  <- RWSSpec.unitTests
  treeUnitTests <- TreeSpec.unitTests
  -- hint: add expectFail before a set of test to make the tests pass
  defaultMain $ testGroup "All tests"
    -- [ lensUnitTests
    -- , LensSpec.propertyTests
    -- , jsonUnitTests
    -- , rwsUnitTests
    -- , treeUnitTests
    -- ]
    [ ]
