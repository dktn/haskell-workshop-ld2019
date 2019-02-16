module Workshop.TreeSpec where

import Test.Tasty (TestTree, testGroup)
import Test.Tasty.Hspec (testSpec)
import Test.Hspec (describe, it, shouldBe)

import Workshop.TreeExamples
import Workshop.Tree

unitTests :: IO TestTree
unitTests = testSpec "Tree unit tests" $
  describe "Tree operations" $ do
    it "calculates longest branch" $ do
      longestBranch tree1 `shouldBe` 4
    it "calculates shortest branch" $ do
      shortestBranch tree1 `shouldBe` 2
    it "determines if tree2 subtree of tree1" $ do
      isSubtree tree2 tree1 `shouldBe` False
    it "determines if tree3 subtree of tree1" $ do
      isSubtree tree3 tree1 `shouldBe` True
    it "determines if tree1 is ordered" $ do
      isOrdered tree1 `shouldBe` True
    it "determines if tree2 is ordered" $ do
      isOrdered tree2 `shouldBe` False
