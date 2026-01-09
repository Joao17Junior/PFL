% a) -- only fibonacci
fibonacci(N,F):-
    fibonacci_tail(N, 0, 1, F).

fibonacci_tail(0, Prev, _, Prev).
fibonacci_tail(N, Prev, Cur, F):-
    N > 0,
    N1 is N - 1,
    Next is Prev + Cur,
    fibonacci_tail(N1, Cur, Next, F).