data Suit = Clubs | Spades | Hearts | Diamonds
    deriving (Show, Eq, Enum, Bounded)

data Face = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King | Ace
    deriving (Show, Eq, Enum, Bounded)

type Card = (Suit, Face)

allCards :: [Card]
allCards = [(s, f) | s <- [minBound ..], f <- [minBound ..]]