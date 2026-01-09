% a) greatest common divisor
gcd(X, 0, X).
gcd(X, Y, G):-
    Y > 0,
    R is X mod Y,
    gcd(Y, R, G).

% b) least common multiple
lcm(X, Y, M):- 
    gcd(X, Y, G),           
    M is (X * Y) // G.      

