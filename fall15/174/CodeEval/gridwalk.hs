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
-->

var answer = 0;
var visited = [];
function gridwalk(){
    answer = gridwalkhelper(0,0);
    return answer;
}

function gridwalkhelper(x, y){
    if(isAllowed(x,y) && !isVisited(x,y)){
        visited.push({x: x, y: y});
        1 + gridwalkhelper((x+1),y) + gridwalkhelper((x-1),y) + gridwalkhelper(x,(y+1)) + gridwalkhelper(x,(y-1));
    }
    else{
        return 0;
    }
	return 1;
}
var sumvalue = function(x){
	if(x < 10){
		return x;    
    }
    else{
    	(x % 10) + sumvalue(Math.floor(x/10));   
    }
};

var isAllowed = function(x, y){
	return sumvalue(x) + sumvalue(y) < 20 ;
};

var isVisited = function(x, y){
	return (visited.indexOf({x: x, y: y}) != -1);
};

//console.log(gridwalk());

// 11/9

var answer = 0;
var visited = [];
function gridwalk(){
    answer = gridwalkhelper(0,0);
    return answer;
}

function gridwalkhelper(x, y){
    if(isAllowed(x,y) && !isVisited(x,y)){
        visited.push({x: x, y: y});
        
        return 1 + gridwalkhelper((x+1),y) + gridwalkhelper((x-1),y) + gridwalkhelper(x,(y+1)) + gridwalkhelper(x,(y-1));
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
      (x % 10) + sumvalue(Math.floor(x/10));   
    }
};

var isAllowed = function(x, y){
  return sumvalue(x) + sumvalue(y) < 20 ;
};

var isVisited = function(x, y){
    for(i = 0; i < visited.length; i++){
        if(visited[i].x == x && visited[i].y == y)
            return true
    }
  return false;
};

console.log(gridwalk());