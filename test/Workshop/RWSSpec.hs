module Workshop.RWSSpec where

import Test.Tasty (TestTree, testGroup)
import Test.Tasty.Hspec (testSpec)
import Test.Hspec (describe, it, shouldBe)

import Workshop.RWS

unitTests :: IO TestTree
unitTests = testSpec "RWS unit tests" $
  describe "State operations" $ do
    it "calculates correctly the result of 123'456'8" $ do
      calculateScore "123'456'8" `shouldBe` 14
    it "calculates correctly the result of '123'456'8" $ do
      calculateScore "'123'456'8" `shouldBe` 15
