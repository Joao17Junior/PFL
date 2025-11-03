nub :: Eq a => [a] -> [a] 
nub [] = []
nub (x:ls)  | tail ls == x 