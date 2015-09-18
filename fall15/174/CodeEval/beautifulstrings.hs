import System.Environment (getArgs)
import Data.List
import Data.Char

makeLowercase :: [Char] -> [Char]
makeLowercase xs = Data.List.map toLower xs

makeAlpha :: [Char] -> [Char]
makeAlpha [] = []
makeAlpha (x:xs) | isAlpha x = x : makeAlpha xs
                 | otherwise = makeAlpha xs

calculateFrequency :: Char -> [Char] -> Integer
calculateFrequency a [] = 0
calculateFrequency a (x:xs) | a == x = 1 + calculateFrequency a xs
                            | otherwise = calculateFrequency a xs

removeLetter :: Char -> [Char] -> [Char]
removeLetter a [] = []
removeLetter a (x:xs) | a == x = removeLetter a xs
                      | otherwise = x: removeLetter a xs 

calculateEachFrequency :: [Char] -> [Integer]
calculateEachFrequency [] = []
calculateEachFrequency (x:xs) = calculateFrequency x (x:xs) : calculateEachFrequency (removeLetter x xs) 


calculateBeauty :: Integer -> [Integer] -> Integer
calculateBeauty n [] = 0
calculateBeauty n (x:xs) = (x * n) + calculateBeauty (n - 1) xs

beautifyString :: [Char] -> Integer
beautifyString xs = calculateBeauty 26 (reverse $ sort $ calculateEachFrequency $ makeAlpha $ makeLowercase xs)

main = do
    [inpFile] <- getArgs
    input <- readFile inpFile
    -- print your output to stdout
    mapM_ putStrLn $ map show $ map beautifyString $ lines input


-- calculateBeauty 26 (calculateEachFrequency $ makeAlpha $ makeLowercase xs)

-- Author: Brandon Lundberg
-- File Name: BeautifulStrings.hs
-- Purpose: Solve the beautiful strings problem from Code Eval
-- Date: 26 August 2015

-- Challenge Description:
-- When John was a little kid he didn't have much to do. There was no internet, no Facebook, and no programs to hack on.
-- So he did the only thing he could... he evaluated the beauty of strings in a quest to discover the most beautiful string in the world. 
-- Given a string s, little Johnny defined the beauty of the string as the sum of the beauty of the letters in it. 
-- The beauty of each letter is an integer between 1 and 26, inclusive, and no two letters have the same beauty. 
-- Johnny doesn't care about whether letters are uppercase or lowercase, so that doesn't affect the beauty of a letter. 
-- (Uppercase 'F' is exactly as beautiful as lowercase 'f', for example.) 
-- You're a student writing a report on the youth of this famous hacker. You found the string that Johnny considered most beautiful.
-- What is the maximum possible beauty of this string?


