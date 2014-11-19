{- 	Author: Brandon Lundberg
   	File name: simproject.hs
	Purpose: To simulate a 32 bit ALU
	Date: 12 November 2014
-}
{-----------------------------------------------------------------------------------
 File description
 	1. 	Program description and methods used- The purpose of the program is to simulate
		a running 32 bit ALU. This program contains functions that simulate
		every necessary component of a 32 bit ALU. Each one of these components
		uses information from a user's input to gather the output of the 32 bit ALU.

	2. 	Compile/Run program and I/O description- In order to run this program, the user will need to use
		Haskell's GHCI interpreter. The following steps will need to be taken in the terminal.
		- navigate to the file directory where the simproject.hs file is located.
		- enter ghci into the terminal, press enter (this will open the ghci interpreter)
		- now that you are in GHCI, enter the following command
			- Prelude> :l simproject
		- the simproject.hs file is now loaded and compiled
		- in order to check individual inputs for the 32 bit ALU, the alu32bit function
		  will be used. Use the following format to run the alu32bit function
		  	- alu32bit <a value> <b value> <op code> <a invert> <b invert>
		  	- the above variables used are described in more detail below, but in summary:
		  		- a value and b value are a list of 32 integers
		  		- op code, a invert and b invert are single integers
		  	- the output is in the form (<result>, <overflow>, <zero>)
		  		- result is a list of 32 integers
		  		- overflow and zero are both single integers
		  	- an example of an input to the function looks like:
		  		INPUT: *Main> alu32bit [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,1] [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,1,0,0] 2 0 0
				OUTPUT: ([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1],0,0)
			- the output of the function is also explained in more depth below
		- now, you may test each possible input into the 32 bit ALU
------------------------------------------------------------------------------------}
import Data.List ()
------------ Helper functions ----------------
-- nthel (nth element)
-- Takes the nth element from a list
-- Used in 4x1 mux to recieve the correct element from the decoder output
nthel :: Int -> [Int] -> Int
nthel n xs = last (take n xs)
-- orl
-- Determines the output of an or gate with more than 2 values
-- Used in 32 bit alu to calculate zero
orList :: [Int] -> Int
orList [] = 0
orList (x:xs) = if (x == 1) then 1
				else orList xs
----------------------------------------------
-- and gate logic
-- takes in 2 integer arguments, 1 output integer
-- will produce a 1 as the output only if both inputs are 1
-- otherwise, the output is 0
andGate :: Int -> Int -> Int
andGate a b = if a == 1 && b == 1 then 1
			  else 0
-- or gate logic
-- takes in 2 integer arguments, 1 output integer
-- will produce a 0 as the output only if both inputs are 0
-- otherwise, the output is 1
orGate :: Int -> Int -> Int
orGate a b = if a == 0 && b == 0 then 0
			 else 1
-- not gate logic
-- takes in 1 integer argument, 1 output integer
-- will produce a 0 as the output only if the input is 1
-- otherwise, the output is 1
notGate :: Int -> Int
notGate a = if a == 1 then 0
		    else 1
-- xor gate logic
-- takes in 2 integer arguments, 1 output integer
-- will produce a 0 as the output only if both inputs are the same
-- otherwise, the output is 1
xorGate :: Int -> Int -> Int
xorGate a b = if a == b then 0
			  else 1

-- 2x1 multiplexor logic
-- takes in 3 integer arguments, 1 output integer
-- the first 2 arguments are the possible values of the output, while the third argument is a selector signal to pick the appropriate one
-- in the 1 bit alu, it is used to determine whether a/b or not a/not b should be used as inputs for the and/or/full adder gates
mux2x1 :: Int -> Int -> Int -> Int
mux2x1 a b selector = result where
			and1 = andGate a (notGate selector)
			and2 = andGate b selector
			result = orGate and1 and2

-- 2 bit decoder
-- takes in 1 integer as input and outputs a list of 4 integers
-- the output list is based solely of the input value, which is the op code
-- the op code determines which and gate in the 4x1 multiplexor should be satified
-- the 2 bit decoder usually has 4 and gates implemented, each one with a different set of negators
-- instead of using the and gates, the output lists I created correctly output which one of the 4 and gates was selected, which maps directly to the correct and gate in the multiplexor
-- the possible op codes are 
-- 		0 = 00
-- 		1 = 01
-- 		2 = 10
-- 		3 = 11
decoder2bit :: Int -> [Int]
decoder2bit selector | selector == 0 = [1, 0, 0, 0] 
					 | selector == 1 = [0, 1, 0, 0]
					 | selector == 2 = [0, 0, 1, 0]
					 | selector == 3 = [0, 0, 0, 1]
