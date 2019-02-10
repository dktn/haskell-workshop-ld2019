{-# LANGUAGE TemplateHaskell #-}

module Workshop.LensExamples where

import Control.Lens
import Data.Tuple (swap)
import Control.Monad.State (State, execState)

data Point a =
  Point
    { _x :: a
    , _y :: a
    } deriving (Show, Eq)

makeLenses ''Point

data Line a =
  Line
    { _lineStart :: Point a
    , _lineEnd   :: Point a
    } deriving (Show, Eq)

makeLenses ''Line

test1 :: IO ()
test1 = do
  let line1 = Line (Point 1 2) (Point 3 4)
  putStrLn $ "line1: " <> show line1
  putStrLn "simple view"
  print $ view lineEnd line1
  print $ line1 ^. lineEnd
  putStrLn "simple set"
  print $ set lineEnd (Point 0 1) line1
  print $ lineEnd .~ (Point 0 1) $ line1
  print $ line1 & lineEnd .~ (Point 0 1)
  putStrLn "lenses composition"
  print $ view (lineEnd . y) line1
  print $ line1 ^. lineEnd . y
  putStrLn "value modification"
  print $ over (lineEnd . y) (*2) line1
  print $ lineEnd . y %~ (*2) $ line1
  print $ line1 & lineEnd . y %~ (*2)

test2 :: IO ()
test2 = do
  let tuple1 = (3, (5, 7))
  putStrLn $ "tuple1: " <> show tuple1
  putStrLn "simple view"
  print $ view _2 tuple1
  print $ tuple1 ^. _2
  putStrLn "simple set"
  print $ set _2 "new-value" tuple1
  print $ _2 .~ "new-value" $ tuple1
  print $ tuple1 & _2 .~ "new-value"
  putStrLn "lenses composition"
  print $ view (_2 . _1) tuple1
  print $ tuple1 ^. _2 . _1
  putStrLn "value modification"
  print $ over (_2 . _1) (*2) tuple1
  print $ _2 . _1 %~ (*2) $ tuple1
  print $ tuple1 & _2 . _1 %~ (*2)

test3 :: IO ()
test3 = do
  let tuple1 = (3, 5)
  putStrLn $ "tuple1: " <> show tuple1
  putStrLn "simple set"
  print $ set both "new-value" tuple1
  print $ both .~ "new-value" $ tuple1
  print $ tuple1 & both .~ "new-value"
  putStrLn "value modification"
  print $ over both (*2) tuple1
  print $ both %~ (*2) $ tuple1
  print $ tuple1 & both %~ (*2)

test4 :: IO ()
test4 = do
  let tuple1 = ("Hello, ", "world!")
  putStrLn $ "tuple1: " <> show tuple1
  putStrLn "simple view"
  print $ view both tuple1
  print $ tuple1 ^. both

test5 :: IO ()
test5 = do
  let tuple1 = (3, (5, 7))
  putStrLn $ "tuple1: " <> show tuple1
  putStrLn "value modification"
  print $ tuple1 & _2 . _1 %~ (*2)
  print $ tuple1 & _2 . _1 *~ 2
  print $ tuple1 & _2 . _1 *~ 2
                 & _2 . _2 +~ 3
                 & _1      -~ 1
                 & swap

test6 :: IO ()
test6 = do
  let line1 = Line (Point 1 2) (Point 3 4)
  putStrLn $ "line1: " <> show line1
  putStrLn "value modification"
  print $ line1 & lineStart . x *~ 2
                & lineStart . y +~ 3
                & lineEnd       %~ (\(Point x y) -> Point y x)

test7 :: IO ()
test7 = do
  let line1 = Line (Point 1 2) (Point 3 4)
  putStrLn $ "line1: " <> show line1
  print $ execState modLine1 line1
  print $ execState modLine2 line1
  where
    modLine1 :: Num a => State (Line a) ()
    modLine1 = do
      lineStart .= Point 0 0
      zoom lineEnd $ do
        x *= 2
        y += 5
        pointCoordinates %= negate

    modLine2 :: Num a => State (Line a) ()
    modLine2 =
      zoom lineEnd $ do
        newX <- x <*= 5
        posY .= newX

    posX :: (Num a, Functor f) => (a -> f a) -> (Point a) -> f (Point a)
    posX f (Point x y) = fmap (\x' -> Point x' y) (f x)

    posY :: Lens' (Point a) a
    posY f (Point x y) = fmap (\y' -> Point x y') (f y)

    pointCoordinates :: (Num a, Applicative f) => (a -> f a) -> (Point a) -> f (Point a)
    pointCoordinates f (Point x y) = Point <$> f x <*> f y

run :: IO ()
run = sequence_ [ test1, test2, test3, test4, test5, test6, test7 ]
