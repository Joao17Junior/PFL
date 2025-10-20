import Data.List (sortBy)


data Suit = Clubs | Spades | Hearts | Diamonds
    deriving (Show, Eq, Enum, Bounded, Ord)

data Face = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King | Ace
    deriving (Show, Eq, Enum, Bounded, Ord)

type Card = (Suit, Face)

allCards :: [Card]
allCards = [(s, f) | s <- [minBound ..], f <- [minBound ..]]

------------------------------------------------------------
-- a)
cmp1 :: Card -> Card -> Ordering

cmp1 (s1, f1) (s2, f2) = case compare s1 s2 of 
                            EQ -> compare f1 f2
                            ord -> ord

-- b)
cmp2 :: Card -> Card -> Ordering

cmp2 (s1, f1) (s2, f2) = case compare f1 f2 of
                            EQ -> compare s1 s2
                            ord -> ord
