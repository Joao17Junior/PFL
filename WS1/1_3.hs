second :: [Int] -> Int
second l1 = l1 !! 1

last :: [Int] -> Int
--last l1 = l1 !! (length l1 - 1)
last l1 = head (reverse l1)

init :: [Int] -> [Int]
--init l1 = reverse (tail (reverse l1))
init l1 = take (length l1 - 1) l1

middle :: [Int] -> Int
middle l1 = l1 !! (length l1 `div` 2)

checkPalindrome :: String -> Bool
checkPalindrome str = str == reverse str