-- 4x1 multiplexor logic
-- takes in 5 integer arguments, 1 output integer
-- the first 4 arguments are the possible values of the output, while the 5th argument is a selector signal to pick the appropriate one
-- in the 1 bit alu, it is used to determine the result of the alu
-- mapping to the 4x1 multiplexor is the and gate, or gate, full adder and the less signal, as well as the 2 bit op code described earlier
-- in this function, I use nthel, which selects the nth element of the list calculated by the 2 bit decoder, so that each element of the decoder is mapped to the appropriate and gate
-- the result is calculated using an or gate, which is combining two seperate or gates
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
-- full adder logic
-- takes in 3 integer arguments, a pair of two integers as an output
-- the 3 inputs are a and b, as well as cin (cout of the previous alu)
-- the sum of the adder is calculated by doing the following operation (a 'xor' b 'xor' cin), which is done using two xor gates, since each one only takes 2 inputs
-- the cout of the adder is calculated by the following operation ((a 'and' b) 'or' (cin 'and' (a 'xor' b)))
fullAdder :: Int -> Int -> Int -> (Int, Int)
fullAdder a b cin = (addSum, cout) 	where
			xor1 = xorGate a b
			addSum = xorGate xor1 cin
			and1 = andGate a b
			and2 = andGate xor1 cin
			cout = orGate and1 and2
-- 1 bit alu
-- takes in 7 arguments and returns a pair of two integers as an output
-- the 1 bit alu uses all the pieces described earlier
-- the 2 2x1 multiplexors are used to check the a or b invert to see if a/not a or b/not b should be used
-- the outputs of those are then passed to the and,or and full adder gates, which are then passed to the 4x1 multiplexor, along with the less value
-- the op code is entered into the 4x1 multiplexor as well
-- the result is the output of the 4x1 multiplexor, and the cout is determined by the adder, which is passed to the next alu
alu1bit :: Int -> Int -> Int -> Int -> Int -> Int -> Int -> (Int, Int)
alu1bit a b selector ainv binv cin less = (result, cout) where
			mux2x1_1 = mux2x1 a (notGate a) ainv
			mux2x1_2 = mux2x1 b (notGate b) binv
			and1 = andGate mux2x1_1 mux2x1_2
			or1 = orGate mux2x1_1 mux2x1_2
			adder1 = fullAdder mux2x1_1 mux2x1_2 cin
			cout = snd adder1
			result = mux4x1 and1 or1 (fst adder1) less selector

