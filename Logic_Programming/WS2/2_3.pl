a(a1, 1). 
a(A2, 2). 
a(a3, N). 
b(1, b1). 
b(2, B2). 
b(N, b3). 
c(X, Y):- a(X, Z), b(Z, Y). 
d(X, Y):- a(X, Z), b(Y, Z). 
d(X, Y):- a(Z, X), b(Z, Y). 