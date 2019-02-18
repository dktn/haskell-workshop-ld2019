module Workshop.Parsec where

import Control.Applicative ((<$>), (<$), (<*>), (<*), (*>), (<|>), Applicative)
import Control.Monad (void)
import Data.Char (digitToInt)
import Text.Parsec (ParseError, parse, try)
import Text.Parsec.Char (digit, letter, spaces, char)
import Text.Parsec.Combinator (many1, sepBy1, count)
import Text.Parsec.String (Parser)


data Postcode = Postcode
  { firstPart  :: Int
  , secondPart :: Int
  } deriving (Show, Eq)

err = "An error has occurred"

number :: Parser Int
number = read <$> many1 digit

postcode :: Parser Postcode
postcode = do
  first <- read <$> count 2 digit
  void $ char ':'
  second <- read <$> count 3 digit
  return $ Postcode first second

parsePostcode :: String -> Either ParseError Postcode
parsePostcode = parse postcode err

run :: IO ()
run = do
  print $ parsePostcode "22:233"
  print $ parsePostcode "11:333"
  print $ parsePostcode "111:333" -- wrong
  print $ parsePostcode "11:33"   -- wrong
