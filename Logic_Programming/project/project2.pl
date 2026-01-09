:- use_module(library(lists)).

% ==============================================================================
% 1. CONSTRAINT PREDICATES
% ==============================================================================
% Each predicate takes the Board as the last argument: [A,B,C,D,E,F]
% Board indices: A=1, B=2, C=3, D=4, E=5, F=6.

% ------------------------------------------------------------------------------
% anywhere(X, Board): X can go into any of the positions.
% Always succeeds.
% ------------------------------------------------------------------------------
anywhere(_, _).

% ------------------------------------------------------------------------------
% next_to(X, Y, Board): X must be next to Y.
% The board is a chain: A-B-C-D-E-F. (A and F are NOT connected).
% Trivially satisfied if X and Y are the same color.
% ------------------------------------------------------------------------------
next_to(X, X, _) :- !.
next_to(X, Y, Board) :-
    consecutive(X, Y, Board);
    consecutive(Y, X, Board).

% Helper: Checks if two elements appear consecutively in a list.
consecutive(X, Y, [X, Y | _]).
consecutive(X, Y, [_ | T]) :- consecutive(X, Y, T).

% ------------------------------------------------------------------------------
% one_space(X, Y, Board): X must be exactly one space apart from Y.
% Example: A and C (1 and 3), B and D (2 and 4).
% Trivially satisfied if X and Y are the same color.
% ------------------------------------------------------------------------------
one_space(X, X, _) :- !.
one_space(X, Y, Board) :-
    sublist([X, _, Y], Board);
    sublist([Y, _, X], Board).

% Helper: Checks if Sub occurs inside List (similar to append logic).
sublist(Sub, List) :-
    append(_, Suffix, List),
    append(Sub, _, Suffix).

% ------------------------------------------------------------------------------
% across(X, Y, Board): X must be across from Y.
% Definition: A and B (indices 1,2) are across from D, E, and F (indices 4,5,6).
% Trivially satisfied if X and Y are the same color.
% ------------------------------------------------------------------------------
across(X, X, _) :- !.
across(X, Y, Board) :-
    element_at(X, Ix, Board),
    element_at(Y, Iy, Board),
    check_across(Ix, Iy).

% A, B (1,2) are across D, E, F (4,5,6)
check_across(Ix, Iy) :- member(Ix, [1,2]), member(Iy, [4,5,6]).
check_across(Ix, Iy) :- member(Iy, [1,2]), member(Ix, [4,5,6]).

% ------------------------------------------------------------------------------
% same_edge(X, Y, Board): X and Y must be on the same edge.
% Edges are defined as set {A, B} and set {D, E, F}.
% Note: C (3) is not part of either edge set in the text.
% Trivially satisfied if X and Y are the same color.
% ------------------------------------------------------------------------------
same_edge(X, X, _) :- !.
same_edge(X, Y, Board) :-
    element_at(X, Ix, Board),
    element_at(Y, Iy, Board),
    check_edge(Ix, Iy).

% Edge 1: {1, 2}, Edge 2: {4, 5, 6}
check_edge(Ix, Iy) :- member(Ix, [1,2]), member(Iy, [1,2]).
check_edge(Ix, Iy) :- member(Ix, [4,5,6]), member(Iy, [4,5,6]).

% ------------------------------------------------------------------------------
% position(X, List, Board): X must be in one of the positions in List.
% ------------------------------------------------------------------------------
position(X, ValidPositions, Board) :-
    element_at(X, Index, Board),
    member(Index, ValidPositions).

% Helper: Finds the 1-based Index of an Element in a List.
element_at(Element, Index, List) :-
    nth1(Index, List, Element).

% ==============================================================================
% 2. PART 1: THE SOLVER
% ==============================================================================

% solve(+Constraints, -Board)
% Receives a list of constraints and returns a Board satisfying all of them.
solve(Constraints, Board) :-
    % 1. Define the tokens
    Tokens = [green, yellow, blue, orange, white, black],
    
    % 2. Generate a valid permutation of tokens for the Board
    permutation(Tokens, Board),
    
    % 3. Check if this Board satisfies all constraints
    satisfy_all(Constraints, Board).

satisfy_all([], _).
satisfy_all([Constraint | Rest], Board) :-
    % Use call to append Board as the last argument to the constraint
    call(Constraint, Board),
    satisfy_all(Rest, Board).

% ==============================================================================
% 3. PART 2: THE SCORER
% ==============================================================================

% best_score(+Constraints, -Score)
% Computes the best possible score for a list of constraints.
% 0 = perfect, -1 = 1 violation, -2 = 2 violations, etc.
best_score(Constraints, Score) :-
    Tokens = [green, yellow, blue, orange, white, black],
    
    % Find all possible scores for every permutation of the board
    findall(S, (
        permutation(Tokens, Board),
        calculate_score(Constraints, Board, S)
    ), AllScores),
    
    % Return the maximum score (closest to 0)
    max_list(AllScores, Score).

% calculate_score(+Constraints, +Board, -Score)
% Calculates score for a specific board configuration.
calculate_score(Constraints, Board, Score) :-
    count_violations(Constraints, Board, Violations),
    Score is -Violations.

count_violations([], _, 0).
count_violations([Constraint | Rest], Board, Count) :-
    ( call(Constraint, Board) -> 
        Penalty = 0 
    ; 
        Penalty = 1 
    ),
    count_violations(Rest, Board, RestCount),
    Count is Penalty + RestCount.

% ==============================================================================
% 4. EXAMPLES (From Assignment Text)
% ==============================================================================

% %% 12 solutions
example(1, [
    next_to(white, orange),
    next_to(black, black),
    across(yellow, orange),
    next_to(green, yellow),
    position(blue, [1,2,6]),
    across(yellow, blue) 
]).

% %% 1 solution
example(2, [
    across(white, yellow),
    position(black, [1,4]),
    position(yellow, [1,5]),
    next_to(green, blue),
    same_edge(blue, yellow),
    one_space(orange, black) 
]).

% %% no solutions (best score should be -1)
example(3, [
    across(white, yellow),
    position(black, [1,4]),
    position(yellow, [1,5]),
    same_edge(green, black),
    same_edge(blue, yellow),
    one_space(orange, black) 
]).

% %% same as above, different order
example(4, [
    position(yellow, [1,5]),
    one_space(orange, black),
    same_edge(green, black),
    same_edge(blue, yellow),
    position(black, [1,4]),
    across(white, yellow) 
]).