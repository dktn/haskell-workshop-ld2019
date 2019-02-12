module Main where

import Workshop.LensExamples as LensExamples
import Workshop.JsonExamples as JsonExamples
import Workshop.Json as Json

main :: IO ()
main = do
  LensExamples.run
  JsonExamples.run
  Json.run
