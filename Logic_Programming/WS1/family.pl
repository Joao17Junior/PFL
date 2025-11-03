% primeira gen
male(Frank).
female(Grace).
female(DeDe).
male(Jay).
female(Gloria).
male(Javier).
female(Merie).
male(Barb).

% segunda gen
male(Phil).
female(Claire).
male(Joe).
male(Manny).
female(Mitchell).
male(Cameron).
male(Pameron).
female(Bo).

% terceira gen
male(Dylan).
female(Haley).
male(Alex).
male(Luke).
female(Lily).
male(Rexford).
male(Calhoun).

% quarta gen
male(George).
female(Poppy).

%%% RELAÇÔES %%%
% Primeira geração
parent(Grace, Phil).
parent(Frank, Phil).

parent(DeDe, Claire).
parent(Jay, Claire).
parent(DeDe, Mitchell).
parent(Jay, Mitchell).

parent(Jay, Joe).
parent(Gloria, Joe).

parent(Javier, Manny).
parent(Gloria, Manny).

parent(Barb, Cameron).
parent(Merle, Cameron).
parent(Barb, Pameron).
parent(Merle, Pameron).

parent(Bo, Calhoun).
parent(Pameron, Calhoun).

% Segunda geração
parent(Phil, Haley).
parent(Claire, Haley).
parent(Phil, Alex).
parent(Claire, Alex).
parent(Phil, Luke).
parent(Claire, Luke).

parent(Mitchell, Lily).
parent(Cameron, Lily).
parent(Mitchell, Rexford).
parent(Cameron, Rexford).

% Terceira geração
parent(Haley, George).
parent(Dylan, George).
parent(Haley, Poppy).
parent(Dylan, Poppy).

%%% NEW RULES %%%

% father /2
father(X, Y) :- male(X), parent(X, Y).

% mother /2
mother(X, Y) :- female(X), parent(X, Y).

% grandparent /2
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

% sibling /2
sibling(X, Y) :- father(Z, X), father(Z, Y), mother(W, X), mother(W, Y), X\=Y.

% halfsiblings /2
halfsiblings(X, Y) :- parent(Z, X), parent(Z, Y), X\=Y, \+ (parent(Q, X), parent(Q, Y), Q \= Z).
