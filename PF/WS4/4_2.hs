primes :: [Integer]
primes = sieve [2..]
sieve :: [Integer] -> [Integer]
sieve (p:xs) = p : sieve [x | x <- xs, x`mod`p/=0]

twinPrimes :: [(Integer, Integer)]
twinPrimes = [(x , y) | (x , y) <- zip primes (tail primes), y == x + 2]