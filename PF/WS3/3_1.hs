myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (x:ls) = x && myAnd ls

myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:ls) = x || myOr ls

myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (x:ls) = x ++ myConcat ls

myReplicate :: Int -> a -> [a]
myReplicate 0 a = []
myReplicate i a = [a] ++ myReplicate (i-1) a

myIndex :: [a] -> Int -> a
myIndex [] x = error "Out of Bounds"
myIndex (x1:ls) x   | x < 0 = error "Negative Index"
                    | x > 0 = myIndex ls (x-1)
                    | otherwise = x1

myElem :: Eq a => a -> [a] -> Bool
myElem x [] = False
myElem x (x1:ls)    | x == x1 = True
                    | otherwise = myElem x ls