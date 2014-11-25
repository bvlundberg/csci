{-
	Author: Brandon Lundberg
	File Name: simproject2.hs
	Purpose: 32 bit number multiplier
	Date: 25 Nov 2014
-}
{-----------------------------------------------------------------------------------
 File description
 	1. 	Program description and methods used- The purpose of the program is to simulate
		signed multiplication using booths algorith. This program contains functions that simulate
		every necessary component of a 32 bit ALU, as well as a few extra functions to incorporate
		hexadecimal numbers and multiplication/booths algorith. Each one of these components
		uses information from a user's input to gather the 64 bit output from multiplication.

	2. 	Compile/Run program and I/O description- In order to run this program, the user will need to use
		Haskell's GHCI interpreter. The following steps will need to be taken in the terminal.
		- navigate to the file directory where the simproject2.hs file is located.
		- enter ghci into the terminal, press enter (this will open the ghci interpreter)
		- now that you are in GHCI, enter the following command
			- Prelude> :l simproject2
		- the simproject2.hs file is now loaded and compiled
		- in order to perform multiplication, the signedMult function
		  will be used. Use the following format to run the signedMult function
		  	- signedMult <md register value> <mq registed value>
		  	- the above variables used are described in more detail below, but in summary:
		  		- md is the multiplicand
		  		- mq is the 
		  		- the inputs are in string form, of a hexadecimal value
		  	- the output is in the form of a string value, "result"
		  		- result is a 64 bit binary number, represented as a string in hexadecimal
			- input/output examples are described at the end of the file
		- now, you may test each possible input into the signed multiplier
------------------------------------------------------------------------------------}

import Data.List ()
import Data.Char ()
import Debug.Trace (trace)
------------ Uploaded from previous simulation project-----------------
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


-------------------- Simulation project 2 starts here---------------------------------
---------------------Helper functions------------------------------------------
-- A list of 32 zeros, used in the case where the algorith requires AC <- AC + 0
zero :: [Int]
zero = [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]

-- A list containing the binary list with the value 1
-- This list is used in the twos complement function, where the value 1 needs to be added
-- to the negated MD register value
one :: [Int]
one = [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1]

-- hexToBin
-- this function is basically a switch statement that reads a string letter by letter and
-- converts it to a binary number
hexToBin :: [Char] -> [Int]
hexToBin [] = []
hexToBin (x:xs) | x == '0' = [0, 0, 0, 0] ++ hexToBin xs
				| x == '1' = [0, 0, 0, 1] ++ hexToBin xs
				| x == '2' = [0, 0, 1, 0] ++ hexToBin xs
				| x == '3' = [0, 0, 1, 1] ++ hexToBin xs
				| x == '4' = [0, 1, 0, 0] ++ hexToBin xs
				| x == '5' = [0, 1, 0, 1] ++ hexToBin xs
				| x == '6' = [0, 1, 1, 0] ++ hexToBin xs
				| x == '7' = [0, 1, 1, 1] ++ hexToBin xs
				| x == '8' = [1, 0, 0, 0] ++ hexToBin xs
				| x == '9' = [1, 0, 0, 1] ++ hexToBin xs
				| x == 'A' = [1, 0, 1, 0] ++ hexToBin xs
				| x == 'B' = [1, 0, 1, 1] ++ hexToBin xs
				| x == 'C' = [1, 1, 0, 0] ++ hexToBin xs
				| x == 'D' = [1, 1, 0, 1] ++ hexToBin xs
				| x == 'E' = [1, 1, 1, 0] ++ hexToBin xs
				| x == 'F' = [1, 1, 1, 1] ++ hexToBin xs

-- binToHex
-- this function converts a list of integers, which are representing a binary number,
-- and converts it into a string. This is accomplished by converting 4 binary numbers
-- at a time and calculates the value of that integer. From there, the value of that integer
-- is used by the !! operator to select that index in the string "0123456789ABCDEF". The selected
-- char from that string is appended to the next elements recursively 
binToHex :: [Int] -> [Char]
binToHex [] = []
binToHex (b1:b2:b3:b4:rest) = ("0123456789ABCDEF" !! ((b1*8) + (b2*4) + (b3*2) + (b4*1))) : binToHex rest

-- neg
-- this function simply negates a binary list recursively
neg :: [Int] -> [Int]
neg [] = []
neg (x:xs) = negx:neg xs where
	negx = if x == 0 then 1 else 0

