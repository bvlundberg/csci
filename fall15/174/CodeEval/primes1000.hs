isPrime :: Int -> Bool
isPrime n = True

primes = take 1000 $ filter isPrime [1..]



main = do putStrLn $ show primes