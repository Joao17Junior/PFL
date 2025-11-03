data List a = Empty | Cons a (List a)

toList :: [a] -> List a
fromList :: List a -> [a]

toList [] = Empty
toList (x:xs) = Cons x (toList xs)

fromList Empty = []
fromList (Cons x xs) = x : fromList xs