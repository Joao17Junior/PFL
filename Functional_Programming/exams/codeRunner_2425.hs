import Graphics.Win32 (endUpdateResource)
type Match = ((String,String), (Int,Int))
type MatchDay = [Match]
type League = [MatchDay]
myLeague :: League
myLeague = [
    [(("Porto","Sporting"),(2,2)),(("Benfica","Vitoria SC"),(4,0))],
    [(("Porto","Benfica"),(5,0)),(("Vitoria SC","Sporting"),(3,2))],
    [(("Vitoria SC","Porto"),(1,2)),(("Sporting","Benfica"),(2,1))]
    ]

-- TODO: 1
winner :: Match -> String
winner ((t1, t2), (s1, s2))
    | s1 == s2 = "draw"
    | s1 < s2 = t2
    | otherwise = t1

-- TODO: 2
matchDayScore :: String -> MatchDay -> Int
matchDayScore str [] = 0
matchDayScore str (m:md) = mDSAux str m + matchDayScore str md
-- matchDayScore str md = foldr ((+) . mDSAux str) 0 md

mDSAux :: String -> Match -> Int
mDSAux str ((t1, t2), (s1, s2))
    | str == t1 && s1 > s2 = 3
    | str == t1 && s1 == s2 = 1
    | str == t2 && s2 > s1 = 3
    | str == t2 && s1 == s2 = 1
    | otherwise = 0

-- TODO: 3
-- code given by exam
leagueScore :: String -> League -> Int
leagueScore t = foldr (\d acc -> matchDayScore t d + acc) 0

sortByCond :: Ord a => [a] -> (a -> a -> Bool) -> [a]
sortByCond [] _ = []
sortByCond [x] _ = [x]
sortByCond l cmp = merge (sortByCond l1 cmp) (sortByCond l2 cmp) cmp
    where (l1 ,l2) = splitAt (div (length l) 2) l

merge :: Ord a => [a] -> [a] -> (a -> a -> Bool) -> [a]
merge [] l _ = l
merge l [] _ = l
merge (x:xs) (y:ys) cmp
    | cmp x y = x:(merge xs (y:ys) cmp)
    | otherwise = y:(merge (x:xs) ys cmp)

-- actual question
removeDuplicates :: Eq a => [a] -> [a]
removeDuplicates [] = []
removeDuplicates (x:xs) = x : removeDuplicates (filter (/= x) xs)

getTeams :: League -> [String]
getTeams league = removeDuplicates [t | day <- league, ((t1, t2),_) <- day, t <- [t1, t2]]

leagueScores :: League -> [(String, Int)]
leagueScores league = [(t, leagueScore t league) | t <- getTeams league]

ranking :: League -> [(String, Int)]
ranking l = sortByCond (leagueScores l) compareTeams
    where compareTeams (t1,s1) (t2,s2)
            | s1 == s2 = t1 < t2 
            | otherwise = s1 > s2 

-- TODO: 4
numMatchDaysWithDraws :: League -> Int
numMatchDaysWithDraws l = length (filter hasDraw l)
    where hasDraw = any (\m -> winner m == "draw")
-- numMatchDaysWithDraws l = length (filter (any (\m -> winner m == "draw")) l)
-- numMatchDaysWithDraws = length . filter (any ((== "draw") . winner))

-- TODO: 5
bigWins :: League -> [(Int,[String])]
bigWins l = [(i, [winner match | match@(_, (s1,s2)) <- matchDay, abs (s1 - s2) >= 3]) | (i, matchDay) <- zip [1..] l]

-- TODO: 6
{---- already implemented above ----
removeDuplicates :: Eq a => [a] -> [a]
removeDuplicates [] = []
removeDuplicates (x:xs) = x : removeDuplicates (filter (/= x) xs)

getTeams :: League -> [String]
getTeams league = removeDuplicates [t | day <- league, ((t1, t2),_) <- day, t <- [t1, t2]]
-}
zipLeagueIndex :: League -> [(MatchDay, Int)]
zipLeagueIndex l = zip l [1..]

winningDays :: League -> [(String, [Int])]
winningDays l = [(t, [i | (md,i) <- zipLeagueIndex l, ((t1,t2), (s1,s2)) <- md, (t == t1 && s1 > s2) || (t == t2 && s2 > s1)]) | t <- getTeams l]

streaks :: [Int] -> [(Int, Int)]
streaks [] = []
streaks (x:xs) = go x x xs 
    where 
        go s e [] = if e > s then [(s,e)] else []
        go s e (y:ys)
            | y == e+1 = go s y ys
            | e > s = (s,e) : streaks (y:ys)
            | otherwise = streaks (y:ys)

winningStreaks :: League -> [(String, Int, Int)]
winningStreaks l = [(team, s, e) | (team, days) <- winningDays l, (s, e) <- streaks days]

-- TODO: 9
-- data
data KdTree = Empty | Node Char (Int,Int) KdTree KdTree deriving (Eq,Show)

tree1 :: KdTree
tree1 = Node 'x' (3,3) (Node 'y' (2,2) Empty Empty) (Node 'y' (4,4) Empty Empty)

tree2 :: KdTree
tree2 = Node 'x' (3,3) (Node 'y' (2,2) (Node 'x' (1,1) Empty Empty) Empty) (Node 'y' (4,4) (Node 'x' (3,2) Empty Empty) Empty)

-- actual exercise
insert :: (Int, Int) -> KdTree -> KdTree
insert (x,y) = insertAux (x,y) 'x'

insertAux :: (Int, Int) -> Char -> KdTree -> KdTree
insertAux (x,y) ch Empty = Node ch (x,y) Empty Empty
insertAux (x1,y1) _ (Node sh (x2,y2) lTree rTree) 
    | (x1,y1) == (x2,y2) = Node sh (x2,y2) lTree rTree
    | sh == 'y' && y1 < y2 = Node sh (x2,y2) (insertAux (x1, y1) 'x' lTree) rTree
    | sh == 'y' && y1 >= y2 = Node sh (x2,y2) lTree (insertAux (x1, y1) 'x' rTree)
    | sh == 'x' && x1 < x2 = Node sh (x2,y2) (insertAux (x1, y1) 'y' lTree) rTree
    | sh == 'x' && x1 >= x2 = Node sh (x2,y2) lTree (insertAux (x1, y1) 'y' rTree)
    
-- TODO: 10
putTreeStr :: KdTree -> IO ()
putTreeStr tree = pTSAux tree ""

pTSAux :: KdTree -> String -> IO ()
pTSAux Empty str= putStr ""
pTSAux (Node ch (x,y) lTree rTree) str = do
    putStrLn strPoint 
    putStrLn strLCond
    pTSAux lTree (str ++ "  ")
    putStrLn strRCond
    pTSAux rTree (str ++ "  ")
    where
        strPoint = str ++ "(" ++ show x ++ "," ++ show y ++ ")"
        strLCond
            | ch == 'x' = str ++ "x<" ++ show x
            | otherwise = str ++ "y<" ++ show y
        strRCond
            | ch == 'x' = str ++ "x>=" ++ show x
            | otherwise = str ++ "y>=" ++ show y