-- 1 bit alu with overflow detection
-- this alu has the same setup as the 1 bit alu, except it has overflow detection, calculates a set value (which is used as the input of 'less' in the first alu), and does not have a cout value(cout of last alu does not matter) 
-- the set value is the sum calculated by the adder
-- the overflow checking is the result of an xor gate that takes the cin and the cout from the current adder
alu1bitOverflow :: Int -> Int -> Int -> Int -> Int -> Int-> Int -> (Int, Int, Int)
alu1bitOverflow a b selector ainv binv cin less = (result, overflow, set) where
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
-- 32 bit alu!
-- takes in 2 integer lists, which represents 32 bit binary numbers, and 3 other input integers, which are used consistently in each 1 bit alu
-- the output is a tuple, with the first element being a list of integers, which is the 32 bit binary result, the second element being the overflow from the last alu, and the zero
-- there are 32 alus to use in this calculation, with the 1st and 32nd being a little different than the other 30
-- the first alu takes the binv value as its cin value, while the other 31 take the cout from the previous 1 bit alu as their cin
-- the first alu also takes the value 'set' as its input for the 'less' calculation, which happens to be the sum from the adder in the 32nd alu
-- since haskell is a lazy language and only uses information when it is needed, it can have circular dependencies, which makes it easy to use the output set from the 32nd alu as input to the first alu
-- the 32nd alu is in a different format than the others in that it has 3 output parameters, so there is a tuple for that alu as the output, where each output is used in its correct location in the 32 bit alu
-- the result list is put together by simply placing the result portion of each alu output into the correct location in the list, from the most significant alu to the least
-- since each alu has an output that is a pair, where the first element is the result and the second element is the cout, the result list is populated using the function fst, which returns the first element of a pair
-- in calucating each alu, the first and second element inputs are a and b, so I use my nth element function to grab the correct bit from the list
-- the selector, ainv and binv are the same for every alu from 2-31, but the input for cin depends on the cout from the previos alu, so I have to pull the cout from the last alu, which uses the snd function, which returns the second element in a pair
-- finally, zero determines whether the result is a list of 32 0's which is the binary number for zero
-- to calculate this, I created the orList function at the top of the file to see if there are any 1's in a list. If there are no ones, then it returns a 0
-- the output of zero should be one if orList returns a zero, so I have one last not gate on or list to calculate zero
alu32bit :: [Int] -> [Int] -> Int -> Int -> Int -> ([Int], Int, Int)
alu32bit as bs selector ainv binv = (result, overflow, zero) where
			alu1 = alu1bit (nthel 32 as) (nthel 32 bs) selector ainv binv binv set
			alu2 = alu1bit (nthel 31 as) (nthel 31 bs) selector ainv binv (snd alu1) 0
			alu3 = alu1bit (nthel 30 as) (nthel 30 bs) selector ainv binv (snd alu2) 0
			alu4 = alu1bit (nthel 29 as) (nthel 29 bs) selector ainv binv (snd alu3) 0
			alu5 = alu1bit (nthel 28 as) (nthel 28 bs) selector ainv binv (snd alu4) 0
			alu6 = alu1bit (nthel 27 as) (nthel 27 bs) selector ainv binv (snd alu5) 0
			alu7 = alu1bit (nthel 26 as) (nthel 26 bs) selector ainv binv (snd alu6) 0
			alu8 = alu1bit (nthel 25 as) (nthel 25 bs) selector ainv binv (snd alu7) 0
			alu9 = alu1bit (nthel 24 as) (nthel 24 bs) selector ainv binv (snd alu8) 0
			alu10 = alu1bit (nthel 23 as) (nthel 23 bs) selector ainv binv (snd alu9) 0
			alu11 = alu1bit (nthel 22 as) (nthel 22 bs) selector ainv binv (snd alu10) 0
			alu12 = alu1bit (nthel 21 as) (nthel 21 bs) selector ainv binv (snd alu11) 0
			alu13 = alu1bit (nthel 20 as) (nthel 20 bs) selector ainv binv (snd alu12) 0
			alu14 = alu1bit (nthel 19 as) (nthel 19 bs) selector ainv binv (snd alu13) 0
			alu15 = alu1bit (nthel 18 as) (nthel 18 bs) selector ainv binv (snd alu14) 0
			alu16 = alu1bit (nthel 17 as) (nthel 17 bs) selector ainv binv (snd alu15) 0
			alu17 = alu1bit (nthel 16 as) (nthel 16 bs) selector ainv binv (snd alu16) 0
			alu18 = alu1bit (nthel 15 as) (nthel 15 bs) selector ainv binv (snd alu17) 0 
			alu19 = alu1bit (nthel 14 as) (nthel 14 bs) selector ainv binv (snd alu18) 0
			alu20 = alu1bit (nthel 13 as) (nthel 13 bs) selector ainv binv (snd alu19) 0
			alu21 = alu1bit (nthel 12 as) (nthel 12 bs) selector ainv binv (snd alu20) 0
			alu22 = alu1bit (nthel 11 as) (nthel 11 bs) selector ainv binv (snd alu21) 0
			alu23 = alu1bit (nthel 10 as) (nthel 10 bs) selector ainv binv (snd alu22) 0
			alu24 = alu1bit (nthel 9 as) (nthel 9 bs) selector ainv binv (snd alu23) 0
			alu25 = alu1bit (nthel 8 as) (nthel 8 bs) selector ainv binv (snd alu24) 0
			alu26 = alu1bit (nthel 7 as) (nthel 7 bs) selector ainv binv (snd alu25) 0
			alu27 = alu1bit (nthel 6 as) (nthel 6 bs) selector ainv binv (snd alu26) 0
			alu28 = alu1bit (nthel 5 as) (nthel 5 bs) selector ainv binv (snd alu27) 0
			alu29 = alu1bit (nthel 4 as) (nthel 4 bs) selector ainv binv (snd alu28) 0
			alu30 = alu1bit (nthel 3 as) (nthel 3 bs) selector ainv binv (snd alu29) 0
			alu31 = alu1bit (nthel 2 as) (nthel 2 bs) selector ainv binv (snd alu30) 0
			(result32, overflow, set) = alu1bitOverflow (nthel 1 as) (nthel 1 bs) selector ainv binv (snd alu31) 0
			result = [result32, (fst alu31), (fst alu30), (fst alu29), (fst alu28), (fst alu27), (fst alu26), (fst alu25),
					(fst alu24), (fst alu23), (fst alu22), (fst alu21), (fst alu20), (fst alu19), (fst alu18), (fst alu17),
					(fst alu16), (fst alu15), (fst alu14), (fst alu13), (fst alu12), (fst alu11), (fst alu10), (fst alu9),
					(fst alu8), (fst alu7), (fst alu6), (fst alu5), (fst alu4), (fst alu3), (fst alu2), (fst alu1)]

			zero = notGate(orList result)
