import System.Environment (getArgs)
import Data.List
import Data.Char

-- Calculate Max Range Sum
maxrangesum:: [Char] -> Int
maxrangesum xs = maxrangesumhelper (getDays xs) 0 (stringToInts xs)

maxrangesumhelper :: Int -> Int -> [Int] -> Int
maxrangesumhelper n m [] | m > 0 = m
                         | m <= 0 = 0
maxrangesumhelper n m (x:xs) | (length $ take n (x:xs)) < n && m > 0 = m
                       | (length $ take n (x:xs)) < n && m <= 0 = 0
                       | (length $ take n (x:xs)) >= n && sum (take n (x:xs)) > m = maxrangesumhelper n (sum $ take n (x:xs)) xs
                       | (length $ take n (x:xs)) >= n && sum (take n (x:xs)) <= m = maxrangesumhelper n m xs
 
removeNumberPrefix :: [Char] -> [Char]
removeNumberPrefix [] = []
removeNumberPrefix xs = drop 1 xs

getDays :: [Char] -> Int
getDays xs = (read $ takeWhile canUse xs) :: Int

-- Boolean to determine if individual characters are useful
canUse :: Char -> Bool
canUse x | isNumber x || x == '-' = True
         | otherwise = False

-- uses canUse boolean to build a string
simplifyString :: Char -> [Char]
simplifyString x  | canUse x = [x]
            | otherwise = [' ']

-- removes more characters from the simplified string
getValues :: [Char] -> [Char]
getValues xs = dropWhile isSpace $ concat $ map simplifyString $ removeNumberPrefix xs

-- convert strings to Doubles
convertToInts :: [Char] -> [Int]
convertToInts [] = []
convertToInts xs = (read $ takeWhile canUse xs :: Int) : convertToInts (dropWhile isSpace (drop (length (takeWhile canUse xs)) xs))

stringToInts :: [Char] -> [Int]
stringToInts xs = convertToInts $ getValues xs

-- Main program runs from here --
main = do
    [inpFile] <- getArgs
    input <- readFile inpFile
    -- print your output to stdout
    -- putStrLn show stringToPairs "1: ([37.788353, -122.387695], [37.829853, -122.294312])"
    mapM_ putStrLn $ map show $ map maxrangesum $ lines input
