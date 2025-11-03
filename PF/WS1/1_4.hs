checkTriangle :: Float-> Float-> Float-> Bool
checkTriangle a b c | a + b < c = False
                    | a + c < b = False
                    | b + c < a = False
                    | otherwise = True