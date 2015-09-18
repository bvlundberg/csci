import System.Environment (getArgs)
import Data.List
import Data.Char

-- Data Structure --
data Point = Point { 
                     xCoord :: Double,
                     yCoord :: Double
                   } deriving (Show, Eq) 

data Bridge = Bridge {
                     bridgeNumber :: Int,
                     startingPoint :: Point,
                     endingPoint :: Point
                     -- vector :: Vector
                     } deriving (Show, Eq) 

-- Takes list of pairs created from input format to a list of bridges --
buildBridges :: Int -> [[(Double, Double)]] -> [Bridge]
buildBridges n [] = []
buildBridges n (x:xs) = Bridge  {   bridgeNumber = n,
                                    startingPoint = Point { 
                                                            xCoord = fst $ head x,
                                                            yCoord = snd $ head x
                                                          },
                                    endingPoint = Point   { 
                                                            xCoord = fst $ head $ drop 1 x,
                                                            yCoord = snd $ head $ drop 1 x
                                                          }
                                } : buildBridges (n+1) xs

-- Direction and on segment are used to check intersections --
direction :: Point -> Point -> Point -> Double
direction ( Point {xCoord = x1, yCoord = y1}) (Point {xCoord = x2, yCoord = y2}) (Point {xCoord = x3, yCoord = y3}) = ((x3-x1)*(y2-y1)) - ((x2-x1)*(y3-y1))

onSegment :: Point -> Point -> Point -> Bool
onSegment ( Point {xCoord = x1, yCoord = y1}) (Point {xCoord = x2, yCoord = y2}) (Point {xCoord = x3, yCoord = y3}) | (min x1 x2 <= x3 && max x1 x2 >= x3) && (min y1 y2 <= y3 && max y1 y2 >= y3) = True
                                                                                                                    | otherwise = False
-- If two bridges intersect --
intersecting :: Bridge -> Bridge -> Bool
intersecting ( Bridge { bridgeNumber = n1,
                            startingPoint = s1,
                            endingPoint = e1}) 
             ( Bridge { bridgeNumber = n2,
                            startingPoint = s2,
                            endingPoint = e2})    | (((direction s2 e2 s1 > 0 && direction s2 e2 e1 < 0) ||  (direction s2 e2 s1 < 0 && direction s2 e2 e1 > 0)) && ((direction s1 e1 s2 > 0 && direction s1 e1 e2 < 0) ||  (direction s1 e1 s2 < 0 && direction s1 e1 e2 > 0))) = True
                                                  | direction s2 e2 s1 == 0 && onSegment s2 e2 s1 = True
                                                  | direction s2 e2 e1 == 0 && onSegment s2 e2 e1 = True
                                                  | direction s1 e1 s2 == 0 && onSegment s1 e1 s2 = True
                                                  | direction s1 e1 e2 == 0 && onSegment s1 e1 e2 = True
                                                  | otherwise = False
-- for any bridge, run this function against a list of bridges to see the intersecting relationship per bridge --
listBridgesIntersecting :: Bridge -> [Bridge] -> [Bool]
listBridgesIntersecting x ys = [intersecting x y | y <- ys, x /= y]

-- Checks if a list of booleans are all false, meaning there are no intersecting bridges --
hasBridgesIntersecting :: [Bool] -> Bool
hasBridgesIntersecting x = all (==False) x

-- Pair is defined by birdge number, followed by the intersection for that bridge
countIntersecting :: Bridge -> [Bridge] -> Int
countIntersecting ( Bridge { bridgeNumber = n, startingPoint = s, endingPoint = e}) allBridges = length (filter (==True) (listBridgesIntersecting ( Bridge { bridgeNumber = n, startingPoint = s, endingPoint = e}) allBridges))

-- Sort list in ascending order --
quicksort :: [Int] -> [Int]  
quicksort [] = []  
quicksort (x:xs) =   
    let smallerSorted = quicksort [a | a <- xs, a <= x]  
        biggerSorted = quicksort [a | a <- xs, a > x]  
    in  smallerSorted ++ [x] ++ biggerSorted  

