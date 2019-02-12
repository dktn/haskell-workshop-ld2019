{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}

module Workshop.JsonExamples where

import Data.List (intercalate)
import Data.Aeson (FromJSON, ToJSON, eitherDecode)
import GHC.Generics (Generic)
import qualified Data.ByteString.Lazy as B


data Department = Department
  { departmentId :: Int
  , name         :: String
  } deriving (Show, Generic, FromJSON, ToJSON)

-- without DeriveAnyClass extension enabled the instances should have been declared separately:
-- instance FromJSON Person
-- instance ToJSON Person

sampleData :: B.ByteString
sampleData = "{\"departmentId\":7,\"name\":\"IT\"}"

run :: IO ()
run = do
  putStrLn "Json parsing demo"
  let depE = eitherDecode sampleData :: Either String Department
  case depE of
    Left err -> putStrLn err
    Right dep -> print dep
