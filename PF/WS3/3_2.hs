-- a)
lDHelper :: Int -> Int -> Int
lDHelper n d    | n `mod` d == 0 = d
                | d*d > n = 0
                | otherwise = lDHelper n (d+1)
leastDiv :: Int -> Int
leastDiv n = lDHelper n 2

-- b)
isPrimeFast :: Int -> Bool
isPrimeFast n   | leastDiv n == 0 = True
                | otherwise = False