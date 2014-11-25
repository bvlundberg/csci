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
ex1 = Star(Union (Cat (Letter 'a') (Cat (Star (Cat (Letter 'b') (Cat (Star (Cat (Letter 'a') (Letter 'a'))) (Letter 'b')))) (Union (Letter 'a') (Cat (Letter 'b') (Cat (Star (Cat (Letter 'a') (Letter 'a'))) (Cat (Letter 'a') (Letter 'b')))))))(Cat (Letter 'b') (Cat (Star (Cat (Letter 'a') (Cat (Star (Cat (Letter 'b') (Letter 'b'))) (Letter 'a')))) (Union (Letter 'b') (Cat (Letter 'a') (Cat (Star (Cat (Letter 'b') (Letter 'b'))) (Cat (Letter 'b') (Letter 'a'))))))))

-----------------------------------------------------

sigma = ['a','b']
data RE  = Empty | Letter Char | Union RE RE | Cat RE RE | Star RE deriving Show
type FSM a = ([a], a, [a], [(a, Char, a)])

splits :: [a] -> [([a], [a])]
splits [] = [([],[])]
splits (w:rest) = ([], w:rest):map (\(ys1, ys2) -> (w:ys1, ys2)) (splits rest)

---------------------------------------------------------------
match :: RE -> [Char] -> Bool
match Empty w = False
match (Letter c) [] = False
match (Letter c) (x:xs) = x == c && null xs
match (Union r1 r2) w = match r1 w || match r2 w
match (Cat r1 r2) w = any (\(w1, w2) -> match r1 w1 && match r2 w2) (splits w)
match (Star r1) w = null w || any (\(w1, w2) -> match r1 w1 && match (Star r1) w2) (tail (splits w))
---------------------------------------------------------------
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

