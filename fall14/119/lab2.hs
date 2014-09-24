
-- CSci 119, Lab 2 --
-- Author: Brandon Lundberg
-- File Name: lab2.hs
-- Date: 14 Sept 2014

-- See https://piazza.com/class/hz53js0sjhm44z?cid=20 for definitions

import Data.List (sort, intersect)

-- normalize a list, i.e., sort and remove (now adjacent) duplicates
norm :: Ord a => [a] -> [a]
norm = mynub . sort where
  mynub [] = []
  mynub [x] = [x]
  mynub (x:ys@(y:zs)) | x == y = mynub ys
                      | otherwise = x : mynub ys

-- Invariant: Lists, when treated as sets, should be (recursively) normalized.
-- In particular, your functions should assume that all inputs are normalized,
-- and should insure that all outputs are normalized.
--------------------------------------------------------------------------------


-- Universe of discourse: this is being set to [1..4], but everything below
-- should be defined in terms of u and should work for any (finite, normalized)
-- list of Ints (including [])
u = [1..4]


-- eqrel r == True, if r is an equivalence relation on u, False otherwise
-- (you may assume that r is a relation on u)
refl :: [(Int,Int)] -> Bool
refl r = and [elem (a,a) r | a <- u]

symm :: [(Int,Int)] -> Bool
symm r = and [elem (b,a) r |(a,b) <- r]

trans :: [(Int,Int)] -> Bool
trans r = and [elem (a,c) r |(a,b1) <- r, (b2,c) <- r, b1 == b2]

eqrel :: [(Int,Int)] -> Bool
eqrel r = and [refl r && symm r && trans r]


-- part p == True, if p is a partition of u, False otherwise
-- (you may assume that every element of concat p is an element of u)
nontrivial :: [[Int]] -> Bool
nontrivial p = and [a /= [] | a <- p]

exhaustive :: [[Int]] -> Bool
exhaustive p = and [or [elem a x | x <- p] | a <- u]

disjoint :: [[Int]] -> Bool
disjoint p = and [intersect x y == [] | x <- p, y <- p, x /= y]

part :: [[Int]] -> Bool

part p = and[nontrivial p && exhaustive p && disjoint p]

-- eq_to_p r == the partition associated to r
-- (you may assume eqrel r == True)
eq_to_p :: [(Int,Int)] -> [[Int]]
eq_to_p r = norm [f a r| a <- u] where
		f a r = [b |(a1, b) <- r, a1 == a]
-- p_to_eq p == the equivalence relation associated to p
-- (you may assume part p == True)
p_to_eq :: [[Int]] -> [(Int,Int)]
p_to_eq p = [(a,b)| x <- p, a <- x, b <- x, elem a x && elem b x]

-- Test, on a "good" collection of cases, the equalities
--Main> :l lab2
--[1 of 1] Compiling Main             ( lab2.hs, interpreted )
--Ok, modules loaded: Main.
----- Eq(P(Eq)) -----
--Main> p_to_eq [[1,2],[3],[4]]
--[(1,1),(1,2),(2,1),(2,2),(3,3),(4,4)]
--Main> eq_to_p it
--[[1,2],[3],[4]]

--Main> p_to_eq [[1,2,3,4]]
--[(1,1),(1,2),(1,3),(1,4),(2,1),(2,2),(2,3),(2,4),(3,1),(3,2),(3,3),(3,4),(4,1),(4,2),(4,3),(4,4)]
--Main> eq_to_p it
--[[1,2,3,4]]

--Main> p_to_eq [[1],[2],[3],[4]]
--[(1,1),(2,2),(3,3),(4,4)]
--Main> eq_to_p it
--[[1],[2],[3],[4]]

--Main> p_to_eq [[1],[2,3,4]]
--[(1,1),(2,2),(2,3),(2,4),(3,2),(3,3),(3,4),(4,2),(4,3),(4,4)]
--Main> eq_to_p it
--[[1],[2,3,4]]

------ P(Eq(P)) ------
--Main> eq_to_p [(1,1),(2,2),(3,3),(4,4)]
--[[1],[2],[3],[4]]
--Main> p_to_eq it
--[(1,1),(2,2),(3,3),(4,4)]

--Main> eq_to_p [(1,1),(1,2),(2,1),(2,2),(1,3),(3,1),(2,3),(3,2),(3,3),(4,4)]
--[[1,2,3],[4]]
--Main> p_to_eq it
--[(1,1),(1,2),(1,3),(2,1),(2,2),(2,3),(3,1),(3,2),(3,3),(4,4)]

--Main> eq_to_p [(1,1),(1,2),(2,1),(2,2),(4,4),(3,3)]
--[[1,2],[3],[4]]
--Main> p_to_eq it
--[(1,1),(1,2),(2,1),(2,2),(3,3),(4,4)]

---------------------------------------------------------------------------
-- The only thing I noticed that my functions did not take into accout was order of
-- of the input. For example:

--Main> eq_to_p [(1,1),(1,3),(3,1),(1,2),(2,1),(2,3),(3,2),(2,2),(3,3),(4,4)]
--[[1,2,3],[1,3,2],[4]]
--Main> p_to_eq it
--[(1,1),(1,2),(1,3),(2,1),(2,2),(2,3),(3,1),(3,2),(3,3),(1,1),(1,3),(1,2),(3,1),(3,3),(3,2),(2,1),(2,3),(2,2),(4,4)]

-- Since the pair (1,2) was after the (3,1), it made a duplicate partition, but
-- in a different order that was not simplified correctly.
---------------------------------------------------------------------------