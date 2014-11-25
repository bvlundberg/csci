-- Brandon Lundberg
-- 16 Nov 2014
-- CSCI 119

-- Lab 10: Derivative-based conversion from RE' to FSM
-- Same set-up as in Lab 7, including RE' simplifier

import Data.List (sort,elemIndex,findIndices)

-- normalize a list, i.e., sort and remove (now adjacent) duplicates
norm :: Ord a => [a] -> [a]
norm = mynub . sort where
  mynub [] = []
  mynub [x] = [x]
  mynub (x:ys@(y:zs)) | x == y = mynub ys
                      | otherwise = x : mynub ys

sigma = ['a', 'b']
-- Ordinary regular expressions and a show method for them
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

-- Extended regular expressions, including a name for One = Star Empty,
-- and arbitrary numbers of arguments for (associative) Union and Cat
data RE' = Zero | One | Letter' Char | Union' [RE'] | Cat' [RE'] | Star' RE'
  deriving (Eq, Ord, Show)

-- Convert ordinary REs into extended REs
toRE' :: RE -> RE'
toRE' Empty         = Zero
toRE' (Letter c)    = Letter' c
toRE' (Union r1 r2) = Union' [toRE' r1, toRE' r2]
toRE' (Cat r1 r2)   = Cat' [toRE' r1, toRE' r2]
toRE' (Star r1)     = Star' (toRE' r1)

-- Convert extended REs into ordinary REs, eliminating Union' and Cat' on
-- lists of length < 2, and right-associating them on longer lists
toRE :: RE' -> RE
toRE Zero            = Empty
toRE One             = Star Empty
toRE (Letter' c)     = Letter c
toRE (Union' [])     = Empty
toRE (Union' [r])    = toRE r
toRE (Union' (r:rs)) = Union (toRE r) (toRE (Union' rs))
toRE (Cat' [])       = Star Empty
toRE (Cat' [r])      = toRE r
toRE (Cat' (r:rs))   = Cat (toRE r) (toRE (Cat' rs))
toRE (Star' r)       = Star (toRE r)

-- Basic postfix parser for RE', assuming binary + and ., for testing
re :: String -> RE'
re w = re' w [] where
  re' [] [r] = r
  re' ('0':xs) rs = re' xs (Zero:rs)
  re' ('1':xs) rs = re' xs (One:rs)
  re' ('+':xs) (r2:r1:rs) = re' xs (Union' [r1,r2]:rs)
  re' ('.':xs) (r2:r1:rs) = re' xs (Cat' [r1,r2]:rs)
  re' ('*':xs) (r:rs) = re' xs (Star' r:rs)
  re' (x:xs) rs = re' xs (Letter' x:rs)


-- FSMs indexed by the type of their states (states, start, final, transitions)
type FSM a = ([a], a, [a], [(a, Char, a)])

-- ap ts q a == the unique q' such that (q, a, q') is in ts;  assumes success
ap :: Eq a => [(a,Char,a)] -> a -> Char -> a
ap ((q1, a1, q2):ts) q a | q1 == q && a1 == a = q2
                         | otherwise = ap ts q a

-- An extended regular expression simplifier
simp :: RE' -> RE'
simp Zero = Zero
simp One = One
simp (Letter' c) = Letter' c
simp (Union' rs) = union' $ flat_uni $ map simp rs
simp (Cat' rs) = union' $ flat_cat $ map simp rs
simp (Star' r) = star' $ simp r

-- Smart constructor for Union' that normalizes its arguments and
-- handles the empty and singleton cases
union' :: [RE'] -> RE'
union' rs =  case norm rs of
  []  ->  Zero
  [r] -> r
  rs  -> Union' rs

-- Smart constructor for Cat' that handles the empty and singleton cases
cat' :: [RE'] -> RE'
cat' []  = One
cat' [r] = r
cat' rs  = Cat' rs

-- Smart constructor for Star' that handles the constant and Star' cases
star' :: RE' -> RE'
star' Zero      = One
star' One       = One
star' (Star' r) = star' r
star' r         = Star' r

-- Flatten a list of arguments to Union'; assumes each argument is simplified
flat_uni :: [RE'] -> [RE']
flat_uni []              = []
flat_uni (Zero:rs)       = flat_uni rs
flat_uni (Union' rs':rs) = rs' ++ flat_uni rs
flat_uni (r:rs)          = r : flat_uni rs

-- Flatten a list of arguments to Cat', turning them into a list of arguments
-- to Union'; assumes each argument is simplified
flat_cat :: [RE'] -> [RE']
flat_cat rs = fc [] rs where
  -- fc (args already processed, in reverse order) (args still to be processed)
  fc :: [RE'] -> [RE'] -> [RE']
  fc pr []              = [cat' $ reverse pr]
  fc pr (Zero:rs)       = []
  fc pr (One:rs)        = fc pr rs
  fc pr (Cat' rs':rs)   = fc (reverse rs' ++ pr) rs
  fc pr (Union' rs':rs) = concat $ map (fc pr . (:rs)) rs'
  fc pr (r:rs)          = fc (r:pr) rs


---------------- Lab 10 begins here ----------------

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
  fs' = [q | q <- qs, byp q]
  ts' = [(q, a, deriv a q) | q <- qs', a <- sigma]

-- Change the states of an FSM from an equality type to Int
intify :: Eq a => FSM a -> FSM Int
intify m@(qs, s, fs, ts) = (qs', s', fs', ts') where
  qs' = [0..(len - 1)] where len = length qs
  s' = 0
  fs' = [elemIndexInt a qs | a <- fs]
  ts' = norm [(elemIndexInt q qs, a, elemIndexInt q' qs) | a <- sigma, (q, a, q') <- ts]
  --ts' = tsHelper m qs'
-------------------------------------------------------------------------
elemIndexInt       :: Eq a => a -> [a] -> Int
elemIndexInt x ls = findIndexInt (x==) ls

findIndexInt       :: (a -> Bool) -> [a] -> Int
findIndexInt p ls = head (findIndices p ls)

--tsHelper :: Eq a => FSM a -> [Int] -> [(Int, Char, Int)]
--tsHelper _ [] = []
--tsHelper m@(qs, s, fs, ts) qs' = let oldq = head qs
--                                     newq = head qs'
--                                 in tsHelper ((tail qs), s, fs, ([(newq, a, q') | a <-sigma, (q, a, q') <- qs, q == oldq] ++ [(q, a, newq) | a <-sigma, (q, a, q') <- qs, q' == oldq] ++ [(newq, a, newq) | a <-sigma, (q, a, q') <- qs, q == oldq && q' == oldq] ++ ts)) (tail qs')

-- Test, and show your tests!
----------------------------------------------------------------
-- bypassable tests
test1 = Union' [Letter' 'a', Letter' 'b', One]
-- *Main> byp test1
-- True
test2 = Cat' [Letter' 'a', Letter' 'b', Letter' 'a', One]
-- *Main> byp test2
-- False
test3 = Cat' [One, One, One]
-- *Main> byp test3
-- True
------------------------------------------------------------------
-- deriv tests
-- *Main> deriv 'a' test3
-- Union' [Cat' [Zero,One,One],Union' [Cat' [Zero,One],Zero]]
test4 = Cat' [One, Letter' 'a', Letter' 'b']
-- *Main> deriv 'a' test4
-- Union' [Cat' [Zero,Letter' 'a',Letter' 'b'],Cat' [One,Letter' 'b']]
-- *Main> deriv 'b' test4
-- Union' [Cat' [Zero,Letter' 'a',Letter' 'b'],Cat' [Zero,Letter' 'b']]
test5 = Star' (Union' [(Cat' [(Letter' 'a'), (Letter' 'a')]),(Letter' 'b')])
-- *Main> deriv 'a' test5
-- Cat' [Union' [Cat' [One,Letter' 'a'],Zero],Star' (Union' [Cat' [Letter' 'a',Letter' 'a'],Letter' 'b'])]
-- *Main> deriv 'b' test5
-- Cat' [Union' [Cat' [Zero,Letter' 'a'],One],Star' (Union' [Cat' [Letter' 'a',Letter' 'a'],Letter' 'b'])]

