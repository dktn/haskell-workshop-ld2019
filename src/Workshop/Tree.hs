module Workshop.Tree where

data Tree a = Leaf a | Node a (Tree a) (Tree a) deriving (Show, Eq)

tree1 :: Tree Int
tree1 =
  Node 4
    (Node 2
      (Leaf 1)
      (Leaf 3)
    )
    (Node 11
      (Node 7
        (Leaf 5)
        (Node 9
          (Leaf 8)
          (Leaf 10)
        )
      )
      (Leaf 12)
    )

tree2 :: Tree Int
tree2 =
  Node 4
    (Node 2
      (Leaf 1)
      (Leaf 3)
    )
    (Node 8
      (Node 7
        (Leaf 5)
        (Node 9
          (Leaf 10)
          (Leaf 11)
        )
      )
      (Leaf 9)
    )

tree3 :: Tree Int
tree3 =
  Node 9
    (Leaf 8)
    (Leaf 10)


isSubtree :: Eq a => Tree a -> Tree a -> Bool
isSubtree = undefined

isOrdered :: Ord a => Tree a -> Bool
isOrdered = undefined

run :: IO ()
run = do
  putStrLn $ "Not implemented"
  -- putStrLn $ "Is tree2 subtree of tree1: " <> show (isSubtree tree2 tree1)
  -- putStrLn $ "Is tree3 subtree of tree1: " <> show (isSubtree tree3 tree1)
  -- putStrLn $ "isOrdered tree1: " <> show (isOrdered tree1)
  -- putStrLn $ "isOrdered tree2: " <> show (isOrdered tree2)
