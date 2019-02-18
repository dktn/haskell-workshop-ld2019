module Workshop.ParsecExamples where

import Control.Applicative ((<$>), (<$), (<*>), (<*), (*>), (<|>), Applicative)
import Control.Monad (void)
import Data.Char (digitToInt)
import Text.Parsec (ParseError, parse, try)
import Text.Parsec.Char (digit, letter, spaces, char, lower, upper, alphaNum)
import Text.Parsec.Combinator (many1, sepBy1, count)
import Text.Parsec.String (Parser)


data ElementsList =
    WordList { words :: [String] }
  | IntList  { ints  :: [Int]    }
  deriving (Show, Eq)

err = "An error has occurred"

number :: Parser Int
number = read <$> many1 digit

brackets :: Parser a -> Parser a
brackets = (<* char ']') . (char '[' *>)

elements :: Parser a -> Parser [a]
elements = flip sepBy1 (char ',')

listOf :: Parser a -> Parser [a]
listOf = brackets . elements

elementsList :: Parser ElementsList
elementsList = try intList <|> strList
  where
    intList  = IntList  <$> listOf number
    strList  = WordList <$> listOf (many1 letter)

data HaskellTypeSig = HaskellTypeSig
  { valName  :: String
  , typeName :: String
  } deriving (Show, Eq)

haskellTypeSig :: Parser HaskellTypeSig
haskellTypeSig = do
  valName <- (:) <$> lower <*> many1 alphaNum
  void $ spaces *> count 2 (char ':') *> spaces
  typeName <- (:) <$> upper <*> many1 alphaNum
  pure $ HaskellTypeSig valName typeName

run :: IO ()
run = do
  print $ parse number err "2"
  print $ parse number err "9"
  print $ parse number err "99"
  print $ parse number err "a"
  print $ parse (many1 letter) err "abc"
  print $ parse (many1 letter) err "abc123"
  print $ parse elementsList err "[1,2,3,6,8]"
  print $ parse elementsList err "[dogcat,monkeypig]"
  print $ parse haskellTypeSig err "ala :: Int"
  print $ parse haskellTypeSig err "ala1 :: Int"
  print $ parse haskellTypeSig err "Ala :: Int"
  print $ parse haskellTypeSig err "ala :: int"
