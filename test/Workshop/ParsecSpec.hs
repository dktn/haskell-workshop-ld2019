module Workshop.ParsecSpec where

import Data.Either (isLeft)
import Test.Tasty (TestTree, testGroup)
import Test.Tasty.Hspec (testSpec)
import Test.Hspec (describe, it, shouldBe, shouldSatisfy)

import Workshop.Parsec

unitTests :: IO TestTree
unitTests = testSpec "Parsec unit tests" $
  describe "Parsec operations" $ do
    it "parses 22:223" $ do
      parsePostcode "22:233" `shouldBe` Right (Postcode 22 233)
    it "cannot parse 111:333" $ do
      parsePostcode "111:333" `shouldSatisfy` isLeft
    it "cannot parse 11:33" $ do
      parsePostcode "11:33" `shouldSatisfy` isLeft
