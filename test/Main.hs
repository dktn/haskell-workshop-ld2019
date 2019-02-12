module Main where

import Test.Tasty
import Test.Tasty.ExpectedFailure

import qualified Workshop.LensSpec as LensSpec
import qualified Workshop.JsonSpec as JsonSpec

main :: IO ()
main = do
  lensUnitTests <- LensSpec.unitTests
  jsonUnitTests <- JsonSpec.unitTests
  defaultMain $ testGroup "All tests"
    [ expectFail $ lensUnitTests
    , expectFail $ LensSpec.propertyTests
    , expectFail $ jsonUnitTests
    ]
