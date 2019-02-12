module Workshop.LensSpec where

import Test.Tasty (TestTree, testGroup)
import Test.Tasty.Hspec (testSpec)
import Test.Tasty.Hedgehog (testProperty)
import Test.Hspec (describe, it, shouldBe, shouldThrow)
import Hedgehog (MonadGen, Range, forAll, property, (===))
import qualified Hedgehog.Gen as Gen
import qualified Hedgehog.Range as Range

import Workshop.Lens

unitTests :: IO TestTree
unitTests = testSpec "Lens unit tests" $ do
  describe "Lens basic operations" $ do
    it "Get line end y returns 7" $ do
      getLineEndY (Line (Point 1 3) (Point 5 7)) `shouldBe` 7
    it "Change start y and multiply end x by 3 returns new line" $ do
      changeStartYAndModifyEndX 8 (* 3) (Line (Point 1 3) (Point 5 7)) `shouldBe` (Line (Point 1 8) (Point 15 7))

defRange :: Range Int
defRange = Range.linear 0 100

genPoint :: (MonadGen m, Integral a) => Range a -> m (Point a)
genPoint range = Point <$> Gen.integral range <*> Gen.integral range

genLine :: (MonadGen m, Integral a) => Range a -> m (Line a)
genLine range = Line <$> genPoint range <*> genPoint range

genTuple :: (MonadGen m, Integral a) => Range a -> m (a, a)
genTuple range = (,) <$> Gen.integral range <*> Gen.integral range

modFun :: Int -> Int
modFun = (* 2)

propertyTests :: TestTree
propertyTests = testGroup "Lens property tests"
  [ testProperty "Get line end y - pattern matching" $ property $ do
      l@(Line _ (Point _ y2)) <- forAll $ genLine defRange
      getLineEndYPM l === y2
  , testProperty "Get line end y - lenses" $ property $ do
      l@(Line _ (Point _ y2)) <- forAll $ genLine defRange
      getLineEndY l === y2
  , testProperty "Swap point coordinates - pattern matching" $ property $ do
      p@(Point x y) <- forAll $ genPoint defRange
      swapPointCoordsPM p === Point y x
  , testProperty "Swap point coordinates - lenses" $ property $ do
      p@(Point x y) <- forAll $ genPoint defRange
      swapPointCoords p === Point y x
  , testProperty "Change line start - pattern matching" $ property $ do
      l@(Line s e) <- forAll $ genLine defRange
      p <- forAll $ genPoint defRange
      changeLineStartPM p l === Line p e
  , testProperty "Change line start - lenses" $ property $ do
      l@(Line s e) <- forAll $ genLine defRange
      p <- forAll $ genPoint defRange
      changeLineStart p l === Line p e
  , testProperty "Change line start y - pattern matching" $ property $ do
      l@(Line (Point x y) e) <- forAll $ genLine defRange
      c <- forAll $ Gen.int defRange
      changeLineStartYPM c l === Line (Point x c) e
  , testProperty "Change line start y - lenses" $ property $ do
      l@(Line (Point x y) e) <- forAll $ genLine defRange
      c <- forAll $ Gen.int defRange
      changeLineStartY c l === Line (Point x c) e
  , testProperty "Modify line start y - pattern matching" $ property $ do
      l@(Line (Point x y) e) <- forAll $ genLine defRange
      modifyLineStartYPM modFun l === Line (Point x $ modFun y) e
  , testProperty "Modify line start y - lenses" $ property $ do
      l@(Line (Point x y) e) <- forAll $ genLine defRange
      modifyLineStartY modFun l === Line (Point x $ modFun y) e
  , testProperty "Modify tuple second first - pattern matching" $ property $ do
      (a, (b, c)) <- forAll $ (,) <$> Gen.integral defRange <*> genTuple defRange
      modifyTupleSndFstPM modFun (a, (b, c)) === (a, (modFun b, c))
  , testProperty "Modify tuple second first - lenses" $ property $ do
      (a, (b, c)) <- forAll $ (,) <$> Gen.integral defRange <*> genTuple defRange
      modifyTupleSndFst modFun (a, (b, c)) === (a, (modFun b, c))
  , testProperty "Modify tuple both - pattern matching" $ property $ do
      (a, b) <- forAll $ genTuple defRange
      modifyTupleBothPM modFun (a, b) === (modFun a, modFun b)
  , testProperty "Modify tuple both - lenses" $ property $ do
      (a, b) <- forAll $ genTuple defRange
      modifyTupleBoth modFun (a, b) === (modFun a, modFun b)
  , testProperty "Change line start y and modify line end x - pattern matching" $ property $ do
      ny1 <- forAll $ Gen.int defRange
      l@(Line (Point x1 y1) (Point x2 y2)) <- forAll $ genLine defRange
      changeStartYAndModifyEndXPM ny1 modFun l === Line (Point x1 ny1) (Point (modFun x2) y2)
  , testProperty "Change line start y and modify line end x - lenses" $ property $ do
      ny1 <- forAll $ Gen.int defRange
      l@(Line (Point x1 y1) (Point x2 y2)) <- forAll $ genLine defRange
      changeStartYAndModifyEndX ny1 modFun l === Line (Point x1 ny1) (Point (modFun x2) y2)
  , testProperty "Change line start y and modify line end x - lenses in state monad" $ property $ do
      ny1 <- forAll $ Gen.int defRange
      l@(Line (Point x1 y1) (Point x2 y2)) <- forAll $ genLine defRange
      changeStartYAndModifyEndXState ny1 modFun l === Line (Point x1 ny1) (Point (modFun x2) y2)
  ]
