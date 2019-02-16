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
isSubtree (Node _ _ _) (Leaf _) = False
isSubtree d1 d2@(Node _ t1 t2)  = d1 == d2 || isSubtree d1 t1 || isSubtree d1 t2

isOrdered :: Ord a => Tree a -> Bool
isOrdered t = fst $ isOrderedMinMax t
  where
    isOrderedMinMax :: Ord a => Tree a -> (Bool, (a, a))
    isOrderedMinMax (Leaf a)       = (True, (a, a))
    isOrderedMinMax (Node a t1 t2) = (t1Ord && t2Ord && a > max1 && a <= min2, (min1, max2))
      where
        (t1Ord, (min1, max1)) = isOrderedMinMax t1
        (t2Ord, (min2, max2)) = isOrderedMinMax t2

run :: IO ()
run = do
  putStrLn $ "Is tree2 subtree of tree1: " <> show (isSubtree tree2 tree1)
  putStrLn $ "Is tree3 subtree of tree1: " <> show (isSubtree tree3 tree1)
  putStrLn $ "isOrdered tree1: " <> show (isOrdered tree1)
  putStrLn $ "isOrdered tree2: " <> show (isOrdered tree2)
