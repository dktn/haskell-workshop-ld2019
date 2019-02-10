module Main where

import Test.Tasty
import Test.Tasty.ExpectedFailure

import qualified Workshop.LensSpec as LensSpec

main :: IO ()
main = do
  lensUnitTests <- LensSpec.unitTests
  defaultMain $ testGroup "All tests"
    [ expectFail $ lensUnitTests
    , expectFail $ LensSpec.propertyTests
    ]
