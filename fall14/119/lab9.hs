-- Brandon Lundberg
-- 3 Nov 2014
-- Lab 9: Non-deterministic finite state machines
-- Feel free to use any additional functions from previous labs

import Data.List (sort, nub, intersect, subsequences)

-- normalize a list, i.e., sort and remove (now adjacent) duplicates
norm :: Ord a => [a] -> [a]
norm = mynub . sort where
  mynub [] = []
  mynub [x] = [x]
  mynub (x:ys@(y:zs)) | x == y = mynub ys
                      | otherwise = x : mynub ys

-- Sigma = [a,b] for testing, but must work for any finite list
sigma :: [Char]
sigma = ['a', 'b']

-- Finite State Machines
type FSM a  = ([a], a,   [a], [(a, Char,  a)]) -- function: a x Char -> a

-- ap ts q a == the unique q' such that (q, a, q') is in ts;  assumes success
ap :: Eq a => [(a,Char,a)] -> a -> Char -> a 
ap ((q1, a1, q2):ts) q a | q1 == q && a1 == a = q2
                         | otherwise = ap ts q a

power :: [a] -> [[a]]
power = subsequences 
----------------------------------------------------------------
-- Nondeterministic FSMs
type NFSM a = ([a], [a], [a], [(a, Char,  a)]) -- relation: a x Char x a

ndelta_star :: Eq a => NFSM a -> a -> [Char] -> [a]
ndelta_star m@(qs1, s1, fs1, ds1) q [] = [q]
ndelta_star m@(qs1, s1, fs1, ds1) q (a:as) = qs'' where
    qs' = [q'| q' <- qs1, elem (q, a, q') ds1] 
    qs'' = concat [ndelta_star m q' as | q' <- qs']


naccept :: Eq a => NFSM a -> [Char] -> Bool
naccept m@(qs1, s1, fs1, ds1) as = or [ (intersect xs fs1) /= [] | xs <- [ ndelta_star m s as | s <- s1 ] ]

----------------------------------------------------------------
-- Nondeterministic FSMs with epsilon moves

data CharE = Eps | Chr Char deriving Eq 
type EFSM a = ([a], [a], [a], [(a, CharE, a)]) -- relation: a x CharE x a

-- Epsilon closure of a set of states (Hint: look at reachable below)
eclose :: Eq a => EFSM a -> [a] -> [a]
eclose m [] = []
eclose m@(qs1, s1, fs1, ds1) xs = xe where
  xe = xs ++ eclose m [ q | q <- qs1, x <- xs, elem(x, Eps, q) ds1 ]

edelta_star :: Eq a => EFSM a -> a -> [Char] -> [a]
edelta_star m@(qs1, s1, fs1, ds1) q [] = [q]
edelta_star m@(qs1, s1, fs1, ds1) q (a:as) = qs'' where
    qe = eclose m [q]
    qs' = [q'| qe' <- qe, q' <- qs1, elem (qe', Chr a, q') ds1]
    qse' = eclose m qs'
    qs'' = concat [edelta_star m q' as | q' <- qse']

eaccept :: Eq a => EFSM a -> [Char] -> Bool
eaccept m@(qs1, s1, fs1, ds1) as = or [ (intersect xs fs1) /= [] | xs <- [edelta_star m s as | s <- s1] ]


----------------------------------------------------------------
-- Machine conversions

-- Easy conversion from FSM to NFSM
fsm_to_nfsm :: Eq a => FSM a -> NFSM a
fsm_to_nfsm (qs1, s1, fs1, ts1) = (qs1, [s1], fs1, ts1)

-- Conversion from NFSM to FSM by the "subset construction"
nfsm_to_fsm :: Ord a => NFSM a -> FSM [a]
nfsm_to_fsm m@(qs1, s1, fs1, ts1) = (qs, s, fs, ts) where
          qs = power qs1
          s = s1
          fs = [q | q <- qs, intersect q fs1 /= []]
          ts = [(q, a, step m q a) | a <- sigma, q <- qs]

step :: Ord a => NFSM a -> [a] -> Char -> [a]
step m@(qs1, s1, fs1, ts1) q a = [q'' | q' <- q, q'' <- qs1, elem (q', a, q'') ts1]

