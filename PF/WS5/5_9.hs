import Distribution.PackageDescription (ConfVar(Impl))
type Name = Char-- ’x’, ’y’, ’z’, etc.
type Env = [(Name, Bool)]

booleans :: Int -> [[Bool]]
booleans 0 = [[]]
booleans n = [b : bs | b <- [False, True], bs <- booleans (n-1)]
-----------------------------------------------------------------

environments :: [Name] -> [Env]
environments names = map (zip names) (booleans (length names))