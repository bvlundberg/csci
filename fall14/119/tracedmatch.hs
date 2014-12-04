-- Regular expressions
import Debug.Trace (trace)

data RE = Empty | Letter Char | Union RE RE | Cat RE RE | Star RE
instance (Show RE) where    -- use precedence to minimize parentheses
  showsPrec d Empty         = showString "@"
  showsPrec d (Letter c)    = showString [c]
  showsPrec d (Union r1 r2) = showParen (d > 6) $  -- prec(Union) = 6
                              showsPrec 6 r1 .
                              showString "+" .
                              showsPrec 6 r2
  showsPrec d (Cat r1 r2)   = showParen (d > 7) $  -- prec(Cat) = 7
                              showsPrec 7 r1 .
                              showsPrec 7 r2
  showsPrec d (Star r1)     = showsPrec 9 r1 .     -- prec(Star) = 8
                              showString "*"
           
-- Quick and dirty postfix regex parser, gives non-exaustive match on error
toRE :: String -> RE
toRE w = toRE' w [] where
  toRE' [] [r] = r
  toRE' ('+':xs) (r2:r1:rs) = toRE' xs (Union r1 r2:rs)
  toRE' ('.':xs) (r2:r1:rs) = toRE' xs (Cat r1 r2:rs)
  toRE' ('*':xs) (r:rs) = toRE' xs (Star r:rs)
  toRE' ('@':xs) rs = toRE' xs (Empty:rs)
  toRE' (x:xs) rs = toRE' xs (Letter x:rs)

-- Continuation "programs"
data Cont = Null | Simp RE Cont | Comp [Char] RE Cont
instance (Show Cont) where
  show Null = "[]"
  show (Simp r k) = show r ++ " || " ++ show k
  show (Comp w r k) = show r ++ " |" ++ w ++ "| " ++ show k

match2 :: RE -> [Char] -> Bool
match2 r w = m r w Null where
  m :: RE -> [Char] -> Cont -> Bool
  m r w k | trace (show r ++ " : " ++ show w ++ " -> " ++ show k) False = undefined
  m Empty w k = False
  m (Letter c) [] k = False
  m (Letter c) (x:xs) k = x == c && call k xs
  m (Union r1 r2) w k = m r1 w k || m r2 w k
  m (Cat r1 r2) w k = m r1 w (Simp r2 k)
  m (Star r1) w k = call k w || m r1 w (Comp w (Star r1) k)
  --
  call k w | trace ("call (" ++ show k ++ ") " ++ show w) False = undefined
  call Null w = null w
  call (Simp r k) w = m r w k
  call (Comp w r k) w' = w' /= w && m r w' k  

ex1 = Star(Union (Cat (Letter 'a') (Cat (Star (Cat (Letter 'b') (Cat (Star (Cat (Letter 'a') (Letter 'a'))) (Letter 'b')))) (Union (Letter 'a') (Cat (Letter 'b') (Cat (Star (Cat (Letter 'a') (Letter 'a'))) (Cat (Letter 'a') (Letter 'b')))))))(Cat (Letter 'b') (Cat (Star (Cat (Letter 'a') (Cat (Star (Cat (Letter 'b') (Letter 'b'))) (Letter 'a')))) (Union (Letter 'b') (Cat (Letter 'a') (Cat (Star (Cat (Letter 'b') (Letter 'b'))) (Cat (Letter 'b') (Letter 'a'))))))))
ex2 = Star(Union (Cat (Letter 'a') (Letter 'b')) (Cat (Letter 'b') (Letter 'a')))
ex3 = (Letter 'a')
ex4 = (Union (Letter 'b') (Letter 'a'))
ex5 = (Cat (Letter 'a') (Letter 'b'))
ex6 = (Union(Cat (Letter 'a') (Letter 'b')) (Star (Letter 'a')))