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
import Data.List ()

--initializeRegisterContents 
	  
replaceNthElem :: Int -> [Int] -> [[Int]] -> [[Int]]
replaceNthElem 0 a (x:xs) = a:xs
replaceNthElem n a (x:xs) = x:replaceNthElem (n-1) a xs

stringToInts :: [Char] -> [Int]
stringToInts [] = []
stringToInts (x:xs) = (read [x] :: Int):stringToInts xs

orList :: [Int] -> Int
orList [] = 0
orList (x:xs) = if (x == 1) then 1
				else orList xs

initializeToZero :: [Int]
initializeToZero = [0,0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

initializeStructureZero :: Int -> [[Int]]
initializeStructureZero 0 = []
initializeStructureZero size = initializeToZero:initializeStructureZero (size-1)

intToBinPositive :: Int -> [Int]
intToBinPositive 0 = []
intToBinPositive x = res : intToBinPositive (div x 2) where
	res = if even x then 0 else 1
-- the lenIntToBin function takes changes the binary number calculated in the intToBinPositive
-- and makes it 32 bits long. Since we are only working with postive integers, zeros are added
-- to the front until it has a length of 32

initializeStructureNonZero :: Int -> Int -> [[Int]]
initializeStructureNonZero size dataOffset = intToBinPositive (size+dataOffset) : initializeStructureNonZero (size-1) dataOffset


main = do 
	instruction <- readFile "p3inputline.txt"
	let	op = take 6 instruction
	  	postOp = drop 7 instruction
	  	rs = take 5 postOp
	  	postRs = drop 6 postOp
	  	rt = take 5 postRs
	  	offset = drop 6 postRs
	print $ stringToInts (op++rs++rt++offset)