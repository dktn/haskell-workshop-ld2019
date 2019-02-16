module Workshop.RWS where

import Control.Monad.State


-- TASK:
-- Implement a game with following rules:
-- 1. There are two modes: normal and text, you start in a normal mode and with accumulator value of 0
-- 2. Read string character by character
-- 3. If a character is a digit, add it to accumulator value unless you are in text mode
-- 4. If a character is ' (apostrophe mark), then toggle the mode
-- 5. Any other character is ignored
-- 5. Return the accumulator value

data GameMode = Normal | Text deriving (Show, Eq)
type GameScore = Int
data GameState = GameState GameMode GameScore deriving (Show, Eq)

toggleMode :: GameMode -> GameMode
toggleMode Normal = Text
toggleMode Text = Normal

sumDigits :: String -> State GameState GameScore
sumDigits (x:xs) = do
  GameState mode score <- get
  return score

calculateScore :: String -> GameScore
calculateScore input = evalState (sumDigits input) $ GameState Normal 0

run :: IO ()
run = print $ calculateScore "123'456'8"
