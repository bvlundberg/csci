-- Author: Brandon Lundberg
-- File Name: lab11.hs
-- Purpose: Simulate accepting strings given a RE
-- Date: 25 Nov 2014

import Criterion.Main
import Data.List (sort,elemIndex,findIndices,nub)

-- Extended regular expressions, including a name for One = Star Empty,
-- and arbitrary numbers of arguments for (associative) Union and Cat
data RE' = Zero | One | Letter' Char | Union' [RE'] | Cat' [RE'] | Star' RE'
  deriving (Eq, Ord, Show)
-- normalize a list, i.e., sort and remove (now adjacent) duplicates
norm :: Ord a => [a] -> [a]
norm = mynub . sort where
  mynub [] = []
  mynub [x] = [x]
  mynub (x:ys@(y:zs)) | x == y = mynub ys
                      | otherwise = x : mynub ys

strings :: Int -> [[Char]] 
strings 0 = [""]
strings n = concat [map (a:) (strings (n-1))| a <- sigma]
----------------The Expression-----------------------
ex1 :: RE
ex1 = Star(Union (Cat (Letter 'a') (Cat (Star (Cat (Letter 'b') (Cat (Star (Cat (Letter 'a') (Letter 'a'))) (Letter 'b')))) (Union (Letter 'a') (Cat (Letter 'b') (Cat (Star (Cat (Letter 'a') (Letter 'a'))) (Cat (Letter 'a') (Letter 'b')))))))(Cat (Letter 'b') (Cat (Star (Cat (Letter 'a') (Cat (Star (Cat (Letter 'b') (Letter 'b'))) (Letter 'a')))) (Union (Letter 'b') (Cat (Letter 'a') (Cat (Star (Cat (Letter 'b') (Letter 'b'))) (Cat (Letter 'b') (Letter 'a'))))))))

exBFSM :: BFSM
exBFSM = convBFSM ex1
-----------------------------------------------------

sigma = ['a','b']
data RE  = Empty | Letter Char | Union RE RE | Cat RE RE | Star RE
instance (Show RE) where    -- use precedence to minimize parentheses
  showsPrec d Empty         = showString "@"
  showsPrec d (Letter c)    = showString [c]
  showsPrec d (Union r1 r2) = showParen (d > 6) $  -- prec(Union) = 6
                              showsPrec 6 r1 .
                              showString "+" .
                              showsPrec 6 r2
  showsPrec d (Cat r1 r2)   = showParen (d > 7) $  -- prec(Cat) = 7
                              showsPrec 7 r1 .
                              showsPrec 7 r2
  showsPrec d (Star r1)     = showsPrec 9 r1 .     -- prec(Star) = 8
                              showString "*"

type FSM a = ([a], a, [a], [(a, Char, a)])

splits :: [a] -> [([a], [a])]
splits [] = [([],[])]
splits (w:rest) = ([], w:rest):map (\(ys1, ys2) -> (w:ys1, ys2)) (splits rest)

---------------------------------------------------------------
-- match function
match :: RE -> [Char] -> Bool
match Empty w = False
match (Letter c) [] = False
match (Letter c) (x:xs) = x == c && null xs
match (Union r1 r2) w = match r1 w || match r2 w
match (Cat r1 r2) w = any (\(w1, w2) -> match r1 w1 && match r2 w2) (splits w)
match (Star r1) w = null w || any (\(w1, w2) -> match r1 w1 && match (Star r1) w2) (tail (splits w))
---------------------------------------------------------------
-- match' function
matchhelper :: RE -> [Char] -> Bool
matchhelper r w = match' r w null

match' :: RE -> [Char] -> ([Char] -> Bool) -> Bool

