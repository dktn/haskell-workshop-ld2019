module Main where

import Workshop.LensExamples as LensExamples
import Workshop.Lens as Lens
import Workshop.JsonExamples as JsonExamples
import Workshop.Json as Json
import Workshop.RWSExamples as RWSExamples
import Workshop.RWS as RWS

main :: IO ()
main = do
  LensExamples.run
  JsonExamples.run
  Json.run
  RWSExamples.run
  RWS.run