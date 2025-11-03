calcPi1 :: Int -> Double
calcPi2 :: Int -> Double

calcPi1 x = sum (take x (zipWith (/) l1 l2))
    where
        l1 = 4 : -4 : l1
        -- l1 = cycle [4 , -4]
        l2 = [1 , 3..]
        -- l2 = [x | x <- [1..], odd x]

calcPi2 x = 3 + sum (take (x - 1) (zipWith (/) l1 l2))
    where
        multi x = x * (x + 1) * (x + 2)
        l1 = cycle [4 , -4]
        l2 = map multi [2, 4..]