match' Empty w k = False
match' (Letter c) [] k = False
match' (Letter c) (x:xs) k = x == c && k xs
match' (Union r1 r2) w k = match' r1 w k || match' r2 w k
match' (Cat r1 r2) w k = match' r1 w (\w' -> match' r2 w' k)
match' (Star r1) w k = k w || match' r1 w (\w' -> w' /= w && match' (Star r1) w' k)
---------------------------------------------------------------
-- Using derivation
-- Bypassable (aka has_epsilon) on extended REs, computed directly.
byp :: RE' -> Bool
byp Zero           = False
byp One            = True
byp (Letter' c)    = False
byp (Union' [r1])  = byp r1
byp (Union' (r1:rest)) = byp r1 || byp (Union' rest)
byp (Cat' [r1])    = byp r1
byp (Cat' (r1:rest))   = byp r1 && byp (Cat' rest)
byp (Star' r1)     = True

-- Regular-expression derivatives (aka left quotients) on extended REs,
-- computed directly. Should always return a simplified RE'.
deriv :: Char -> RE' -> RE'
deriv c Zero = Zero
deriv c One = Zero
deriv c (Letter' a) = if a == c then One else Zero
deriv c (Union' r1) = Union' (map (\a -> deriv c a) r1)
deriv c (Cat' [r1]) = deriv c r1
deriv c (Cat' (r1:rest)) = if byp r1 then Union' ([(Cat' ([(deriv c r1)] ++ rest))] ++ [deriv c (Cat' rest)]) else Cat' ([(deriv c r1)] ++ rest)
deriv c (Star' r1) = Cat' ([(deriv c r1)] ++ [Star' r1])

-- Find the list of all (simplified) derivatives of a regular expression
all_derivs r = stable $ iterate close ([r], []) where
  stable ((fr,rs):rest) = if null fr then rs else stable rest
  close (fr, rs) = (fr', rs') where  
    rs' = fr ++ rs
    fr' = nub $ filter (`notElem` rs') (concatMap step fr)
    step r = map (\a -> deriv a r) sigma
-- Convert an RE' to an FSM using the derivative construction
conv :: RE' -> FSM RE'
conv r = (qs', s', fs', ts') where
  qs' = all_derivs r
  s' = r
  fs' = [q | q <- qs', byp q]
  ts' = [(q, a, deriv a q) | q <- qs', a <- sigma]

---------------------------------------------------------------------------------------------------
(\/) :: Eq a => [a] -> [a] -> [a]    -- Union of lists
xs \/ ys = nub $ xs ++ ys

(?) :: Bool -> [a] -> [a]            -- Optional list
True ? xs = xs
False ? _ = []

type BFSM = ([Int], [(Int,Char,[Int])])

checkBFSM :: BFSM -> Bool
checkBFSM (ms, ts) = no_dups ms && tr_no_dups ts

no_dups :: [Int] -> Bool
no_dups [] = True           
no_dups (x:xs) = notElem x xs && no_dups xs

tr_no_dups :: [(Int,Char,[Int])] -> Bool
tr_no_dups [] = True
tr_no_dups ((n,a,ns):ts) = no_dups ns &&
                           notElem (n,a) [(n,a) | (n,a,_) <- ts] &&
                           tr_no_dups ts

ap :: [(Int,Char,[Int])] -> Int -> Char -> [Int]
ap [] q c = []
ap ((n,a,ns):ts) q c | q == n && c == a = ns
                     | otherwise = ap ts q c

aps :: [(Int,Char,[Int])] -> Int -> [Char] -> [Int]
aps ts q [] = [q]
aps ts q (a:as) = nub . concat . map (\n -> aps ts n as) $ ap ts q a

delta :: BFSM -> Int -> Char -> [Int]
delta (_, ts) = ap ts

delta_star :: BFSM -> Int -> [Char] -> [Int]
delta_star (_, ts) = aps ts

accept :: BFSM -> [Char] -> Bool
accept (ms,ts) w = elem 0 . concat $ map (\n -> aps ts n w) ms


-- Conversion
convBFSM :: RE -> BFSM
convBFSM r = (b?[0]\/ms,ts) where ((ms,ts),_,b) = convBFSM' r [1..] ([0],[])

convBFSM' :: RE -> [Int] -> BFSM -> (BFSM, [Int], Bool)
convBFSM' Empty ss m = (([],[]), ss, False)
convBFSM' (Letter c) (s:ss) (ms,ts) = (([s],(s,c,ms):ts), ss, False)
convBFSM' (Union r1 r2) ss m =
  let ((ms2,ts2), ss',  b2) = convBFSM' r2 ss  m
      ((ms1,ts1), ss'', b1) = convBFSM' r1 ss' m
  in ((ms2\/ms1,ts2\/ts1), ss'', b2||b1)
convBFSM' (Cat r1 r2) ss m@(ms,ts) =     
  let ((ms2,ts2), ss',  b2) = convBFSM' r2 ss m
      ((ms1,ts1), ss'', b1) = convBFSM' r1 ss' (b2?ms\/ms2,ts2)
  in ((b1?ms2\/ms1,ts2\/ts1), ss'', b2&&b1)
convBFSM' (Star r1) ss m@(ms,ts) =
  let ((ms1,ts1), ss', _) = convBFSM' r1 ss (ms1\/ms,ts)
  in ((ms1,ts1), ss', True)

{- mainMatch = defaultMain [bgroup "match1" [bench "1" $ whnf (match ex1) s | s <- strings 1], 
                        bgroup "match2" [bench "2" $ whnf (match ex1) s | s <- strings 2], 
                        bgroup "match3" [bench "3" $ whnf (match ex1) s | s <- strings 3], 
                        bgroup "match4" [bench "4" $ whnf (match ex1) s | s <- strings 4], 
                        bgroup "match5" [bench "5" $ whnf (match ex1) s | s <- strings 5], 
                        bgroup "match6" [bench "6" $ whnf (match ex1) s | s <- strings 6], 
                        bgroup "match7" [bench "7" $ whnf (match ex1) s | s <- strings 7], 
                        bgroup "match8" [bench "8" $ whnf (match ex1) s | s <- strings 8], 
                        bgroup "match9" [bench "9" $ whnf (match ex1) s | s <- strings 9], 
                        bgroup "match10" [bench "10" $ whnf (match ex1) s | s <- strings 10], 
                        bgroup "match11" [bench "11" $ whnf (match ex1) s | s <- strings 11], 
                        bgroup "match12" [bench "12" $ whnf (match ex1) s | s <- strings 12], 
                        bgroup "match13" [bench "13" $ whnf (match ex1) s | s <- strings 13], 
                        bgroup "match14" [bench "14" $ whnf (match ex1) s | s <- strings 14], 
                        bgroup "match15" [bench "15" $ whnf (match ex1) s | s <- strings 15], 
                        bgroup "match16" [bench "16" $ whnf (match ex1) s | s <- strings 16], 
                        bgroup "match17" [bench "17" $ whnf (match ex1) s | s <- strings 17], 
                        bgroup "match18" [bench "18" $ whnf (match ex1) s | s <- strings 18], 
                        bgroup "match19" [bench "19" $ whnf (match ex1) s | s <- strings 19], 
                        bgroup "match20" [bench "20" $ whnf (match ex1) s | s <- strings 20]]
-}
{-main = defaultMain [bgroup "matchBFSM1" [bench "1" $ whnf (accept exBFSM) s | s <- strings 1], 
                        bgroup "matchBFSM2" [bench "2" $ whnf (accept exBFSM) s | s <- strings 2], 
                        bgroup "matchBFSM3" [bench "3" $ whnf (accept exBFSM) s | s <- strings 3], 
                        bgroup "matchBFSM4" [bench "4" $ whnf (accept exBFSM) s | s <- strings 4], 
                        bgroup "matchBFSM5" [bench "5" $ whnf (accept exBFSM) s | s <- strings 5], 
                        bgroup "matchBFSM6" [bench "6" $ whnf (accept exBFSM) s | s <- strings 6], 
                        bgroup "matchBFSM7" [bench "7" $ whnf (accept exBFSM) s | s <- strings 7], 
                        bgroup "matchBFSM8" [bench "8" $ whnf (accept exBFSM) s | s <- strings 8], 
                        bgroup "matchBFSM9" [bench "9" $ whnf (accept exBFSM) s | s <- strings 9], 
                        bgroup "matchBFSM10" [bench "10" $ whnf (accept exBFSM) s | s <- strings 10], 
                        bgroup "matchBFSM11" [bench "11" $ whnf (accept exBFSM) s | s <- strings 11], 
                        bgroup "matchBFSM12" [bench "12" $ whnf (accept exBFSM) s | s <- strings 12], 
                        bgroup "matchBFSM13" [bench "13" $ whnf (accept exBFSM) s | s <- strings 13], 
                        bgroup "matchBFSM14" [bench "14" $ whnf (accept exBFSM) s | s <- strings 14], 
                        bgroup "matchBFSM15" [bench "15" $ whnf (accept exBFSM) s | s <- strings 15], 
                        bgroup "matchBFSM16" [bench "16" $ whnf (accept exBFSM) s | s <- strings 16], 
                        bgroup "matchBFSM17" [bench "17" $ whnf (accept exBFSM) s | s <- strings 17], 
                        bgroup "matchBFSM18" [bench "18" $ whnf (accept exBFSM) s | s <- strings 18], 
                        bgroup "matchBFSM19" [bench "19" $ whnf (accept exBFSM) s | s <- strings 19], 
                        bgroup "matchBFSM20" [bench "20" $ whnf (accept exBFSM) s | s <- strings 20]]
-}
{- main = defaultMain [bgroup "matchhelper1" [bench "1" $ whnf (matchhelper ex1) s | s <- strings 1], 
                        bgroup "matchhelper2" [bench "2" $ whnf (matchhelper ex1) s | s <- strings 2], 
                        bgroup "matchhelper3" [bench "3" $ whnf (matchhelper ex1) s | s <- strings 3], 
                        bgroup "matchhelper4" [bench "4" $ whnf (matchhelper ex1) s | s <- strings 4], 
                        bgroup "matchhelper5" [bench "5" $ whnf (matchhelper ex1) s | s <- strings 5], 
                        bgroup "matchhelper6" [bench "6" $ whnf (matchhelper ex1) s | s <- strings 6], 
                        bgroup "matchhelper7" [bench "7" $ whnf (matchhelper ex1) s | s <- strings 7], 
                        bgroup "matchhelper8" [bench "8" $ whnf (matchhelper ex1) s | s <- strings 8], 
                        bgroup "matchhelper9" [bench "9" $ whnf (matchhelper ex1) s | s <- strings 9], 
                        bgroup "matchhelper10" [bench "10" $ whnf (matchhelper ex1) s | s <- strings 10], 
                        bgroup "matchhelper11" [bench "11" $ whnf (matchhelper ex1) s | s <- strings 11], 
                        bgroup "matchhelper12" [bench "12" $ whnf (matchhelper ex1) s | s <- strings 12], 
                        bgroup "matchhelper13" [bench "13" $ whnf (matchhelper ex1) s | s <- strings 13], 
                        bgroup "matchhelper14" [bench "14" $ whnf (matchhelper ex1) s | s <- strings 14], 
                        bgroup "matchhelper15" [bench "15" $ whnf (matchhelper ex1) s | s <- strings 15], 
                        bgroup "matchhelper16" [bench "16" $ whnf (matchhelper ex1) s | s <- strings 16], 
                        bgroup "matchhelper17" [bench "17" $ whnf (matchhelper ex1) s | s <- strings 17], 
                        bgroup "matchhelper18" [bench "18" $ whnf (matchhelper ex1) s | s <- strings 18], 
                        bgroup "matchhelper19" [bench "19" $ whnf (matchhelper ex1) s | s <- strings 19], 
                        bgroup "matchhelper20" [bench "20" $ whnf (matchhelper ex1) s | s <- strings 20]]
-}


{-
  Could not get the benchmarking function to work the way I wanted it to. When trying 
  to run the test suites above, I get way too many results, which is not what was asked for the last. I was not able to 
  find a way to run a good amount of tests for each test group, even though the function was working. It was nice to see how the
  time grew for short strings, but it was not appropriate for the longer strings
-}