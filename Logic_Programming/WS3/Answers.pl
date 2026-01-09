% exercise 2 - Recursion over Lists
% a)
list_size(L, S):-
    list_size_tail(L, 0, S).

list_size_tail([], Acc, Acc).
list_size_tail([H|T], Acc, S):-
    Acc1 is Acc + 1,
    list_size_tail(T, Acc1, S).

% b)
list_sum(L, S):-
    list_sum_tail(L, 0, S).

list_sum_tail([], Acc, Acc).
list_sum_tail([H|T], Acc, S):-
    Acc1 is Acc + H,
    list_sum_tail(T, Acc1, S).

% exercise 3 - List Manipulation
% a)
invert(L, LR):- invert(L, [], LR).

invert([], LR, LR).
invert([L|Ls], Acc, LR):-
    invert(Ls, [L|Acc], LR).

% b)
del_one(_, [], []).
del_one(E, [H|T], R):- 
    (E =:= H ->
        R = T                   
    ;
        del_one(E, T, R1),       
        R = [H|R1]               
    ).

% c)
del_all(_, [], []).
del_all(E, [H|T], R):-
    (E =:= H ->
        del_all(E, T, R1),
        R = R1
    ;
        del_all(E, T, R1),
        R = [H|R1]
    ).