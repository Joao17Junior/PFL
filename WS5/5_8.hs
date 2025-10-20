booleans :: Int -> [[Bool]]
booleans 0 = [[]]
booleans n = [b : bs | b <- [False, True], bs <- booleans (n-1)]