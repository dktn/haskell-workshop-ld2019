#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

{-# LANGUAGE OverloadedStrings #-}

module TurtleTest where

import Turtle
import Data.List (isSuffixOf)

-- list all Haskell files from "../src/Workshop" and print their timestamps
main :: IO ()
main = do
  sh $ do
    file <- ls "../src/Workshop"
    when (".hs" `isSuffixOf` encodeString file) $ do
      time <- datefile file
      liftIO $ do
        print file
        print time