------------------------------------------------------------------------------------------------------------------------------------
--intify tests

data LetterFSM = Lstart | Lfinal | Ltrap  deriving (Show, Eq, Ord)

letterFSM :: Char -> FSM LetterFSM
letterFSM c = ([Lstart, Lfinal, Ltrap], Lstart, [Lfinal], [(Lstart, c, Lfinal)] ++ [(Lstart, z, Ltrap) | z <- sigma, z /= c] ++ [(Lfinal, z, Ltrap) | z <- sigma] ++ [(Ltrap , z, Ltrap) | z <- sigma])

-- *Main> letterFSM 'a'
--([Lstart,Lfinal,Ltrap],Lstart,[Lfinal],[(Lstart,'a',Lfinal),(Lstart,'b',Ltrap),(Lfinal,'a',Ltrap),(Lfinal,'b',Ltrap),(Ltrap,'a',Ltrap),(Ltrap,'b',Ltrap)])
-- *Main> intify it
--([0,1,2],0,[1],[(0,'a',1),(0,'b',2),(1,'a',2),(1,'b',2),(2,'a',2),(2,'b',2)])


-- even number of a's and odd number of b's
-- the output of the intify function matches up with the definition I created for this example, except in the older version I set the start state at 1 instead of 0
-- to test it, I changed ex7 from a previous lab, which was an FSM Int, into a FSM Char, then ran the function.
-- the ex7 and ex7char are posted below, along with the result
ex7 :: FSM Int
ex7 = ([1,2,3,4,5,6,7,8,9],1,[1,3,5,8],[(1,'a',2),(1,'b',5),(2,'a',3),(2,'b',6),(3,'a',2),(3,'b',8),(4,'a',7),(4,'b',5),(5,'a',6),(5,'b',4),(6,'a',8),(6,'b',7),(7,'a',9),(7,'b',6),(8,'a',6),(8,'b',9),(9,'a',7),(9,'b',8)])

ex7Char :: FSM Char
ex7Char = (['a','b','c','d','e','f','g','h','i'],'a',['a','c','e','h'],[('a','a','b'),('a','b','e'),('b','a','c'),('b','b','f'),('c','a','b'),('c','b','h'),('d','a','g'),('d','b','e'),('e','a','f'),('e','b','d'),('f','a','h'),('f','b','g'),('g','a','i'),('g','b','f'),('h','a','f'),('h','b','i'),('i','a','g'),('i','b','h')])

-- *Main> intify ex7Char
-- ([0,1,2,3,4,5,6,7,8],0,[0,2,4,7],[(0,'a',1),(0,'b',4),(1,'a',2),(1,'b',5),(2,'a',1),(2,'b',7),(3,'a',6),(3,'b',4),(4,'a',5),(4,'b',3),(5,'a',7),(5,'b',6),(6,'a',8),(6,'b',5),(7,'a',5),(7,'b',8),(8,'a',6),(8,'b',7)])
