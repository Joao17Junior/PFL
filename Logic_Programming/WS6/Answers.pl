% ===========
% exercicio 1
% ===========
% a) map(+Pred, +List1, ?List2) - same as maplist/3 from lists library
double(X, Y):- Y is X * 2.

map(_, [], []).
map(Pred, [H|T], [V|R]):- 
    call(Pred, H, V),
    map(Pred, T, R).

% c) separate(+List, +Pred, -Yes, -No) - returns in Yes and No the elements X of List that make Pred(X) true or false, respectively
even(X):- 0 =:= X mod 2.

separate([], _, [], []).
separate([H|T], Pred, Y, N):-
    ( call(Pred, H) -> 
        Y = [H|Yt],
        separate(T, Pred, Yt, N)
    ;
        N = [H|Nt],
        separate(T, Pred, Y, Nt)
    ).

% ===========
% exercicio 2
% ===========
% a) my_functor/3 - same as functor/3, using =.. (univ) operator
% my_functor(Term, Name, Arity)
my_functor(Term, Name, 0):-
    atomic(Term), !,
    Name = Term.

my_functor(Term, Name, Arity):-
    nonvar(Term), !,                    % term is given
    Term =.. [Name|Args],
    length(Args, Arity).

my_functor(Term, Name, Arity):-
    nonvar(Name), nonvar(Arity), !,     % name and arity are given
    length(Args, Arity),                % gens a list w/ variables
    Term =.. [Name|Args].

% ===========
% exercicio 4
% ===========
% a) a ra b na c -> a ra (b na c)
% b) a la b na c -> não é possível
% c) a na b la c -> (a na b) la c
% d) a na b ra c -> não é possível
% e) a na b na c -> não é possível
% f) a la b la c -> (a la b) la c
% g) a ra b ra c -> a ra (b ra c)
% h) a la b ra c -> não é possível

% ===========
% exercicio 6
% ===========
% b) if X then Y else Z
:- op(600, fx, if).
:- op(500, xfy, then).
:- op(500, xfy, elif).
:- op(400, xfy, else).

if Cond then Rest :-
    Cond, !,
    process_this(Rest).

if _Cond then Rest :-
    process_next(Rest).

process_this(Action elif _) :- !, call(Action).
process_this(Action else _) :- !, call(Action).
process_this(Action) :- call(Action).

process_next(_Action elif ProxCond then Rest) :- if ProxCond then Rest.
process_next(_Action else Alt) :- call(Alt).

