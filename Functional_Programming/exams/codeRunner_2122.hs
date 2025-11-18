-- 1
maxpos :: [Int] -> Int
maxpos [] = 0
maxpos (x:xs) | x > maxpos xs = x
              | otherwise = maxpos xs

-- 2
dups :: [a] -> [a]
dups x = dupsAux x True

dupsAux :: [a] -> Bool -> [a]
dupsAux [] _ = []
dupsAux (x:xs) bl   | bl = [x] ++ [x] ++ dupsAux xs False
                    | otherwise = x : dupsAux xs True

-- 3
transforma :: String -> String
transforma [] = []
transforma (x:xs)   | x == 'a' || x == 'e' || x == 'i' || x == 'o' || x == 'u' = x : 'p' : x : transforma xs
                    | otherwise = x : transforma xs
                    -- deve ter uma maneira mais rapida de fazer sem ter de usar 5 or's

-- 4 !!
type Vector = [Int] 
type Matriz = [[Int]] 

transposta :: Matriz -> Matriz
transposta [] = []
transposta m = [head x | x <- m] : transposta [tail x | x <- m, tail x /= []]

-- 5
prodInterno :: Vector -> Vector -> Int
prodInterno [] [] = 0
prodInterno (x:xs) (y:ys) = x * y + prodInterno xs ys
--prodInterno xs ys = head xs * head ys + prodInterno (tail xs) (tail ys)

-- 6

-- 7
data Arv a = F | N a (Arv a) (Arv a) 
    deriving(Show) 

alturas :: Arv a -> Arv Int
alturas F = F
alturas (N a a1 a2) = N (alturasAux (N a a1 a2)) (alturas a1) (alturas a2)

alturasAux :: Arv a -> Int
alturasAux F = 0
alturasAux (N a a1 a2) = 1 + max (alturasAux a1) (alturasAux a2)

-- 8

-- 9 
f :: (a -> b -> c) -> b -> a -> c
f fun b a = fun a b