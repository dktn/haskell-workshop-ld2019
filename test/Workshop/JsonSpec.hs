{-# LANGUAGE OverloadedStrings #-}

module Workshop.JsonSpec where

import Data.Either (isRight, fromRight)
import Data.Either.Combinators (fromRight')
import Test.Tasty (TestTree, testGroup)
import Test.Tasty.Hspec (testSpec)
import Test.Hspec (describe, it, shouldBe, shouldSatisfy)

import Workshop.Json

unitTests :: IO TestTree
unitTests = testSpec "Json unit tests" $
  describe "Json basic operations" $ do
    it "parses ToDos correctly from a string" $ do
      let content =
            "[\n\
            \  {\n\
            \    \"userId\": 1,\n\
            \    \"id\": 1,\n\
            \    \"title\": \"delectus aut autem\",\n\
            \    \"completed\": false\n\
            \  },\n\
            \  {\n\
            \    \"userId\": 1,\n\
            \    \"id\": 2,\n\
            \    \"title\": \"quis ut nam facilis et officia qui\",\n\
            \    \"completed\": true\n\
            \  }\n\
            \]\n"

      let todosResult = decodeToDos content

      todosResult `shouldSatisfy` isRight
      let todos = fromRight [] todosResult
      length todos `shouldBe` 2

      -- userId (todos !! 0) `shouldBe` 1
      -- Workshop.Json.id (todos !! 0) `shouldBe` 1
      -- title (todos !! 0) `shouldBe` "delectus aut autem"
      -- completed (todos !! 0) `shouldBe` False

      -- userId (todos !! 1) `shouldBe` 1
      -- Workshop.Json.id (todos !! 1) `shouldBe` 2
      -- title (todos !! 1) `shouldBe` "quis ut nam facilis et officia qui"
      -- completed (todos !! 1) `shouldBe` True

    it "parses ToDos correctly from an online source" $ do
      todoResult <- getToDo 1

      todoResult `shouldSatisfy` isRight
      -- let todo = fromRight' todoResult

      -- userId todo `shouldBe` 1
      -- Workshop.Json.id todo `shouldBe` 1
      -- title todo `shouldBe` "delectus aut autem"
      -- completed todo `shouldBe` False

    it "parses persons correctly from a file" $ do
      personsResult <- getPersons

      personsResult `shouldSatisfy` isRight
      let persons = fromRight' personsResult

      length persons `shouldBe` 2

      -- firstName (persons !! 0) `shouldBe` "Jan"
      -- lastName (persons !! 0) `shouldBe` "Kowalski"
      -- age (persons !! 0) `shouldBe` 26

      -- firstName (persons !! 1) `shouldBe` "Piotr"
      -- lastName (persons !! 1) `shouldBe` "Nowak"
      -- age (persons !! 1) `shouldBe` 33
