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
getLineEndYPM = undefined

getLineEndY :: Line a -> a
getLineEndY = undefined

swapPointCoordsPM :: Point a -> Point a
swapPointCoordsPM = undefined

swapPointCoords :: Point a -> Point a
swapPointCoords = undefined

changeLineStartPM :: Point a -> Line a -> Line a
changeLineStartPM = undefined

changeLineStart :: Point a -> Line a -> Line a
changeLineStart = undefined

changeLineStartYPM :: a -> Line a -> Line a
changeLineStartYPM = undefined

changeLineStartY :: a -> Line a -> Line a
changeLineStartY = undefined

modifyLineStartYPM :: (a -> a) -> Line a -> Line a
modifyLineStartYPM = undefined

modifyLineStartY :: (a -> a) -> Line a -> Line a
modifyLineStartY = undefined

modifyTupleSndFstPM :: (b -> b') -> (a, (b, c)) -> (a, (b', c))
modifyTupleSndFstPM = undefined

modifyTupleSndFst :: (b -> b') -> (a, (b, c)) -> (a, (b', c))
modifyTupleSndFst = undefined

modifyTupleBothPM :: (a -> b) -> (a, a) -> (b, b)
modifyTupleBothPM = undefined

modifyTupleBoth :: (a -> b) -> (a, a) -> (b, b)
modifyTupleBoth = undefined

changeStartYAndModifyEndXPM :: a -> (a -> a) -> Line a -> Line a
changeStartYAndModifyEndXPM = undefined

changeStartYAndModifyEndX :: a -> (a -> a) -> Line a -> Line a
changeStartYAndModifyEndX = undefined

changeStartYAndModifyEndXState :: a -> (a -> a) -> Line a -> Line a
changeStartYAndModifyEndXState = undefined

run :: IO ()
run = putStrLn "Nothing here..."