----------------------------------------------------------------------------------------------------------------------------
-- This section contains testing values that can be used to simulate each of the required test cases

-- Run 1
-- bin is binary numbers 0 and 1
bin = [0, 1]
-- ops is op code options
-- 0 = 00
-- 1 = 01
-- 2 = 10
-- 3 = 11
ops = [0, 1, 2, 3]
-- a and b inputs for test 1

a1 :: [Int]
a1 = [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,1]
b1 :: [Int]
b1 = [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,1,0,0]
-- a and b inputs for test 2 (a and b are the same in this example, so there is only one list defined)
ab2 :: [Int]
ab2 = [0,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,0,0,0]
-- a and b inputs for test 3
a3 :: [Int]
a3 = [1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,0,1,1, 0,1,1,1]
b3 :: [Int]
b3 = [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,1,0,0, 0,1,1,0]
-- a test to check the results for the 1 bit alu
alu1bit_test :: [(Int, Int)]
alu1bit_test = [alu1bit a b selector ainv binv cin less| a <- bin, b <- bin, selector <- ops, ainv <- bin, binv <- bin, cin <- bin, less <- bin]

{- 	INPUT: alu32bit <avalue> <bvalue> <op code> <a invert> <b invert> 
	OUTPUT: (<result>, <overflow>, <zero>)
-}
{- Test case 1
a1 = 0000 0000 0000 0000 0000 0000 0000 0011
b1 = 0000 0000 0000 0000 0000 0000 0000 0100

AND
*Main> alu32bit a1 b1 0 0 0
([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],0,1)
OR
*Main> alu32bit a1 b1 1 0 0
([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1],0,0)
ADD
*Main> alu32bit a1 b1 2 0 0
([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1],0,0)
SUB
*Main> alu32bit a1 b1 2 0 1
([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],0,0)
SLT
*Main> alu32bit a1 b1 3 0 1
([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],0,0)
NOR
*Main> alu32bit a1 b1 0 1 1
([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0],0,0)
-}

{- Test case 2
ab2 = 0111 1111 1111 1111 1111 1111 1111 1111
AND
*Main> alu32bit ab2 ab2 0 0 0
([0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0],1,0)
OR
*Main> alu32bit ab2 ab2 1 0 0
([0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0],1,0)
ADD
*Main> alu32bit ab2 ab2 2 0 0
([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0],1,0)
SUB
*Main> alu32bit ab2 ab2 2 0 1
([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],0,1)
SLT
*Main> alu32bit ab2 ab2 3 0 1
([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],0,1)
NOR
*Main> alu32bit ab2 ab2 0 1 1
([1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1],1,0)

-}

{- Test case 3
a3 = 1111 1111 1111 1111 1111 1111 1011 0111
b3 = 0000 0000 0000 0000 0000 0000 0100 0110([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0],0,0)
AND
*Main> alu32bit a3 b3 0 0 0
([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0],0,0)
OR
*Main> alu32bit a3 b3 1 0 0
([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1],0,0)
ADD
*Main> alu32bit a3 b3 2 0 0
([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1],0,0)
SUB
*Main> alu32bit a3 b3 2 0 1
([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,0,0,0,1],0,0)
SLT
*Main> alu32bit a3 b3 3 0 1
([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],0,0)
NOR
*Main> alu32bit a3 b3 0 1 1
([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0],0,0)
-}

