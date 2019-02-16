{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module Workshop.Json where

import Data.List (intercalate)
import Data.Aeson (FromJSON, ToJSON, eitherDecode)
import GHC.Generics (Generic)
import qualified Data.ByteString.Lazy as B
import Network.HTTP.Conduit (simpleHttp)

-- hints:
-- type FilePath = String
-- readFile :: FilePath -> IO ByteString
-- simpleHttp :: MonadIO m => String -> m ByteString
-- decode :: FromJSON a => ByteString -> Maybe a
-- eitherDecode :: FromJSON a => ByteString -> Either String a
-- (<$>) :: Functor f => (a -> b) -> f a -> f b
-- fmap  :: Functor f => (a -> b) -> f a -> f b


-- TASK 1
data ToDo = ToDo deriving Show

-- TASK 2
decodeToDos :: B.ByteString -> Either String [ToDo]
decodeToDos = undefined

-- TASK 3
getToDo :: Int -> IO (Either String ToDo)
getToDo = undefined
-- from: https://jsonplaceholder.typicode.com/todos/

-------------

-- TASK 4
data Person = Person deriving Show

-- TASK 5
jsonFile :: FilePath
jsonFile = undefined
-- look in `data` folder

-- TASK 6
getJsonByteString :: IO B.ByteString
getJsonByteString = undefined

-- TASK 7
decodePersons :: B.ByteString -> Either String [Person]
decodePersons = undefined

-- TASK 8
getPersons :: IO (Either String [Person])
getPersons = undefined

-------------

-- TASK 9: Uncomment code below and the commented fragments in tests
-- Check if all tests pass

run :: IO ()
run = do
  -- personsE <- getPersons
  -- case personsE of
  --   Left err -> putStrLn err
  --   Right persons -> print persons
  -- todoE <- getToDo 1
  -- case todoE of
  --   Left err -> putStrLn err
  --   Right todo -> print todo
  putStrLn "done"