-- twosComp
-- this function calculates the twos complement of a binary number
-- this is accomplished by calling a 32 bit alu using the addition operator
-- the first input to the alu is the negated value of the input binary number
-- the second input to the alu is the 32 binary number for 1, which was previously defined
-- this does the job of negating the binary number and adding 1 to it
twosComp :: [Int] -> [Int]
twosComp xs = result where
	(result,_,_) = alu32bit (neg xs) one 2 0 0

-- the following 3 functions are used to convert an integer to a hex number
-- since I use the counter in my multiplier as an int, I have to display the value in hex
-- by using a helper function.

-- intToBinPositive converts the number to a binary value, with the output being from
-- least to most significant bit.
-- it uses the algorith described here: https://www.wisc-online.com/learn/formal-science/
-- mathematics/tmh5506/an-algorithm-for-converting-a-decimal-number-to-a-binary-number
intToBinPositive :: Int -> [Int]
intToBinPositive 0 = []
intToBinPositive x = res : intToBinPositive (div x 2) where
	res = if even x then 0 else 1
-- the lenIntToBin function takes changes the binary number calculated in the intToBinPositive
-- and makes it 32 bits long. Since we are only working with postive integers, zeros are added
-- to the front until it has a length of 32

lenIntToBin :: [Int] -> [Int]
lenIntToBin (x:xs) | length (x:xs) == 32 = (x:xs)
			   	   | otherwise =  lenIntToBin (0:x:xs)

-- the intToBin32 function is the driving function behind the operation. it calls the intToBinPositive
-- function, then reverses it (due to the least to most significant bit), then adds zeros until it is 32 bits long
-- this binary counter is then converted to hex and printed in the multiplier
intToBin32 :: Int -> [Int]
intToBin32 x = lenIntToBin $ reverse $ intToBinPositive x

