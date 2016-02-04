import System.Environment (getArgs)
import Data.List.Split
import Data.Char

-- Rows: 	m
-- Column: 	n

--input1 :: [Char]
--input1 = "3,5;**.........*..."

--input2 :: [Char]
--input2 = "4,4;*........*......"

countBombs :: Int -> Int -> [Char] -> Int -> [Char]
countBombs m n grid x | grid !! x == '*' = "*"
                      | otherwise = 
                            let ul = if ((x - n - 1) >= 0 -- On grid
                                        && grid !! (x - n - 1) == '*' -- Is Bomb 
                                        && (div (x - n) n) == (div (x - n - 1) n)) -- Touching X 
                                        then 1
                                        else 0
                                um = if ((x - n) >= 0 -- On grid
                                        && grid !! (x - n) == '*') -- Is bomb
                                        then 1
                                        else 0
                                ur = if ((x - n + 1) >= 0 -- On grid
                                        && grid !! (x - n + 1) == '*' -- Is bomb 
                                        && (div (x - n) n) == (div (x - n + 1) n)) -- Touching X
                                        then 1
                                        else 0
                                ml = if ((x - 1) >= 0 -- On grid
                                        && grid !! (x - 1) == '*' -- Is bomb 
                                        && (div (x - 1) n) == (div x n)) -- Touching X
                                        then 1 
                                        else 0
                                mr = if ((x + 1) <= ((length grid) - 1) -- On grid
                                        && grid !! (x + 1) == '*' -- Is bomb
                                        && (div (x + 1) n) == (div x n)) -- Touching X
                                        then 1 
                                        else 0
                                ll = if ((x + n - 1) <= ((length grid) - 1) -- On grid
                                        && grid !! (x + n - 1) == '*' -- Is bomb
                                        && (div (x + n - 1) n) == (div (x + n) n)) -- Touching X 
                                        then 1 
                                        else 0
                                lm = if ((x + n) <= ((length grid) - 1) -- On grid
                                        && grid !! (x + n) == '*') -- Is bomb
                                        then 1 
                                        else 0
                                lr = if ((x + n + 1) <= ((length grid) - 1) -- On grid
                                        && grid !! (x + n + 1) == '*' -- Is bomb
                                        && (div (x + n + 1) n) == (div (x + n) n)) -- Touching X 
                                        then 1 
                                        else 0
                            in show (ul + um + ur + ml + mr + ll + lm + lr)

sweepDaMines :: [Char] -> [Char]
sweepDaMines input = 
    let firstSplit = splitOn ";" input
        secondSplit = splitOn "," (head firstSplit)
        rows = head secondSplit
        columns = head $ tail secondSplit
        grid = head $ tail firstSplit
    in  sweepDaMinesHelper (read rows :: Int) (read columns :: Int) grid

sweepDaMinesHelper :: Int -> Int -> [Char] -> [Char]
sweepDaMinesHelper m n grid = concat $ map (\x -> countBombs m n grid x) [0 .. ((length grid) - 1)]


main = do
    [inpFile] <- getArgs
    input <- readFile inpFile
    -- print your output to stdout
    mapM_ putStrLn $ map sweepDaMines (lines input)
