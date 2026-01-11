% ========================================
% exercicio 6 - Missionaries and cannibals 
% ========================================
% missionaries_and_cannibals(-Moves) 
% 3 missionaries & 3 cannibals
% no of cannibals !> missionaries at any time
% movements made in order to make the crossing

movimento(1, 0).
movimento(2, 0).
movimento(0, 1).
movimento(0, 2).
movimento(1, 1).

move(estado(M1, C1, esq), estado(M2, C2, dir)):-
    movimento(MB, CB),
    M2 is M1 - MB,
    C2 is C1 - CB,
    safe(M2, C2).

move(estado(M1, C1, dir), estado(M2, C2, esq)):-
    movimento(MB, CB),
    M2 is M1 + MB,
    C2 is C1 + CB,
    safe(M2, C2).

safe(M, C):- 
    M >= 0, M =< 3, 
    C >= 0, C =< 3,
    (M >= C; M =:= 0),

    M_dir is 3 - M,
    C_dir is 3 - C,
    (M_dir >= C_dir; M_dir =:= 0).

missionaries_and_cannibals(Moves):-
    dfs(estado(3, 3, esq), [estado(3, 3, esq)], Moves).

dfs(estado(0, 0, dir), V, V).
dfs(EstadoAtual, Visited, Solution):-
    move(EstadoAtual, ProximoEstado),
    \+ member(ProximoEstado, Visited),
    dfs(ProximoEstado, [ProximoEstado|Visited], Solution).
