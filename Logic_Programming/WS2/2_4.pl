% a)
factorial(1,1).

factorial(N,F):- 
    N > 1,
    N1 is N - 1,
    factorial(N1, F1),
    F is N * F1.

% b)
sum_rec(1,1).
sum_rec(N,Sum) :-
    N > 1,
    N1 is N - 1,
    sum_rec(N1, Sum1),
    Sum is N + Sum1.

% c)
pow_rec(X,0,1).
pow_rec(1,Y,1):- Y >= 0.
pow_rec(X,Y,P):-
    Y >= 0,
    Y1 is Y - 1,
    pow_rec(X,Y1,P1),
    P is X * P1.

% d)
square_rec(0,0).
square_rec(1,1).
square_rec(N,S):-
    square_rec_aux(N,N,S).

square_rec_aux(N,1,N).
square_rec_aux(N,T,P):-
    T > 1,
    T1 is T - 1,
    square_rec_aux(N,T1,P1),
    P is N + P1.

% e)
fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,F):-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1,F1),
    fibonacci(N2,F2),
    F is F1 + F2.
    
% f) 
collatz(0,'-').
collatz(1,0).
collatz(N,S):-
    N > 1,
    ( N mod 2 =:= 0 ->
        N1 is N // 2
    ;
        N1 is 3 * N + 1
    ),
    collatz(N1, S1),
    S is S1 + 1.

% g)
\+ is_prime(0).
is_prime(1).
is_prime(2).
is_prime(X):-
    X > 2,
    X mod 2 =\= 0,
    \+ has_divisor(X, 3).  

has_divisor(X, D):-
    D * D =< X,  
    X mod D =:= 0.  

has_divisor(X, D):-
    D * D =< X,
    D2 is D + 2,  
    has_divisor(X, D2)