module Main where

import Workshop.LensExamples as LensExamples
import Workshop.Lens as Lens
import Workshop.JsonExamples as JsonExamples
import Workshop.Json as Json
import Workshop.RWSExamples as RWSExamples
import Workshop.RWS as RWS
import Workshop.TreeExamples as TreeExamples
import Workshop.Tree as Tree
import Workshop.ParsecExamples as ParsecExamples
import Workshop.Parsec as Parsec

main :: IO ()
main = do
  LensExamples.run
  Lens.run
  JsonExamples.run
  Json.run
  RWSExamples.run
  RWS.run
  TreeExamples.run
  Tree.run
  ParsecExamples.run
  Parsec.run