-- Sort list in descending order --
bridgeQuicksort :: [Bridge] -> [Bridge] -> [Bridge]
bridgeQuicksort [] allBridges = []  
bridgeQuicksort (b@(Bridge { bridgeNumber = n, startingPoint = s, endingPoint = e}):xs) allBridges =   
    let smallerSorted = bridgeQuicksort [b' | b'@(Bridge { bridgeNumber = n', startingPoint = s', endingPoint = e'}) <- xs, countIntersecting b' allBridges <= countIntersecting b allBridges] allBridges
        biggerSorted = bridgeQuicksort [b' | b'@(Bridge { bridgeNumber = n', startingPoint = s', endingPoint = e'}) <- xs, countIntersecting b' allBridges > countIntersecting b allBridges] allBridges
    in  biggerSorted ++ [(Bridge { bridgeNumber = n, startingPoint = s, endingPoint = e})] ++ smallerSorted

-- Function called to give last list of bridges to be printed as output
getFinalBridges :: [Bridge] -> [Int]
getFinalBridges [] = []
getFinalBridges (x:xs) | countIntersecting x xs > 0 = getFinalBridges $ bridgeQuicksort xs xs
                       | otherwise = quicksort [n | ( Bridge { bridgeNumber = n, startingPoint = s, endingPoint = e}) <- (x:xs)]


-------- String manipulation / formatting --------

removeNumberPrefix :: [Char] -> [Char]
removeNumberPrefix [] = []
removeNumberPrefix xs = drop 1 xs

-- Boolean to determine if individual characters are useful 
canUse :: Char -> Bool
canUse x | isNumber x || x == '-' || x == '.' = True
         | otherwise = False

-- uses canUse boolean to build a string
simplifyString :: Char -> [Char]
simplifyString x  | canUse x = [x]
            | otherwise = [' ']

-- removes more characters from the simplified string
getValues :: [Char] -> [Char]
getValues xs = dropWhile isSpace $ concat $ map simplifyString $ removeNumberPrefix xs

-- convert strings to Doubles
convertToDoubles :: [Char] -> [Double]
convertToDoubles [] = []
convertToDoubles xs = (read $ takeWhile canUse xs :: Double) : convertToDoubles (dropWhile isSpace (drop (length (takeWhile canUse xs)) xs))

-- put Doubles into correct data type
convertToPairs :: [Double] -> [(Double, Double)]
convertToPairs [] = []
convertToPairs (x1:x2:xs) = (x1,x2) : convertToPairs xs

-- string to pairs
stringToPairs :: [Char] -> [(Double, Double)]
stringToPairs xs = convertToPairs $ convertToDoubles $ getValues xs



listOfPairs ::  [Char] -> [[(Double, Double)]]
listOfPairs xs = [stringToPairs x | x <- lines xs]

-- Main program runs from here --
main = do
    [inpFile] <- getArgs
    input <- readFile inpFile
    -- print your output to stdout
    -- putStrLn show stringToPairs "1: ([37.788353, -122.387695], [37.829853, -122.294312])"
    mapM_ putStrLn $ map show $ getFinalBridges $ bridgeQuicksort  (buildBridges 1 $ listOfPairs input) (buildBridges 1 $ listOfPairs input)

-- Author: Brandon Lundberg
-- Code Eval Username: bvlundberg
-- File Name: baybridges.hs
-- Purpose: Bay Bridges problem - Code Eval
-- Date: 4 September 2015 

-- CHALLENGE DESCRIPTION:
-- A new technological breakthrough has enabled us to build bridges that can withstand a 9.5 magnitude 
-- earthquake for a fraction of the cost. Instead of retrofitting existing bridges which would take decades and 
-- cost at least 3x the price we're drafting up a proposal rebuild all of the bay area's bridges more efficiently 
-- between strategic coordinates outlined below.

-- You want to build the bridges as efficiently as possible and connect as many pairs of points as possible with 
-- bridges such that no two bridges cross. When connecting points, you can only connect point 1 with another 
-- point 1, point 2 with another point 2.