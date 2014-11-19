-- 	Author: Brandon Lundberg
--	File Name: lab3.hs
-- 	Date: 15 Sept 2014

import Data.List (sort, inits, tails, intersect)

-- normalize a list, i.e., sort and remove (now adjacent) duplicates
norm :: Ord a => [a] -> [a]
norm = mynub . sort where
  mynub [] = []
  mynub [x] = [x]
  mynub (x:ys@(y:zs)) | x == y = mynub ys
                      | otherwise = x : mynub ys

-- Not needed, String is already defined in the Preludene
-- type String = [Char]

-- Define the length and concatenation operators for String
mylen :: String -> Int
mylen [] = 0
mylen (s:rest) = 1 + mylen rest

myconcat :: String -> String -> String
myconcat [] [] = []
myconcat [] b = (head b:myconcat [] (tail b))
myconcat a b = (head a:myconcat (tail a) b)

-- Define the following languages/operations on languages

-- The empty language
zero :: Language
zero = []

-- The singleton language
one :: Language
one = [""]

-- The concatenation of two languages
cat :: Language -> Language -> Language
cat l1 l2  = [myconcat w1 w2 | w1 <- l1, w2 <- l2]

-- The union of two languages
uni :: Language -> Language -> Language
uni [] l2 = l2
uni l1 l2  = if elem (head l1) l2 then (uni (tail l1) l2)
	       									 else (head l1:uni (tail l1) l2)

-- The bounded Kleene star (all self-concatenations up to n)
bstar :: Language -> Int -> Language
bstar l 0 = one
bstar l n = (bstar l (n-1)) `uni` (pow l n)

pow :: Language -> Int -> Language
pow l 0 = one
pow l n = cat l (pow l (n-1))

-- The right-quotient of rwo languages
rightq :: Language -> Language -> Language
rightq l1 l2  = norm [a | x <- l1,  w <- l2, a <- tails w, (elem (myconcat x a) l2)]

-- The left-quotient of two languages
leftq :: Language -> Language -> Language
leftq l1 l2 = norm [a | x <- l1,  w <- l2, a <- inits w, (elem (myconcat a x) l2)]

-- Unofficial extra credit question: Define the *unbounded* Kleene 
-- star operation:
kleene :: Language -> Language
kleene l = undefined