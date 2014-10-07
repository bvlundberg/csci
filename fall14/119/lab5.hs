-- Brandon Lundberg --
-- Lab 5 --
-- 30 Sept 2014 --

import Data.List (sort, stripPrefix)
sigma = ['a', 'b']  


-- normalize a list, i.e., sort and remove (now adjacent) duplicates
norm :: Ord a => [a] -> [a]
norm = mynub . sort where
  mynub [] = []
  mynub [x] = [x]
  mynub (x:ys@(y:zs)) | x == y = mynub ys
                      | otherwise = x : mynub ys
---------------- Part 1 ----------------

-- these functions should work with any sigma (not just ['a','b'])

-- Finite State Machine M = (Q, s, F, d) with Ints as states
type FSM = ([Int], Int, [Int], [(Int,Char,Int)])

-- checks whether a finite state machine (qs, s, fs, ts) is correct/complete:
-- (1) States qs are unique (no duplicates)
-- (2) Start state is a state (s is in qs)
-- (3) Final states are states (fs is a subset of qs)
-- (4) Transition relation is a function from qs and sigma to qs
checkFSM :: FSM -> Bool
checkFSM (qs, s, fs, ts) = norm qs == qs && elem s qs && subset fs qs && transition ts qs

subset :: [Int] -> [Int] -> Bool
subset as bs = and[elem a bs| a <- as]

transition :: [(Int,Char,Int)] -> [Int] -> Bool
transition ts qs = and [elem q1 qs && elem q2 qs && elem x sigma| (q1, x, q2) <- ts]


-- The rest of the functions below assume that FSMs are correct and
-- all Chars are elements of sigma (i.e., there is no need to check)


-- gives the transition function of the machine m as a function
-- i.e., delta m q a = the state m goes to when reading a in state q
delta :: FSM -> Int -> Char -> Int
delta (_,_,_,ts) q a = find ts q a

find :: [(Int,Char,Int)] -> Int -> Char -> Int
find ts q a = head [q2 | (q1, x, q2) <- ts, q1 == q && x == a]

-- gives the delta* function
delta_star :: FSM -> Int -> [Char] -> Int
delta_star _ q [] = q
delta_star m q (w:ws) = delta_star m (delta m q w) ws

-- accept1 m w = "w in L(m)", defined in terms of delta*
accept1 :: FSM -> [Char] -> Bool
accept1 m@(_,s,fs,_) w = elem (delta_star m s w) fs

-- accept2_aux m q w = whether m, starting in q, accepts w (recursive in w)
accept2_aux :: FSM -> Int -> [Char] -> Bool
accept2_aux m@(_,_,fs,_) q [] = if elem q fs then True
								else False
accept2_aux m q (w:ws) = accept2_aux m (delta m q w) ws

-- defined (non-recursively) in terms of accept2_aux
accept2 :: FSM -> [Char] -> Bool
accept2 m@(qs,s,fs,ts) w = accept2_aux m s w


--
---------------- Part 2 ----------------

-- Define FSMs that accepts (all and only) the indicated strings,
-- assuming that sigma = ['a','b'].  Test each function adequately.

-- Exercise 5: every instance of aa coming before every instance of bb
ex5 :: FSM
ex5 = ([1,2,3,4,5], 1, [1,2,3,4], [(1,'a',1),(1,'b',2),(2,'a',1),(2,'b',3),(3,'a',4),(3,'b',3),(4,'a',5),(4,'b',3),(5,'a',5),(5,'b',5)])
-- qs, s, fs, ts
-- Exercise 6: no instance of aba
ex6 :: FSM
ex6 = ([1,2,3,4],1,[1,2,3],[(1,'a',2),(1,'b',1),(2,'a',2),(2,'b',3),(3,'a',4),(3,'b',1),(4,'a',4),(4,'b',4)])

-- Exercise 7: even number of a's and odd number of b's
ex7 :: FSM
ex7 = ([1,2,3,4,5,6,7,8,9],1,[1,3,5,8],[(1,'a',2),(1,'b',5),(2,'a',3),(2,'b',6),(3,'a',2),(3,'b',8),(4,'a',7),(4,'b',5),(5,'a',6),(5,'b',4),(6,'a',8),(6,'b',7),(7,'a',9),(7,'b',6),(8,'a',6),(8,'b',9),(9,'a',7),(9,'b',8)])

word1 :: [Char]
word1 = ['a','b','a']

word2 :: [Char]
word2 = ['a','b','b','a','a','b','b']

word3 :: [Char]
word3 = ['b','a','a','b','b']

word4 :: [Char]
word4 = ['a','a','a','a']
