import System.Environment (getArgs)
import Data.List
import Data.Char
import Data.List.Split
import Data.Ord
import Text.Printf

input :: String
input = "Mary had a little lamb its fleece was white as snow; And everywhere that Mary went, the lamb was sure to go. It followed her to school one day, which was against the rule; It made the children laugh and play, to see a lamb at school. And so the teacher turned it out, but still it lingered near, And waited patiently about till Mary did appear. 'Why does the lamb love Mary so?' the eager children cry; 'Why, Mary loves the lamb, you know' the teacher did reply."

--line1 :: String
--line1 = "2,the"
--line2 :: String
--line2 = "4,Mary had"
--line3 :: String
--line3 = "4,so the"

-- For testing
typeAhead :: String -> String
typeAhead line = 
    let fileInput = getValues $ getInput line
        sublists = createSublists (fst fileInput) (createStringArray $ makeAlpha input)
        afterTarget = getTextAfterTarget (snd fileInput) sublists
        totalFound = (length afterTarget)
        groupings = concat $ map sort $ groupBy (\x y -> snd x == snd y) $ reverse $ sortBy (comparing snd) $ map (\x -> (head x, (fromIntegral $ length x) / (fromIntegral totalFound))) (group $ sort afterTarget)
        answerWords = map (intercalate " ") $ map (\x -> fst x) groupings
        answerValues = map (\x -> snd x) groupings
    in  concat $ intersperse ";" $ combineValues answerWords answerValues

-- yo = map (printf "%.2f") answerValues 
-- answers = map (\x -> (fst x, (fromIntegral $ snd x) / ())) groupings

makeLowercase :: [Char] -> [Char]
makeLowercase xs = Data.List.map toLower xs

makeAlpha :: [Char] -> [Char]
makeAlpha [] = []
makeAlpha (x:xs) | isAlpha x  || x == ' ' = x : makeAlpha xs
                 | otherwise = makeAlpha xs

createStringArray :: [Char] -> [[Char]]
createStringArray xs = splitOn " " xs

getInput :: [Char] -> [[Char]]
getInput xs = splitOn "," xs --(makeLowercase xs)

getValues :: [[Char]] -> (Int, [[Char]])
getValues xs = (read (head xs) :: Int, splitOn " " (head (tail xs)))

createSublists :: Int -> [[Char]] -> [[[Char]]]
createSublists n (x:xs) | length (x:xs) < n = []
                        | otherwise = take n (x:xs) : createSublists n xs

getTextAfterTarget :: [[Char]] -> [[[Char]]] -> [[[Char]]]
getTextAfterTarget target [] = []
getTextAfterTarget target (x:xs) | target == take (length target) x = drop (length target) x : getTextAfterTarget target xs
                                 | otherwise = getTextAfterTarget target xs

combineValues :: [[Char]] -> [Double] -> [[Char]]
combineValues [] [] = []
combineValues (x:xs) (y:ys) =  (x ++ "," ++ (show y)) : combineValues xs ys
-- Main program runs from here --

main = do
    [inpFile] <- getArgs
    input <- readFile inpFile
    -- print your output to stdout
    mapM_ putStrLn $ map typeAhead $ lines input
