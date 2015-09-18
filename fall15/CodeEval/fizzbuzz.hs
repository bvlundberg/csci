import System.Environment (getArgs)

fizzbuzz :: [Int] -> [Char]
fizzbuzz (a:b:c:[]) = fizzbuzzhelper a b c

fizzbuzzhelper :: Int -> Int -> Int -> [Char]
fizzbuzzhelper x y n = reverse $ drop 1 $ reverse $ concat [if mod a x == 0 && mod a y == 0 then "FB " else if mod a x == 0 then "F " else if mod a y == 0 then "B " else (show a) ++ " " | a <- [1..n] ]

getParameters :: [Char] -> [Int]
getParameters xs = map (read) (words xs) :: [Int]

main = do
    [inpFile] <- getArgs
    input <- readFile inpFile
    -- print your output to stdout
    -- putStrLn show stringToPairs "1: ([37.788353, -122.387695], [37.829853, -122.294312])"
    mapM_ putStrLn $ map fizzbuzz $ map getParameters $ lines input
