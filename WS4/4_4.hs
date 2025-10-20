import GHC.Float (Floating(log1mexp))
-- a)
merge :: [Integer] -> [Integer] -> [Integer]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
    | x < y     = x : merge (dropWhile (== x) xs) (y:ys)
    | x > y     = y : merge (x:xs) (dropWhile (== y) ys)
    | otherwise = x : merge (dropWhile (== x) xs) (dropWhile (== x) ys)

-- b)
hamming :: [Integer]
hamming = 1 : merge (map (2*) hamming) 
                    (merge (map (3*) hamming) (map (5*) hamming))