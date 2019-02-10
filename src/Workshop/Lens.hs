{-# LANGUAGE TemplateHaskell #-}

module Workshop.Lens where

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


-- PM - using pattern matching
-- no suffix - using lenses

getLineEndYPM :: Line a -> a
getLineEndYPM (Line _ (Point _ y2)) = y2

getLineEndY :: Line a -> a
getLineEndY l = l ^. lineEnd . y

swapPointCoordsPM :: Point a -> Point a
swapPointCoordsPM (Point x y) = Point y x

swapPointCoords :: Point a -> Point a
swapPointCoords p = Point (p ^. y) (p ^. x)

changeLineStartPM :: Point a -> Line a -> Line a
changeLineStartPM ns (Line s e) = Line ns e

changeLineStart :: Point a -> Line a -> Line a
changeLineStart ns l = l & lineStart .~ ns

changeLineStartYPM :: a -> Line a -> Line a
changeLineStartYPM ny (Line (Point x y) e) = Line (Point x ny) e

changeLineStartY :: a -> Line a -> Line a
changeLineStartY ny l = l & lineStart . y .~ ny

modifyLineStartYPM :: (a -> a) -> Line a -> Line a
modifyLineStartYPM f (Line (Point x y) e) = Line (Point x $ f y) e

modifyLineStartY :: (a -> a) -> Line a -> Line a
modifyLineStartY f l = l & lineStart . y %~ f

modifyTupleSndFstPM :: (b -> b') -> (a, (b, c)) -> (a, (b', c))
modifyTupleSndFstPM f (a, (b, c)) = (a, (f b, c))

modifyTupleSndFst :: (b -> b') -> (a, (b, c)) -> (a, (b', c))
modifyTupleSndFst f t = t & _2 . _1 %~ f

modifyTupleBothPM :: (a -> b) -> (a, a) -> (b, b)
modifyTupleBothPM f (a, b) = (f a, f b)

modifyTupleBoth :: (a -> b) -> (a, a) -> (b, b)
modifyTupleBoth f t = t & both %~ f

changeStartYAndModifyEndXPM :: a -> (a -> a) -> Line a -> Line a
changeStartYAndModifyEndXPM ny1 f (Line (Point x1 y1) (Point x2 y2)) = Line (Point x1 ny1) (Point (f x2) y2)

changeStartYAndModifyEndX :: a -> (a -> a) -> Line a -> Line a
changeStartYAndModifyEndX ny1 f l = l & lineStart . y .~ ny1 & lineEnd . x %~ f

changeStartYAndModifyEndXState :: a -> (a -> a) -> Line a -> Line a
changeStartYAndModifyEndXState ny1 f l = flip execState l $ do
  zoom lineStart $ do
    y .= ny1
  zoom lineEnd $ do
    x %= f