#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

{-# LANGUAGE OverloadedStrings #-}

module TurtleExamples where

import Turtle
import Data.List (isSuffixOf)

datePwd = do
  dir    <- pwd
  result <- datefile dir
  return result

main = do
  echo "Hello, world!"
  shell "echo 'Hello'" empty
  printf ("Hello, "%s%"!\n") "world"

  echo ""
  echo "Show the date of working directory"
  time <- datePwd
  print time

  echo ""
  echo "Show parent and current directory content"
  view $ ls ".." <|> ls "."

  echo ""
  echo "Show Haskell files"
  view (find (suffix ".hs") "..")

  echo ""
  echo "Show Yaml files in loop"
  sh $ do
    file <- ls ".."
    when (".yaml" `isSuffixOf` encodeString file) $
      liftIO $ print file

  echo ""
  echo "Print data in loops"
  sh $ do
    x <- select [1, 2]
    y <- select [3, 4]
    liftIO $ print (x, y)
