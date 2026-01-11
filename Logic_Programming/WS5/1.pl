%%%% Family Relations %%%%
% primeira gen
male('Frank').
female('Grace').
female('DeDe').
male('Jay').
female('Gloria').
male('Javier').
female('Merie').
male('Barb').

% segunda gen
male('Phil').
female('Claire').
male('Joe').
male('Manny').
female('Mitchell').
male('Cameron').
male('Pameron').
female('Bo').

% terceira gen
male('Dylan').
female('Haley').
male('Alex').
male('Luke').
female('Lily').
male('Rexford').
male('Calhoun').

% quarta gen
male('George').
female('Poppy').

%%% RELAÇÔES %%%
% Primeira geração
parent('Grace', 'Phil').
parent('Frank', 'Phil').

parent('DeDe', 'Claire').
parent('Jay', 'Claire').
parent('DeDe', 'Mitchell').
parent('Jay', 'Mitchell').

parent('Jay', 'Joe').
parent('Gloria', 'Joe').

parent('Javier', 'Manny').
parent('Gloria', 'Manny').

parent('Barb', 'Cameron').
parent('Merle', 'Cameron').
parent('Barb', 'Pameron').
parent('Merle', 'Pameron').

parent('Bo', 'Calhoun').
parent('Pameron', 'Calhoun').

% Segunda geração
parent('Phil', 'Haley').
parent('Claire', 'Haley').
parent('Phil', 'Alex').
parent('Claire', 'Alex').
parent('Phil', 'Luke').
parent('Claire', 'Luke').

parent('Mitchell', 'Lily').
parent('Cameron', 'Lily').
parent('Mitchell', 'Rexford').
parent('Cameron', 'Rexford').

% Terceira geração
parent('Haley', 'George').
parent('Dylan', 'George').
parent('Haley', 'Poppy').
parent('Dylan', 'Poppy').
%%%%%%%%%%%%%%%%%%%%%
%%%%% Exercises %%%%%

% a)

%children(P,C):- findall(X, parent(P,X), C).    % only selects children (useful for list of all children)
children(P,C):- bagof(X, parent(P,X), C).       % also groups every children to its parents

% b)

children_of(LP, PC):- findall(LP-C, parent(LP, C), PC).

% c)

family(F):- setof(X, Y^(parent(X,Y); parent(Y,X)), F).
% sees all people of the family that is either Parent or Child
% setof automatically removes duplicates and sorts the result

% e) couples(List) -> retorna lista de todos os casais com filhos, sem dups
couples(L):- setof(X-Y, Child^(parent(X,Child), parent(Y,Child), X @< Y), L).