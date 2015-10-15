import System.Environment (getArgs)
import Data.List.Split
import Data.Char

getInput :: [Char] -> [[Char]]
getInput xs = reverse $ splitOn " " xs

prefixExpression :: [Char] -> Integer
prefixExpression xs = floor (prefixExpressionHelper (getInput xs) [])

prefixExpressionHelper :: [[Char]] -> [Float] -> Float
prefixExpressionHelper [] ys = head ys
prefixExpressionHelper (x:xs) ys | x == "+" = prefixExpressionHelper xs (((head ys)+(head $ tail ys)) : drop 2 ys)
                                 | x == "*" = prefixExpressionHelper xs (((head ys)*(head $ tail ys)) : drop 2 ys)
                                 | x == "/" = prefixExpressionHelper xs (((head ys)/(head $ tail ys)) : drop 2 ys)
                                 | otherwise = prefixExpressionHelper xs ((read x :: Float) : ys)

main = do
    [inpFile] <- getArgs
    input <- readFile inpFile
    -- print your output to stdout
    mapM_ putStrLn $ map show $ map prefixExpression $ lines input