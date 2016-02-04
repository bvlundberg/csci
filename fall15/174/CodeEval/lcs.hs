import System.Environment (getArgs)
import Data.List
import Data.List.Split
import Data.Char

input1 :: [Char]
input1 = "XMJYAUZ;MZJAWXU"

allSubsequences :: [Char] -> [Char]
allSubsequences [] = []
allSubsequences (x:xs) = (x:xs)

lcs :: [Char] -> [Char]
lcs input = 
    let split = splitOn ";" input
        firstString = head split
        secondString = head $ tail split
    in  lcsHelper (reverse $ subsequences firstString) (reverse $ subsequences secondString)

lcsHelper :: [[Char]] -> [[Char]] -> [Char]
lcsHelper [] ys = ""
lcsHelper (x:xs) ys | elem x ys = x
                    | otherwise = lcsHelper xs ys

{-
stringsLengthN :: [Char] -> Int -> Int -> [[Char]]
stringsLengthN xs size n = [x | elements <- [0..size]]
-}

{-
main = do
    [inpFile] <- getArgs
    input <- readFile inpFile
    -- print your output to stdout
    mapM_ putStrLn $ map sweepDaMines (lines input)
-}