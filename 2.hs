classify :: Int -> String
classify x = if x <= 9 then "failed"
             else if x >= 10 && x <= 12 then "passed"
             else if x >= 13 && x <= 15 then "good"
             else if x >= 16 && x <= 18 then "very good"
             else "excellent"

classifyBMI :: Float -> Float -> String
classifyBMI weight height
    | bmi < 18.5 = "underweight"
    | bmi <= 24.9 = "normal weight"
    | bmi <= 29.9 = "overweight"
    | otherwise   = "obese"
    where bmi = weight / (height ^ 2)

max3 :: Int -> Int -> Int -> Int
max3 x y z = max x (max y z)

min3 :: Int -> Int -> Int -> Int
min3 x y z = min x (min y z)

xor :: Bool -> Bool -> Bool
xor a b = (a || b) && not (a && b)

safetail :: [a] -> [a]
safetail xs
    | null xs   = []
    | otherwise = tail xs

short :: [a] -> Bool
short xs = length xs < 3

median :: Int -> Int -> Int -> Int
median x y z 
    | (x <= y && y <= z) || (z <= y && y <= x) = y
    | (y <= x && x <= z) || (z <= x && x <= y) = x
    | otherwise                                 = z

propDivs :: Integer -> [Integer]
propDivs n = [x | x <- [1..n-1], n `mod` x == 0]

perfects :: Integer -> [Integer]
perfects n = [x | x <- [1..n], sum (propDivs x) == x]

pyths :: Integer -> [(Integer, Integer, Integer)]
pyths n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2, x <= n, y <= n, z <= n]

isPrime :: Integer -> Bool
isPrime n = null [x | x <- [2..(n-1)], n `mod` x == 0]

myconcat :: [a] -> [a] -> [a]
myconcat xs ys = [x | x <- xs] ++ [y | y <- ys]

myreplicate :: Int -> a -> [a]
myreplicate n x = [x | _ <- [1..n]]

binom :: Integer -> Integer -> Integer
binom n k = factorial n `div` (factorial k * factorial (n - k))
    where factorial 0 = 1
          factorial m = product [1..m]

pascal :: Integer -> [[Integer]]
pascal n = [[binom x y | y <- [0..x]] | x <- [0..n]]



