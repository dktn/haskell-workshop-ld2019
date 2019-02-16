module Workshop.TreeExamples where

import Workshop.Tree (Tree(..), tree1, tree2)

longestBranch :: Tree a -> Int
longestBranch (Leaf _)       = 0
longestBranch (Node _ t1 t2) = 1 + max (longestBranch t1) (longestBranch t2)

shortestBranch :: Tree a -> Int
shortestBranch (Leaf _)       = 0
shortestBranch (Node _ t1 t2) = 1 + min (shortestBranch t1) (shortestBranch t2)

run :: IO ()
run = do
  putStrLn $ "Longest  branch: " ++ show (longestBranch  tree1)
  putStrLn $ "Shortest branch: " ++ show (shortestBranch tree1)