-- calcAC
-- this function decides based on mq[0] and mq[-1] which operation to do in the 32 bit alu
-- as stated in the prompt, instead of doing ac <- ac - md, I used ac <- ac + (2's comp md) for that case
-- since I wanted to use the 32 bit alu for all the cases, I run a 32 bit alu with ac and zero (defined earlier), which will just output ac when mq[0] and mq[-1] are the same
-- this function is used in the boothsMultiplier function
calcAC :: [Int] -> [Int] -> [Int] -> Int -> [Int]
calcAC md ac mq mqextra = result where
	(result,_,_) = if ((last mq) == 0 && mqextra == 1) then alu32bit ac md 2 0 0
				   else if ((last mq) == 1 && mqextra == 0) then alu32bit ac (twosComp md) 2 0 0
				   else alu32bit ac zero 2 0 0

-- boothsMultiplier
-- this function does all the calculations of signed multiplication, usings booths algorithm recursively
-- the inputs of the function are the counter integer, md, ac, and mq as lists, and mqextra, which is mq[-1] bit
-- first ac is updated using the previous calcAC function
-- then, ac'' is used to shift and use the sign bit to add to the front of ac, making it 33 bits long
-- mq is then shifted, with the last element of ac added to the front, making it 33 bits long
-- mqextra is updated from the last element of mq
-- then the recursive call occurs
-- in the recursive call, counter is decremented by 1
-- the init function is used on ac and mq, which returns all but the last element of a list
-- this is used because the last element of ac and mq are being shifted off of that variable, into the first bit of mq and mqextra, respectively
-- the base case of the function occurs when the counter hits zero, and returns a list of ac combined with mq, which is 64 bits long
-- the trace function is in place to print the input values at each iteration of the calculation, with the final result printed once at the end
boothsMultiplier :: Int -> [Int] -> [Int] -> [Int] -> Int -> [Int]
boothsMultiplier 0 _ ac mq _ = (ac ++ mq)
boothsMultiplier counter md ac mq mqextra = trace ("Counter: " ++ show(binToHex (intToBin32 counter)) ++ " MD reg: " ++ show (binToHex md) ++ " AC reg: " ++ show (binToHex ac) ++ " MQ reg: " ++ show (binToHex mq) ++ " MQ-1: " ++ show mqextra) result where
	ac' = calcAC md ac mq mqextra
	ac'' = take 1 ac' ++ ac'
	mq' = [last ac''] ++ mq
	mqextra' = last mq'
	result = boothsMultiplier (counter - 1) md (init ac'') (init mq') mqextra'
-- signedMult
-- this is basically the driver function for the signed multiplication using booths algorithm
-- the only needed inputs are md and mq, which are in hex form
-- the counter is set to 32, which which decrease in recursive calls
-- ac is initialized as zero, which was defined earlier
-- md and mq are converted to binary and assigned
-- mqextra, defined in the previous function, starts as 0
-- the result is then calculated and returned in the boothMultiplier function, then converted back into hex for the output
signedMult :: [Char] -> [Char] -> [Char]
signedMult mdAssign mqAssign = result where
	counter = 32
	ac = zero
	md = hexToBin mdAssign
	mq = hexToBin mqAssign
	mqextra = 0
	result = binToHex $ boothsMultiplier counter md ac mq mqextra
----------------------------------------------------------------------------------------------------------------------------
-- This section contains testing values that can be used to simulate each of the required test cases

-- Test case data 1
md1 :: [Char]
md1 = "00000001"
mq1 :: [Char]
mq1 = "10000000"

-- Test case data 2
md2 :: [Char]
md2 = "00000046"
mq2 :: [Char]
mq2 = "FFFFFFB7"

{-
Main> :l simproject2
[1 of 1] Compiling Main             ( simproject2.hs, interpreted )
Ok, modules loaded: Main.
*Main> signedMult md1 mq1
Counter: "00000020" MD reg: "00000001" AC reg: "00000000" MQ reg: "10000000" MQ-1: 0
Counter: "0000001F" MD reg: "00000001" AC reg: "00000000" MQ reg: "08000000" MQ-1: 0
Counter: "0000001E" MD reg: "00000001" AC reg: "00000000" MQ reg: "04000000" MQ-1: 0
Counter: "0000001D" MD reg: "00000001" AC reg: "00000000" MQ reg: "02000000" MQ-1: 0
Counter: "0000001C" MD reg: "00000001" AC reg: "00000000" MQ reg: "01000000" MQ-1: 0
Counter: "0000001B" MD reg: "00000001" AC reg: "00000000" MQ reg: "00800000" MQ-1: 0
Counter: "0000001A" MD reg: "00000001" AC reg: "00000000" MQ reg: "00400000" MQ-1: 0
Counter: "00000019" MD reg: "00000001" AC reg: "00000000" MQ reg: "00200000" MQ-1: 0
Counter: "00000018" MD reg: "00000001" AC reg: "00000000" MQ reg: "00100000" MQ-1: 0
Counter: "00000017" MD reg: "00000001" AC reg: "00000000" MQ reg: "00080000" MQ-1: 0
Counter: "00000016" MD reg: "00000001" AC reg: "00000000" MQ reg: "00040000" MQ-1: 0
Counter: "00000015" MD reg: "00000001" AC reg: "00000000" MQ reg: "00020000" MQ-1: 0
Counter: "00000014" MD reg: "00000001" AC reg: "00000000" MQ reg: "00010000" MQ-1: 0
Counter: "00000013" MD reg: "00000001" AC reg: "00000000" MQ reg: "00008000" MQ-1: 0
Counter: "00000012" MD reg: "00000001" AC reg: "00000000" MQ reg: "00004000" MQ-1: 0
Counter: "00000011" MD reg: "00000001" AC reg: "00000000" MQ reg: "00002000" MQ-1: 0
Counter: "00000010" MD reg: "00000001" AC reg: "00000000" MQ reg: "00001000" MQ-1: 0
Counter: "0000000F" MD reg: "00000001" AC reg: "00000000" MQ reg: "00000800" MQ-1: 0
Counter: "0000000E" MD reg: "00000001" AC reg: "00000000" MQ reg: "00000400" MQ-1: 0
Counter: "0000000D" MD reg: "00000001" AC reg: "00000000" MQ reg: "00000200" MQ-1: 0
Counter: "0000000C" MD reg: "00000001" AC reg: "00000000" MQ reg: "00000100" MQ-1: 0
Counter: "0000000B" MD reg: "00000001" AC reg: "00000000" MQ reg: "00000080" MQ-1: 0
Counter: "0000000A" MD reg: "00000001" AC reg: "00000000" MQ reg: "00000040" MQ-1: 0
Counter: "00000009" MD reg: "00000001" AC reg: "00000000" MQ reg: "00000020" MQ-1: 0
Counter: "00000008" MD reg: "00000001" AC reg: "00000000" MQ reg: "00000010" MQ-1: 0
Counter: "00000007" MD reg: "00000001" AC reg: "00000000" MQ reg: "00000008" MQ-1: 0
Counter: "00000006" MD reg: "00000001" AC reg: "00000000" MQ reg: "00000004" MQ-1: 0
Counter: "00000005" MD reg: "00000001" AC reg: "00000000" MQ reg: "00000002" MQ-1: 0
Counter: "00000004" MD reg: "00000001" AC reg: "00000000" MQ reg: "00000001" MQ-1: 0
Counter: "00000003" MD reg: "00000001" AC reg: "FFFFFFFF" MQ reg: "80000000" MQ-1: 1
Counter: "00000002" MD reg: "00000001" AC reg: "00000000" MQ reg: "40000000" MQ-1: 0
Counter: "00000001" MD reg: "00000001" AC reg: "00000000" MQ reg: "20000000" MQ-1: 0
Result: "0000000010000000"

*Main> signedMult md2 mq2
Counter: "00000020" MD reg: "00000046" AC reg: "00000000" MQ reg: "FFFFFFB7" MQ-1: 0
Counter: "0000001F" MD reg: "00000046" AC reg: "FFFFFFDD" MQ reg: "7FFFFFDB" MQ-1: 1
Counter: "0000001E" MD reg: "00000046" AC reg: "FFFFFFEE" MQ reg: "BFFFFFED" MQ-1: 1
Counter: "0000001D" MD reg: "00000046" AC reg: "FFFFFFF7" MQ reg: "5FFFFFF6" MQ-1: 1
Counter: "0000001C" MD reg: "00000046" AC reg: "0000001E" MQ reg: "AFFFFFFB" MQ-1: 0
Counter: "0000001B" MD reg: "00000046" AC reg: "FFFFFFEC" MQ reg: "57FFFFFD" MQ-1: 1
Counter: "0000001A" MD reg: "00000046" AC reg: "FFFFFFF6" MQ reg: "2BFFFFFE" MQ-1: 1
Counter: "00000019" MD reg: "00000046" AC reg: "0000001E" MQ reg: "15FFFFFF" MQ-1: 0
Counter: "00000018" MD reg: "00000046" AC reg: "FFFFFFEC" MQ reg: "0AFFFFFF" MQ-1: 1
Counter: "00000017" MD reg: "00000046" AC reg: "FFFFFFF6" MQ reg: "057FFFFF" MQ-1: 1
Counter: "00000016" MD reg: "00000046" AC reg: "FFFFFFFB" MQ reg: "02BFFFFF" MQ-1: 1
Counter: "00000015" MD reg: "00000046" AC reg: "FFFFFFFD" MQ reg: "815FFFFF" MQ-1: 1
Counter: "00000014" MD reg: "00000046" AC reg: "FFFFFFFE" MQ reg: "C0AFFFFF" MQ-1: 1
Counter: "00000013" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "6057FFFF" MQ-1: 1
Counter: "00000012" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "B02BFFFF" MQ-1: 1
Counter: "00000011" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "D815FFFF" MQ-1: 1
Counter: "00000010" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "EC0AFFFF" MQ-1: 1
Counter: "0000000F" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "F6057FFF" MQ-1: 1
Counter: "0000000E" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "FB02BFFF" MQ-1: 1
Counter: "0000000D" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "FD815FFF" MQ-1: 1
Counter: "0000000C" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "FEC0AFFF" MQ-1: 1
Counter: "0000000B" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "FF6057FF" MQ-1: 1
Counter: "0000000A" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "FFB02BFF" MQ-1: 1
Counter: "00000009" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "FFD815FF" MQ-1: 1
Counter: "00000008" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "FFEC0AFF" MQ-1: 1
Counter: "00000007" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "FFF6057F" MQ-1: 1
Counter: "00000006" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "FFFB02BF" MQ-1: 1
Counter: "00000005" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "FFFD815F" MQ-1: 1
Counter: "00000004" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "FFFEC0AF" MQ-1: 1
Counter: "00000003" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "FFFF6057" MQ-1: 1
Counter: "00000002" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "FFFFB02B" MQ-1: 1
Counter: "00000001" MD reg: "00000046" AC reg: "FFFFFFFF" MQ reg: "FFFFD815" MQ-1: 1
Result: "FFFFFFFFFFFFEC0A"
-}