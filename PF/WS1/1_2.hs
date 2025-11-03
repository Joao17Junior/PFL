divideList :: [Int] -> String
divideList l1 = if length l1 <= 1 
                then "List is too small (< 2 items)"
                else "left half " ++ show l1 ++ " == " ++ show(take (length l1 `div` 2) l1) ++
                "\nright half " ++ show l1 ++ " == " ++ show(drop (length l1 `div` 2) l1 )

firstHlf :: [Int] -> [Int]
firstHlf l1 = take (length l1 `div` 2) l1

scndHlf :: [Int] -> [Int]
scndHlf l1 = drop (length l1 `div` 2) l1