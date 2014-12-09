{-# LANGUAGE TypeSynonymInstances#-}
{-
	Author: Brandon Lundberg
	File Name: simproject3.hs
	Purpose: Memory Hierarchy Simulation
	Date: 10 Dec 2014
-}

{-----------------------------------------------------------------------------------
 File description
 	1. 	Program description and methods used- The purpose of the program is to simulate
		the memory hierarchy. This program contains functions that simulate the hardware structures
		of the register set, cache memory, and main memory. In order to simulate this, an instruction
		set will be read from a file. The end result of the simulation will be to display the contents
		of the 3 data structure listed above

	2. 	Compile/Run program and I/O description- In order to run this program, the user will need to use
		Haskell's GHCI interpreter. The following steps will need to be taken in the terminal.
		-	navigate to the file directory where the simproject3.hs file is located.
		- 	enter ghci into the terminal, press enter (this will open the ghci interpreter)
		- 	now that you are in GHCI, enter the following command
				- Prelude> :l simproject3
		- 	the simproject3.hs file is now loaded and compiled
		- 	in order to perform the simulation, the file with the instruction set will have
		  	to be loaded from a data file. The data file contains 32 bit integers (separared by spaces)
		  	that respresent individual instructions
		-	loading the file is done using the following procedure:
			1.
			2.
			3.
		- 	the output is in the form of 3 lists, which contain the contents of the data structures
			described above
			 string value, "result"
		- 	the running input/output is shown at the end of the file
------------------------------------------------------------------------------------}
---------------------------------- Helper Functions ----------------------------------------
import Data.List ()
import Debug.Trace (trace)

type Cache = (Int, Int, Int, [Int], Int, Int, Int, [Int])
instance Show Cache where    -- use precedence to minimize parentheses
  show (history1, valid1, tag1, data1, history2, valid2, tag2, data2) = "History 1: " ++ show history1 ++ " Valid Bit 1: " ++ show valid1 ++ " Tag 1: " ++ show tag1 ++ " Data1 : " ++ show data1 ++ "\n" ++ "History 2: " ++ show history2 ++ " Valid Bit 2: " ++ show valid2 ++ " Tag 2: " ++ show tag2 ++ " Data 2: " ++ show data2 ++ "\n"
type Caches = [(Int, Int, Int, [Int], Int, Int, Int, [Int])]
instance Show Caches where
  show [] = ""
  show (x:xs) = show x ++ show xs
type Memory = [Int]
type MainMemory = [[Int]]
instance (Show MainMemory) where
  show [] = ""
  show (x:xs) = "Main Memory: \n" ++ show x ++ "\n" ++ show xs
type Register = [Int]
type Registers = [[Int]]
instance (Show Registers) where
  show [] = ""
  show (x:xs) = "Registers: \n" ++ show x ++ "\n" ++ show xs
--import Data.List.Split
-- nthel (nth element)
-- Takes the nth element from a list
nthel :: Int -> [[Int]] -> [Int]
nthel n xs = last (take n xs)

-- nthelCache
-- same as the previous functions, but the data type is different, so a different output is needed
nthelCache :: Int -> Caches -> Cache
nthelCache n xs = last (take n xs)

-- the next 3 functions all replace a particular element in one of the structures
-- they all use recursion with a counter to find the element to replace and fill it with the
-- correct new element
replaceNthElemRegister :: Int -> Register -> Registers -> Registers
replaceNthElemRegister 0 a (x:xs) = a:xs
replaceNthElemRegister n a (x:xs) = x:replaceNthElemRegister (n-1) a xs

replaceNthElemMemory :: Int -> Memory -> MainMemory -> MainMemory
replaceNthElemMemory 0 a (x:xs) = a:xs
replaceNthElemMemory n a (x:xs) = x:replaceNthElemMemory (n-1) a xs

replaceNthElemCache :: Int -> Cache -> Caches -> Caches
replaceNthElemCache 0 a (x:xs) = a:xs
replaceNthElemCache n a (x:xs) = x:replaceNthElemCache (n-1) a xs

-- the lenIntToBin function takes changes the binary number calculated in the intToBinPositive
-- and makes it 32 bits long. Since we are only working with postive integers, zeros are added
-- to the front until it has a length of 32
lenIntToBin :: [Int] -> [Int]
lenIntToBin (x:xs) | length (x:xs) == 32 = (x:xs)
			   	   | otherwise =  lenIntToBin (0:x:xs)

-- stringToInts
-- changes a string to a list of integers
stringToInts :: [Char] -> [Int]
stringToInts [] = []
stringToInts (x:xs) = (read [x] :: Int):stringToInts xs
-- stringToIntsList
-- changes a list of strings to a list of list of integers, using the stringToInts function
stringToIntsList :: [[Char]] -> [[Int]]
stringToIntsList [] = []
stringToIntsList (x:xs) = stringToInts x : stringToIntsList xs

-- a 32 bit long list of zeros. This is used in initializing the registers, cache and main memory
initializeToZero :: [Int]
initializeToZero = [0,0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

-- intToBinPositive converts the number to a binary value, with the output being from
-- least to most significant bit.
-- it uses the algorith described here: https://www.wisc-online.com/learn/formal-science/
-- mathematics/tmh5506/an-algorithm-for-converting-a-decimal-number-to-a-binary-number
intToBinPositive :: Int -> [Int]
intToBinPositive 0 = []
intToBinPositive x = res : intToBinPositive (div x 2) where
	res = if even x then 0 else 1

-- binToIntPositive
-- takes a list of integers and converts it into the corresponding integer
binToIntPositive :: Int -> [Int] -> Int
binToIntPositive n [] = 0
binToIntPositive n (x:xs) = ((2^n)*x) + binToIntPositive (n+1) xs  

-- the following 3 functions are used help create the registers, cache and main memory
-- they create as many elements of that particular structure as desired by the user
initializeRegisterZero :: Int -> Registers
initializeRegisterZero 0 = []
initializeRegisterZero size = initializeToZero:initializeRegisterZero (size-1)

initializeMemoryNonZero :: Int -> Int -> MainMemory
initializeMemoryNonZero 0 dataOffset = [lenIntToBin (reverse (intToBinPositive (dataOffset)))]
initializeMemoryNonZero size dataOffset = lenIntToBin (reverse (intToBinPositive (size+dataOffset))) : initializeMemoryNonZero (size-1) dataOffset

initializeCacheZero :: Int -> Caches
initializeCacheZero 0 = []
initializeCacheZero n = (0, 0, 0, initializeToZero, 0, 0, 0, initializeToZero):initializeCacheZero (n-1)

-- the following 3 are the actual constructions of our registers, cache and main memory. These are the
-- structures that are passed into the driver functions, which is the followInstructions function below
registers :: Registers
registers = initializeRegisterZero 8

cache :: Caches
cache = initializeCacheZero 8

mainmemory :: MainMemory
mainmemory = reverse (initializeMemoryNonZero 127 5)



{-
		instruction <- readFile "p3input.txt"
		getInstructions instructions

-}
-- checkOpCode
-- takes in an instruction and looks at the op code for that construction
-- if the op code calls store word, the boolean return is True
-- otherwise, it is False
-- this reuslt is used in determining what to do in the followInstructions function
checkOpCode :: [Int] -> Bool
checkOpCode instruction = if (take 6 instruction == (reverse (intToBinPositive 43)))then True 
						  else False
-- getRegister
-- retrieves the rt field and returns integer that corresponds with the correct #s register
getRegister :: [Int] -> Int
getRegister instruction = ((binToIntPositive 0 (reverse (take 5 (drop 11 instruction)))) - 16) 

-- computeWordAddress
-- calculates the integer version of the word address by using the div function, which gets the
-- quotient portion of a division
computeWordAddress :: [Int] -> Int
computeWordAddress instruction = div (binToIntPositive  0 $ take 16 (reverse instruction)) 4

-- determineIndex
determineIndex :: Int -> Int
determineIndex wordAddress = mod wordAddress 8

-- determineTag
determineTag :: Int -> Int
determineTag wordAddress = div wordAddress 8


---------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------- Read from file and computation --------------------------------
-- this holds the name of the file I am accessing that holds the instructions for the computation
fileName :: [Char]
fileName = "p3input.txt"

-- getInstructions
-- the file above is imported as one string, with all the instructions as well as new line characters
-- this function takes that string and converts it to a list of list of integers, which can be used in computation
getInstructions :: [Char] -> [[Int]]
getInstructions file = instructionSet where
	instructionLines = lines file
	instructionSet = stringToIntsList $ map (filter (/= ' ')) instructionLines

-- followInstructions
-- this is the function that drives all calculations based on the instruction being a load word or store word instruction
-- the base case for the function just returns the current contents of the registers, cache and mainmemory
-- Case 1: Store Word
-- In this case, the cache and memory are updated, but the registers are not. 
-- The function begins by retrieving the correct register input and getting the content of that register
-- Next, the word address in computed and the index and tag fields are pulled from that
-- Using the index of the instruction, the correct cache set is found and updated depending on the lru of the set. This
-- takes place is the updatedCache variable, which is the cache that will be passed into the next parameter
-- Finally, the memory is updated into the updatedMemory variable, using the word address and the correct register content
-- Case 2: Load Word
-- In this case, the cache and registers can be updated, but main memory is not.
-- The function beigns the same way as store word, collection the correct register index and content, as well as
-- the word address, index, and tag of the instruction
-- the correct cache set is then checked to determine if the correct data is present in the cache. If it is present (hit), the 
-- cache set remains the same, except the lru is updated for the set. Otherwise (miss), the cache is updated using the word
-- address from main memory. 
-- Finally, the registers are updated from the cache, which now holds the correct data in that set
-- Recursion:
-- This function uses recursion to run each instruction from the input file. Once there are no more instructions, the contents
-- of the register, cache, and main memory are displayed.
-- In each call to this function, the updated registers, cache and main memory are passed through, so each instruction accesses the correct data.
followInstructions :: [[Int]] -> (Registers, Caches, MainMemory) -> (Registers, Caches, MainMemory)
followInstructions [] (registerSet, cacheSet, mainMemorySet) = (registerSet, cacheSet, mainMemorySet)
followInstructions (x:xs) (registerSet, cacheSet, mainMemorySet) | checkOpCode x = followInstructions xs (registerSet, updatedCache, updatedMemory) where
	retrievedRegister = getRegister x
	registerContent = nthel (retrievedRegister + 1) registerSet
	wordAddress = computeWordAddress x
	index = determineIndex wordAddress
	tag = determineTag wordAddress
	(lru1, valid1, tag1, word1, lru2, valid2, tag2, word2) = nthelCache (index + 1) cacheSet
	updatedCache = if lru1 == 1 then replaceNthElemCache index (0, valid1, tag1, word1, 1, 1, tag, registerContent) cacheSet
				   else replaceNthElemCache index (1, 1, tag, registerContent, 0, valid2, tag2, word2) cacheSet
	updatedMemory = replaceNthElemMemory wordAddress registerContent mainMemorySet
followInstructions (x:xs) (registerSet, cacheSet, mainMemorySet) | otherwise = followInstructions xs (updatedRegisters, updatedCache, mainMemorySet) where
	retrievedRegister = getRegister x
	wordAddress = computeWordAddress x
	index = determineIndex wordAddress
	tag = determineTag wordAddress
	(lru1, valid1, tag1, word1, lru2, valid2, tag2, word2) = nthelCache (index + 1) cacheSet
	newCacheSet@(newlru1, newvalid1, newtag1, newword1, newlru2, newvalid2, newtag2, newword2) = if (valid1 == 1 && tag1 == tag) then (1, valid1, tag1, word1, 0, valid2, tag2, word2)
						 else if (valid2 == 1 && tag2 == tag) then (0, valid1, tag1, word1, 1, valid2, tag2, word2)
						 else if (lru1 == 0) then (1, 1, tag, (nthel (wordAddress + 1) mainMemorySet),  0, valid2, tag2, word2)
						 else (0, valid1, tag1, word1,  1, 1, tag, (nthel (wordAddress + 1) mainMemorySet))
						 --else undefined
	updatedCache = replaceNthElemCache index newCacheSet cacheSet
	updatedRegisters = if (newlru1 == 1) then replaceNthElemRegister retrievedRegister newword1 registerSet
					   else replaceNthElemRegister retrievedRegister newword2 registerSet

{-
80 -- 20 -> 5
68 -- 17 -> 9
76 -- 19 -> 13
224 -- 56 -> 10
20 -- 5 -> 14
24 -- 6 -> 16
36 -- 9 -> 9
68 -- 17 -> 48
96 -- 24 -> 9
84 -- 21 -> 16
92 -- 23 -> 9
240 -- 60 -> 48
-}
-------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------- Results -----------------------------------
{-
*Main> :l simproject3
[1 of 1] Compiling Main             ( simproject3.hs, interpreted )
Ok, modules loaded: Main.
*Main> instruction <- readFile fileName
*Main> getInstructions instruction
[[1,0,0,0,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0],
[1,0,0,0,1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0],
[1,0,0,0,1,1,0,0,0,0,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0],
[1,0,0,0,1,1,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0],
[1,0,1,0,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0],
[1,0,1,0,1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0],
[1,0,1,0,1,1,0,0,0,0,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,1,0,0,1,1,0,0],
[1,0,1,0,1,1,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0],
[1,0,0,0,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0],
[1,0,0,0,1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,0,0],
[1,0,0,0,1,1,0,0,0,0,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0],
[1,0,0,0,1,1,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,1,0,0],
[1,0,1,0,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0],
[1,0,1,0,1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0],
[1,0,1,0,1,1,0,0,0,0,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0],
[1,0,1,0,1,1,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0],
[1,0,0,0,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0],
[1,0,0,0,1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,0,0],
[1,0,0,0,1,1,0,0,0,0,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0],
[1,0,0,0,1,1,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,1,0,0],
[1,0,1,0,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0],
[1,0,1,0,1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,0],
[1,0,1,0,1,1,0,0,0,0,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,1,0,1,1,1,0,0],
[1,0,1,0,1,1,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0]]

*Main> followInstructions it (registers, cache, mainmemory)
([[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]],

[(1,1,3,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],0,1,7,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0]),
(0,1,2,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0],1,1,1,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1]),
(0,0,0,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],0,0,0,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
(1,1,5,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0],0,1,1,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0]),
(0,1,0,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],1,1,7,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0]),
(1,1,2,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0],0,1,0,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0]),
(1,1,0,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0],0,0,0,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
(1,1,2,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],0,0,0,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])],

[[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,1],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0]])
-}