-- Conversion from EFSM to FSM by epsilon elimination (and subset construction)
enfsm_to_fsm :: Ord a => EFSM a -> FSM [a]
enfsm_to_fsm m@(qs1, s1, fs1, ts1) = (qs, s, fs, ts) where
          qs = [q' | q' <- power qs1, (norm $ eclose m q') == q']
          s =  norm $ eclose m s1
          fs = [q | q <- qs, intersect q fs1 /= []]
          ts = [(q, a, stepE m q a) | a <- sigma, q <- qs]

stepE :: Ord a => EFSM a -> [a] -> Char -> [a]
stepE m@(qs1, s1, fs1, ts1) q a = [q'' | q' <- q, q'' <- qs1, elem (q', Chr a, q'') ts1]

----------------------------------------------------------------
-- Reachability (from Lab 6)

-- reachable m == the part of m that is reachable from the start state
reachable :: Ord a => FSM a -> FSM a
reachable m@(qs, s, fs, d) = (qs', s, fs', d') where
  qs' = sort $ stable $ iterate close ([s], [])
  fs' = filter (`elem` qs') fs
  d'  = filter (\(q,_,_) -> q `elem` qs') d
  stable ((fr,qs):rest) = if null fr then qs else stable rest
  -- in close (fr, xs), fr (frontier) and xs (current closure) are disjoint
  close (fr, xs) = (fr', xs') where  
    xs' = fr ++ xs
    fr' = norm $ filter (`notElem` xs') (concatMap step fr)
    step q = map (ap d q) sigma

ex1 :: NFSM Int
ex1 = ([1,2,3,4,5,6,7,8,9], [1,2,4,5], [9], [(1, 'a', 1), (1, 'a', 2), (1, 'a', 4), (1, 'a', 5),
                                             (2, 'b', 3),
                                             (3, 'a', 1), (3, 'a', 2), (3, 'a', 4), (3, 'a', 5),
                                             (4, 'a', 4), (4, 'a', 5),
                                             (5, 'b', 6), (5, 'b', 7), (5, 'b', 9),
                                             (6, 'b', 6), (6, 'b', 7), (6, 'b', 9),
                                             (7, 'b', 6), (7, 'b', 7), (7, 'b', 8), (7, 'b', 9),
                                             (8, 'a', 6), (8, 'a', 7), (8, 'a', 8), (8, 'a', 9)])

ex2 :: EFSM Int
ex2 = ([0,1,2,3,4,5,6,7,8], [0], [8], [(0,Eps,1),
                                       (1,Eps,2), (1,Chr 'a',3), 
                                       (2,Chr 'a',4), 
                                       (3,Eps,5), (3,Chr 'b',4),
                                       (4,Chr 'b',6), 
                                       (5,Chr 'b',6), (5,Chr 'b',7), 
                                       (7,Eps,8)])

ts :: [(Int,CharE,Int)]
ts = [(0,Eps,1), (1,Eps,2), (1,Chr 'a',3), (2,Chr 'a',4), (3,Eps,5), (3,Chr 'b',4), (4,Chr 'b',6), (5,Chr 'b',6), (5,Chr 'b',7), (7,Eps,8)]

ex3 :: NFSM Char
ex3 = (['s','t','u'], ['s','t'], ['u'], [('s', 'a', 't'), ('s', 'a', 'u'), ('t', 'b', 's'), ('t', 'b', 'u')])

ex4 :: NFSM Int
ex4 = ([1,2,3], [1,2], [3], [(1, 'a', 2), (1, 'a', 3), (2, 'b', 1), (2, 'b', 3)])

ex5 :: EFSM Char
ex5 = (['s','t','u'], ['s','t'], ['u'], [('s', Chr 'a', 't'), ('s', Chr 'a', 'u'), ('u', Eps, 's'), ('u', Eps, 't')])