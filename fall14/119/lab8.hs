-- Brandon Lundberg
-- 27 Nov 2014
-- Lab 8: REG closure under other operations

-- Could not quite figure out how the input works on the himage and hinvimage functions, especially separating the char and [char]
import Data.List (sort)
sigma = ['a','b']

data RE  = Empty | Letter Char | Union RE RE | Cat RE RE | Star RE deriving Show
type FSM a = ([a], a, [a], [(a, Char, a)])

norm :: Ord a => [a] -> [a]
norm = mynub . sort where
  mynub [] = []
  mynub [x] = [x]
  mynub (x:ys@(y:zs)) | x == y = mynub ys
                      | otherwise = x : mynub ys

(><) :: [a] -> [b] -> [(a,b)]              -- Cartesian product
xs >< ys = [(x,y) | x <- xs, y <- ys] 

delta :: Ord a => FSM a-> a -> Char -> a
delta (_,_,_,ts) q a = find ts q a

find :: Ord a => [(a,Char,a)] -> a -> Char -> a
find ts q a = head [q2 | (q1, x, q2) <- ts, q1 == q && x == a]

-- gives the delta* function
delta_star :: Ord a => FSM a-> a -> [Char] -> a
delta_star _ q [] = q
delta_star m q (w:ws) = delta_star m (delta m q w) ws

-- has_epsilon r = True iff epsi in [[r]]; useful in defining leftq below
is_empty :: RE -> Bool
is_empty Empty = True
is_empty (Letter c) = False
is_empty (Union r1 r2) = is_empty r1 && is_empty r2
is_empty (Cat r1 r2) = is_empty r1 || is_empty r2
is_empty (Star r) = False

is_one :: RE -> Bool
is_one Empty = False
is_one (Letter c) = False
is_one (Union r1 r2) = let e1 = is_empty r1; o1 = is_one r1
                           e2 = is_empty r2; o2 = is_one r2
                       in e1 && o2 || e2 && o1 || o1 && o2
is_one (Cat r1 r2) = is_one r1 && is_one r2
is_one (Star r) = is_empty r

has_epsilon :: RE -> Bool
has_epsilon Empty = False
has_epsilon (Letter c) = False
has_epsilon (Union r1 r2) = has_epsilon r1 || has_epsilon r2
has_epsilon (Cat r1 r2) = has_epsilon r1 && has_epsilon r2
has_epsilon (Star r) = True

is_infinite :: RE -> Bool
is_infinite Empty = False
is_infinite (Letter c) = False
is_infinite (Union r1 r2) = is_infinite r1 || is_infinite r2
is_infinite (Cat r1 r2) = is_infinite r1 && not (is_empty r2) ||
                          is_infinite r2 && not (is_empty r1)
is_infinite (Star r) = not (is_empty r || is_one r)

-- Implement each of the following operations on regular expressions or FSMs

-- [[reverseRE r]] = rev([[r]]), defined by recursion on r
reverseRE :: RE -> RE
reverseRE Empty = Empty
reverseRE (Letter c) = Letter c
reverseRE (Union r1 r2) = Union (reverseRE r1) (reverseRE r2)
reverseRE (Cat r1 r2) = Cat (reverseRE r2) (reverseRE r1)
reverseRE (Star r) = Star (reverseRE r)

-- L(complementFSM M) = Sigma^* - L(M)
complementFSM :: Ord a => FSM a -> FSM a
complementFSM m@(qs,s,fs,ds) = (qs',s',fs',ds') where
	qs' = qs
	s' = s
	fs' = norm [q |q <- qs, notElem q fs]
	ds' = ds
-- L(intersectFSM m1 m2) = L(m1) intersect L(m2)
intersectFSM :: (Ord a, Ord b) => FSM a -> FSM b -> FSM (a,b)
intersectFSM m1@(qs1,s1,fs1,ds1) m2@(qs2,s2,fs2,ds2) = (qs',s',fs',ds') where
	qs' = qs1 >< qs2
	s' = (s1,s2)
	fs' = [q | q <- qs', elem (fst q) fs1 && elem (snd q) fs2]
	ds' = [(q, a, ((delta m1 (fst q) a), (delta m2 (snd q) a))) | q <- qs', a <- sigma]

-- [[himage r h]] = h^*([[r]]), defined by recursion on r
himage :: RE -> (Char -> [Char]) -> RE
himage Empty xs = Empty
himage (Letter a) xs = (Letter (himage a xs))
himage (Union r1 r2) xs = (Union (himage r1 xs) (himage r2 xs))
himage (Cat r1 r2) xs = (Cat (himage r1 xs) (himage r2 xs))
himage (Star r) xs = (Star (himage r xs))

-- L(hinvimage m h) = (h^*)^{-1}(L(m))
hinvimage :: Ord a => FSM a -> (Char -> [Char]) -> FSM a
hinvimage m@(qs1,s1,fs1,ds1) xs = (qs, s, fs, ds) where
	qs = undefined
	s = undefined
	fs = undefined
	ds = undefined

-- L(rightq m a) = { w | wa in L(m) }
rightq :: Ord a => FSM a -> Char -> FSM a
rightq m@(qs1,s1,fs1,ds1) a = (qs',s',fs',ds') where
	qs' = qs1
	s' = s1
	fs' = norm [delta m f a | f <- fs1]
	ds' = ds1

-- [[leftq r a]] = { w | aw in [[r]] }, defined by recursion on r
leftq :: RE -> Char -> RE
leftq Empty a = (Letter a)
leftq (Letter c) a = (Cat (Letter a) (Letter c))
leftq (Union r1 r2) a = (Cat (Letter a) (Union r1 r2))
leftq (Cat r1 r2) a = (Cat (Letter a) (Cat r1 r2))
leftq (Star r) a = (Cat (Letter a) (Star r))


ex5 :: FSM Int
ex5 = ([1,2,3,4,5], 1, [1,2,3,4], [(1,'a',1),(1,'b',2),(2,'a',1),(2,'b',3),(3,'a',4),(3,'b',3),(4,'a',5),(4,'b',3),(5,'a',5),(5,'b',5)])
-- qs, s, fs, ts
-- Exercise 6: no instance of aba
ex6 :: FSM Int
ex6 = ([1,2,3,4],1,[1,2,3],[(1,'a',2),(1,'b',1),(2,'a',2),(2,'b',3),(3,'a',4),(3,'b',1),(4,'a',4),(4,'b',4)])

-- Exercise 7: even number of a's and odd number of b's
ex7 :: FSM Int
ex7 = ([1,2,3,4,5,6,7,8,9],1,[1,3,5,8],[(1,'a',2),(1,'b',5),(2,'a',3),(2,'b',6),(3,'a',2),(3,'b',8),(4,'a',7),(4,'b',5),(5,'a',6),(5,'b',4),(6,'a',8),(6,'b',7),(7,'a',9),(7,'b',6),(8,'a',6),(8,'b',9),(9,'a',7),(9,'b',8)])