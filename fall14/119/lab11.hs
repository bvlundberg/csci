import Data.List (sort,elemIndex,findIndices)

-- normalize a list, i.e., sort and remove (now adjacent) duplicates
norm :: Ord a => [a] -> [a]
norm = mynub . sort where
  mynub [] = []
  mynub [x] = [x]
  mynub (x:ys@(y:zs)) | x == y = mynub ys
                      | otherwise = x : mynub ys

strings :: Int -> [[Char]]
strings 0 = [""]
strings n = concat [map (a:) (strings (n-1))| a <- sigma]
----------------The Expression-----------------------
ex1 = Star(Union (Cat (Letter 'a') (Cat (Star (Cat (Letter 'b') (Cat (Star (Cat (Letter 'a') (Letter 'a'))) (Letter 'b')))) (Union (Letter 'a') (Cat (Letter 'b') (Cat (Star (Cat (Letter 'a') (Letter 'a'))) (Cat (Letter 'a') (Letter 'b')))))))(Cat (Letter 'b') (Cat (Star (Cat (Letter 'a') (Cat (Star (Cat (Letter 'b') (Letter 'b'))) (Letter 'a')))) (Union (Letter 'b') (Cat (Letter 'a') (Cat (Star (Cat (Letter 'b') (Letter 'b'))) (Cat (Letter 'b') (Letter 'a'))))))))

-----------------------------------------------------

sigma = ['a','b']
data RE  = Empty | Letter Char | Union RE RE | Cat RE RE | Star RE deriving Show
type FSM a = ([a], a, [a], [(a, Char, a)])

splits :: [a] -> [([a], [a])]
splits [] = [([],[])]
splits (w:rest) = ([], w:rest):map (\(ys1, ys2) -> (w:ys1, ys2)) (splits rest)


match :: RE -> [Char] -> Bool
match Empty w = False
match (Letter c) [] = False
match (Letter c) (x:xs) = x == c && null xs
match (Union r1 r2) w = match r1 w || match r2 w
match (Cat r1 r2) w = any (\(w1, w2) -> match r1 w1 && match r2 w2) (splits w)
match (Star r1) w = null w || any (\(w1, w2) -> match r1 w1 && match (Star r1) w2) (tail (splits w))

match2' :: RE -> [Char] -> Bool
match2' r w = match' r w null

match' :: RE -> [Char] -> ([Char] -> Bool) -> Bool

match' Empty w k = False
match' (Letter c) [] k = False
match' (Letter c) (x:xs) k = x == c && k xs
match' (Union r1 r2) w k = match' r1 w k || match' r2 w k
match' (Cat r1 r2) w k = match' r1 w (\w' -> match' r2 w' k)
match' (Star r1) w k = k w || match' r1 w (\w' -> w' /= w && match' (Star r1) w' k)

