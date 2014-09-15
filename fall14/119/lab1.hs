---- CSci 119, Lab 1 ----
-- Brandon Lundberg --
-- 4 Sept 2014 --

-- Note: you will replace all instances of "undefined" below with your answers.


---- Boolean operators

-- The following code tests whether "and" is commutative:
bools = [True, False]
and_commutes = and [(p && q) == (q && p) | p <- bools, q <- bools]

-- Write similar defintions that test whether "or" is commutative,
-- "and" and "or" are associative, "and" distributes over "or",
-- "or" distributes over "and"
or_commutes = and  [(p || q) == (q || p) | p <- bools, q <- bools]
and_assoc = and [((p && q) && r) == (p && (q  && r)) | p <- bools, q <- bools, r <- bools]
or_assoc = and [((p || q) || r) == (p || (q  || r)) | p <- bools, q <- bools, r <- bools]
and_dist = and [(p && (q || r)) == ((p && q) || (p && r)) | p <- bools, q <- bools, r <- bools]
or_dist = and [(p || (q && r)) == ((p || q) && (p || r)) | p <- bools, q <- bools, r <- bools]
          
-- Define an exclusive-or operation (^$) on Booleans and investigate
-- the properties of this operation (commutativity, associativity,
-- distributivity over and/or, and distributivity of and/or over it)
(^$) :: Bool -> Bool -> Bool
(^$) True True = False
(^$) True False = True
(^$) False True = True
(^$) False False = False

xor_commutes = and [(p ^$ q) == (q ^$ p) | p <- bools, q <- bools]
xor_assoc    = and [((p ^$ q) ^$ r) == (p ^$ (q  ^$ r)) | p <- bools, q <- bools, r <- bools]
xor_dist_and = and [(p ^$ (q && r)) == ((p ^$ q) && (p ^$ r)) | p <- bools, q <- bools, r <- bools]
xor_dist_or  = and [(p ^$ (q || r)) == ((p ^$ q) || (p ^$ r)) | p <- bools, q <- bools, r <- bools]
and_dist_xor = and [(p && (q ^$ r)) == ((p && q) ^$ (p && r)) | p <- bools, q <- bools, r <- bools]
or_dist_xor  = and [(p || (q ^$ r)) == ((p || q) ^$ (p || r)) | p <- bools, q <- bools, r <- bools]
               

-- Define the implication operation (^>) on Booleans and investigate
-- whether this operation is commutative and/or associative
(^>) :: Bool -> Bool -> Bool
(^>) True True = True
(^>) True False = False
(^>) False True = True
(^>) False False = True

imp_commutes = and [(p ^> q) == (q ^> p) | p <- bools, q <- bools]
imp_assoc    = and [((p ^> q) ^> r) == (p ^> (q ^> r)) | p <- bools, q <- bools, r <- bools]


----- Evaluating statements involving quantifiers

-- Assume that the universe of discourse is the set {1,2,3,4}, that is,
-- that the word "number" temporarily means 1, 2, 3, or 4.

u = [1..4]


-- Translate each of the following statements first, in a comment, into a
-- logical statement involving forall, exists, and, or, imp, and not,
-- and then into Haskell code that checks ("brute force") whether
-- the statement is true. I'll work one example.


-- 1. "Every number that's greater than 2 is greater than 1"
-- A: forall n, (n > 2) imp (n > 1)
prob1 = and [(n > 2) ^> (n > 1) | n <- u]

-- 2. Every number is either greater than 1 or less than 2
-- A: forall n, (n > 1) or (n < 2)
prob2 = and [(n > 1) || (n < 2) | n <- u]

-- 3. Every two numbers are comparable with <= (i.e., either one is <=
--    the other or vice-versa)
-- A: for all x and y, x <= y or y <= x
prob3 = and [(x <= y) || (y <= x) | x <- u, y <- u]

-- 4. For every odd number, there is a greater even number (use the Haskell
--    predicates odd, even :: Integral a => a -> Bool)
-- A: for all odd x,  there exists an even y such that y > x
prob4 = and [or [x < y | y <- u, even y] | x <- u, odd x]

-- 5. For every even number, there is a greater odd number
-- A: for all even y,  there exists an odd x such that x > y
prob5 = and [or [y < x | x <- u, odd x] | y <- u, even y]

-- 6. There are two odd numbers that add up to 6
-- A: there exists an odd x and odd y such that x+y = 6
prob6 = or [x + y == 6 | x <- u, y <- u, odd x, odd y]

-- 7. There is a number that is at least as large as every number
--    (i.e., according to >=)
-- A: there exists a y, for all x, such that y >= x
prob7 = or [ and [y >= x | x <- u] | y <- u]

-- 8. For every number, there is a different number such that there are no
--    numbers between these two.
-- A: for all x, there exists a y such that x+1=y or x-1=y
prob8 = and [ or[x + 1 == y || x - 1 == y| y <- u]| x <- u]
