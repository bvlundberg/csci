-- Simulation Program 1
-- Brandon Lundberg
-- 5 Nov 2014
import Data.List
------------ Helper functions ----------------
-- Takes the nth element from a list
nthel :: Int -> [Int] -> Int
nthel n xs = last (take n xs)

tuples :: [Int] -> [Int] -> [(Int, Int)]
tuples [] [] = []
tuples (a:as) (b:bs) = [(a,b)] ++ tuples as bs

orList :: [Int] -> Int
orList [] = 0
orList (x:xs) = if (x == 1) then 1
				else orList xs
----------------------------------------------
andGate :: Int -> Int -> Int
andGate a b = if a == 1 && b == 1 then 1
			  else 0

orGate :: Int -> Int -> Int
orGate a b = if a == 0 && b == 0 then 0
			 else 1

notGate :: Int -> Int
notGate a = if a == 1 then 0
		    else 1

xorGate :: Int -> Int -> Int
xorGate a b = if a == b then 0
			  else 1

mux2x1 :: Int -> Int -> Int -> Int
mux2x1 a b selector = result where
			and1 = andGate a (notGate selector)
			and2 = andGate b selector
			result = orGate and1 and2
decoder2bit :: Int -> [Int]
decoder2bit selector | selector == 0 = [1, 0, 0, 0] 
					 | selector == 1 = [0, 1, 0, 0]
					 | selector == 2 = [0, 0, 1, 0]
					 | selector == 3 = [0, 0, 0, 1]

mux4x1 :: Int -> Int -> Int -> Int -> Int -> Int
mux4x1 a b c d selector = result where
			decodedList = decoder2bit selector
			and1 = andGate a $ nthel 1 decodedList
			and2 = andGate b $ nthel 2 decodedList
			and3 = andGate c $ nthel 3 decodedList
			and4 = andGate d $ nthel 4 decodedList
			or1 = orGate and1 and2
			or2 = orGate and3 and4
			result = orGate or1 or2

fullAdder :: Int -> Int -> Int -> (Int, Int)
fullAdder a b cin = (addSum, cout) 	where
			xor1 = xorGate a b
			addSum = xorGate xor1 cin
			and1 = andGate a b
			and2 = andGate xor1 cin
			cout = orGate and1 and2

alu1bit :: (Int, Int) -> Int -> Int -> Int -> Int -> Int -> (Int, Int)
alu1bit (a, b) selector ainv binv cin less = (result, cout) where
			mux2x1_1 = mux2x1 a (notGate a) ainv
			mux2x1_2 = mux2x1 b (notGate b) binv
			and1 = andGate mux2x1_1 mux2x1_2
			or1 = orGate mux2x1_1 mux2x1_2
			adder1 = fullAdder mux2x1_1 mux2x1_2 cin
			cout = snd adder1
			result = mux4x1 and1 or1 (fst adder1) less selector

alu1bit_test :: [(Int, Int)]
alu1bit_test = [alu1bit (a, b) selector ainv binv cin less| a <- bin, b <- bin, selector <- ops, ainv <- bin, binv <- bin, cin <- bin, less <- bin]

alu1bitOverflow :: (Int, Int) -> Int -> Int -> Int -> Int-> Int -> (Int, Int, Int)
alu1bitOverflow (a, b) selector ainv binv cin less = (result, overflow, set) where
			mux2x1_1 = mux2x1 a (notGate a) ainv
			mux2x1_2 = mux2x1 b (notGate b) binv
			and1 = andGate mux2x1_1 mux2x1_2
			or1 = orGate mux2x1_1 mux2x1_2
			adder1 = fullAdder mux2x1_1 mux2x1_2 cin
			cout = snd adder1
			result = mux4x1 and1 or1 (fst adder1) less selector
			--xor1 = xorGate a mux2x1_1
			--xor2 = xorGate a (fst adder1)
			--overflow = andGate (notGate xor1) xor2
			overflow = xorGate cin cout
			set = fst adder1
alurecursion :: [(Int, Int)] -> Int -> Int -> Int -> Int -> Int -> ([Int], Int)
alurecursion [] _ _ _ cin _ = ([], cin)
alurecursion ((a,b): ab) selector ainv binv cin less = alurecursion ab selector ainv binv (snd thisalu) less: (fst thisalu) where
		thisalu = alu1bit a b selector ainv binv cin less 
alu32bit :: [Int] -> [Int] -> Int -> Int -> Int -> ([Int], Int, Int)
alu32bit (a:as) (b:bs) selector ainv binv = (result, overflow, zero) where
			alu1 = alu1bit (a, b) selector ainv binv binv set
			result = (mapAccumR  (\x -> alu1bit x selector ainv binv (snd alu1) 0) (tuples as bs)) ++ fst alu1
			
			set = 0
			overflow = 0
			zero = 0
-----------------------------------------------------------------------------------
bin = [0, 1]
ops = [0, 1, 2, 3]

-- Run 1
a1 :: [Int]
a1 = [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,1]
b1 :: [Int]
b1 = [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,1,0,0]
-- Run 2
ab2 :: [Int]
ab2 = [0,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1]
-- Run 3
a3 :: [Int]
a3 = [1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,0,1,1, 0,1,1,1]
b3 :: [Int]
b3 = [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,1,0,0, 0,1,1,0]