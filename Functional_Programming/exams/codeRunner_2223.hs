import GHC.ExecutionStack (Location(functionName))
import Distribution.Fields.Lexer (bol_section)
type Species = (String, Int)
type Zoo = [Species]

-- TODO: 1
isEndangered :: Species -> Bool
isEndangered (n, c) | c <= 100 = True
                    | otherwise = False

-- TODO: 2
updateSpecies :: Species -> Int -> Species
updateSpecies (n, v) nb = (n, nv) where nv = v + nb

-- TODO: 3
filterSpecies :: Zoo -> (Species -> Bool) -> Zoo
filterSpecies [] _ = []
filterSpecies (x:xs) func   | func x = x : filterSpecies xs func

-- TODO: 4
countAnimals :: Zoo -> Int
countAnimals [] = 0
countAnimals ((n,v):xs) = v + countAnimals xs 

-- TODO: 5
substring :: (Integral a) => String -> a -> a -> String
substring xs s e = [x | (i, x) <- zip [0..] xs, i <= e, i >= s]

-- TODO: 6
hasSubstr :: String -> String -> Bool
hasSubstr str sub = hasSubstrAux str sub sub

hasSubstrAux :: String -> String -> String -> Bool
hasSubstrAux _ [] _ = True
hasSubstrAux [] _ _ = False
hasSubstrAux (s:str) (h:sub) sub2   | s == h = hasSubstrAux str sub sub2
                                    | otherwise = hasSubstrAux str sub2 sub2

-- TODO: 7
{- sortSpeciesWithSubstr :: Zoo -> String -> (Zoo, Zoo)
sortSpeciesWithSubstr z str = (sortAuxHas z str, sortAuxNHas z str)

sortAuxHas :: Zoo -> String -> Zoo
sortAuxHas [] _ = []
sortAuxHas ((n,v) : z) str 
    | hasSubstr n str = (n,v) : sortAuxHas z str
    | otherwise = sortAuxHas z str

sortAuxNHas :: Zoo -> String -> Zoo
sortAuxNHas [] _ = []
sortAuxNHas ((n,v) : z) str
    | hasSubstr n str = sortAuxNHas z str
    | otherwise = (n,v) : sortAuxNHas z str -}

sortSpeciesWithSubstr :: Zoo -> String -> (Zoo, Zoo)
sortSpeciesWithSubstr [] _ = ([], [])
sortSpeciesWithSubstr ((n,v):z) str =
    if hasSubstr n str
    then ((n,v) : yes, no)
    else (yes, (n,v) : no)
    where (yes, no) = sortSpeciesWithSubstr z str

-- TODO: 8
rabbits :: (Integral a) => [a]
--rabbits = 2 : 3 : zipWith (+) rabbits (tail rabbits)
rabbits = 2 : 3 : next 2 3
    where next a b = (a+b) : next b (a+b)

-- TODO: 9
rabbitYears :: (Integral a) => a -> Int
rabbitYears v = length ([y | y <- rabbits, y < v])

-- TODO: 10
data Dendrogram = Leaf String | Node Dendrogram Int Dendrogram
myDendro :: Dendrogram
myDendro = Node (Node (Leaf "dog") 3 (Leaf "cat")) 5 (Leaf "octopus")

dendroWidth :: Dendrogram -> Int
dendroWidth (Leaf _) = 0
dendroWidth (Node d1 v d2) = 2 * v + dendroWidthAuxLeft d1 + dendroWidthAuxRight d2

dendroWidthAuxLeft :: Dendrogram -> Int
dendroWidthAuxLeft (Leaf _) = 0
dendroWidthAuxLeft (Node d1 v _) = v + dendroWidthAuxLeft d1

dendroWidthAuxRight :: Dendrogram -> Int
dendroWidthAuxRight (Leaf _) = 0
dendroWidthAuxRight (Node _ v d2) = v + dendroWidthAuxRight d2

-- TODO: 11
dendroInBounds :: Dendrogram -> Int -> [String]
dendroInBounds d1 v = [str | (str,val) <- dendroBoundCalc d1 0, val <= v]

dendroBoundCalc :: Dendrogram -> Int -> [(String, Int)]
dendroBoundCalc (Leaf str) v = [(str, abs v)]
dendroBoundCalc (Node d1 val d2) v = dendroBoundCalc d1 (v-val) ++ dendroBoundCalc d2 (v+val)
