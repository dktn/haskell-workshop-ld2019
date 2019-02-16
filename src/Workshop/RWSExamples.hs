module Workshop.RWSExamples where

import Control.Monad.Reader
import Control.Monad.Writer
import Control.Monad.State
import Data.Char (toUpper)

---------------

data Config = Config { name :: String, age :: Int }

workOnConfig :: Reader Config (String, Int)
workOnConfig = do
  c <- ask
  return ("Hello " ++ name c, 2 * age c)

example1 :: IO ()
example1 = do
  putStrLn "Enter your name:"
  name <- getLine
  putStrLn "Enter your age:"
  age <- getLine
  let config = Config name $ read age
      result = runReader workOnConfig config
  putStrLn $ fst result
  putStrLn $ "Twice your age is: " <> show (snd result)

---------------

doOperations :: Int -> Int -> Writer [String] Int
doOperations x y = do
  tell ["multiply"]
  let a = x * y
  tell ["add 7"]
  let b = a + 7
  pure b

example2 :: IO ()
example2 =
  print $ runWriter $ doOperations 4 5

---------------

capitalizeAndGetLength :: State String Int
capitalizeAndGetLength = do
  val <- get
  case val of
    s@(x:xs) -> do
      put $ toUpper x : xs
      pure $ length s
    empty  -> pure 0

example3 :: IO ()
example3 = print $ runState capitalizeAndGetLength "europe"

---------------

run :: IO ()
run = example1 >> example2 >> example3
