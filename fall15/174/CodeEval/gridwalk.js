/*
Haskell Implementation

gridwalk :: Int
gridwalk = gridwalkhelper 0 0 [] 

gridwalkhelper :: Int -> Int -> [(Int, Int)] -> Int
gridwalkhelper x y as | x >= 0 && y >= 0 && x < 2 && y < 2 && isAllowed x y && not (isVisited x y as) = 1 + gridwalkhelper (x+1) y ((x,y):as) + gridwalkhelper (x-1) y ((x,y):as) + gridwalkhelper x (y+1) ((x,y):as) + gridwalkhelper x (y-1) ((x,y):as)
                      | otherwise = 0

sumValue :: Int -> Int
sumValue x | x < 10 = x
           | otherwise = (mod x 10) + sumValue (div x 10)

isAllowed :: Int -> Int -> Bool
isAllowed x y = (sumValue x + sumValue y) < 20 

isVisited :: Int -> Int -> [(Int, Int)] -> Bool
isVisited x y n = elem (x,y) n

--main = do
--    putStrLn $ gridwalk

<!--
gridwalk :: Int
gridwalk = gridwalkhelper 0 0 [] 

gridwalkhelper :: Int -> Int -> [(Int, Int)] -> Int
gridwalkhelper x y as | x >= 0 && y >= 0 && x < 2 && y < 2 && isAllowed x y && not (isVisited x y as) = 1 + gridwalkhelper (x+1) y ((x,y):as) + gridwalkhelper (x-1) y ((x,y):as) + gridwalkhelper x (y+1) ((x,y):as) + gridwalkhelper x (y-1) ((x,y):as)
                      | otherwise = 0

sumValue :: Int -> Int
sumValue x | x < 10 = x
           | otherwise = (mod x 10) + sumValue (div x 10)

isAllowed :: Int -> Int -> Bool
isAllowed x y = (sumValue x + sumValue y) < 20 

isVisited :: Int -> Int -> [(Int, Int)] -> Bool
isVisited x y n = elem (x,y) n
*/

var pointsvisited = [];
var axispointsfound = 0;
var pointsfound = 0;
function gridwalk(){
    gridwalkhelper(0,0);
    // Origin + points in the quadrant + points on the axis
    // Since the positive x and y axis are being accounted for in the algorithm,
    // I only multiply by 2 to get the other 2 axises
    return 1 + (pointsfound * 4) + (axispointsfound * 2);
}

function gridwalkhelper(x, y){
    if(isAllowed(x,y) && !isVisited(x,y)){
        //console.log(x, y);
        pointsvisited[[x,y]] = true;
        if(x === 0 && y === 0);
        else if(x === 0 || y === 0){
            axispointsfound++;
        }
        else{
            pointsfound++;
        }
       gridwalkhelper((x+1),y);
       gridwalkhelper((x-1),y);
       gridwalkhelper(x,(y+1));
       gridwalkhelper(x,(y-1));
    }
    else{
        return 0;
    }
}
var sumvalue = function(x){
  if(x < 10){
    return x;    
    }
    else{
      return (x % 10) + sumvalue(Math.floor(x/10));   
    }
};

var isAllowed = function(x, y){
    if(x < 0 || y < 0)
        return false;
    else
      return (sumvalue(Math.abs(x)) + sumvalue(Math.abs(y))) < 20;
};

/*
var isVisited = function(x, y){
    for(var i = 0; i < pointsvisited.length; i++){
        if(pointsvisited[i].x == x && pointsvisited[i].y == y)
            return true
    }
  return false;
};
*/

var isVisited = function (x, y) {
    if (pointsvisited[[x, y]])
        return true;

    return false;
};

console.log(gridwalk());