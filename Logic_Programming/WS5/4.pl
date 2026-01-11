%flight(origin, destination, company, code, hour, duration) 
flight(porto, lisbon, tap, tp1949, 1615, 60). 
flight(lisbon, madrid, tap, tp1018, 1805, 75). 
flight(lisbon, paris, tap, tp440, 1810, 150). 
flight(lisbon, london, tap, tp1366, 1955, 165). 
flight(london, lisbon, tap, tp1361, 1630, 160). 
flight(porto, madrid, iberia, ib3095, 1640, 80). 
flight(madrid, porto, iberia, ib3094, 1545, 80). 
flight(madrid, lisbon, iberia, ib3106, 1945, 80). 
flight(madrid, paris, iberia, ib3444, 1640, 125). 
flight(madrid, london, iberia, ib3166, 1550, 145). 
flight(london, madrid, iberia, ib3163, 1030, 140). 
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165). 
%=========================
%       EXERCISES  
%=========================    
% a)
get_all_nodes(LAirports):- setof(AP, O^C^Cd^H^D^(flight(AP,O,C,Cd,H,D); flight(O,AP,C,Cd,H,D)), LAirports).
% sees all airports that are the origin or the destination of the flight
% setof automatically removes duplicates and sorts the result

% c) find_flights(+Origin, +Destination, -Flights) - usa DFS para retornar uma lista com os codigos dos voos entre a origem e destino dados
find_flights(O, D, F):- 
    find_flights(O, D, [O], F).

find_flights(O, D, _, [C]):-                    % Base case: direct flight
    flight(O, D, _, C, _, _).

find_flights(O, D, Visited, [C|F]):-            % Recursive case: flight with connections
    flight(O, Next, _, C, _, _),
    \+ member(Next, Visited),                   % Avoid cycles!
    find_flights(Next, D, [Next|Visited], F).

% d) find_flights_bfs(+Origin, +Destination, -Flights) - igual ao exercicio anterior mas com BFS
% vvvvv gemini version vvvvv - still not functional 100%
find_flights_bfs(Origin, Destination, Flights) :-
    bfs([(Origin, [])], Destination, Flights).

bfs([(Destination, Path)|_], Destination, Path).
bfs([(Curr, Path)|RestQueue], Destination, FinalPath) :-
    findall(
        (Next, [Code|Path]),
        (
            flight(Curr, Next, _, Code, _, _),
            \+ member(Code, Path) 
        ),
        NewPaths
    ),
    append(RestQueue, NewPaths, NextQueue),
    bfs(NextQueue, Destination, FinalPath).

% f) find_flights_least_stops(+Origin, +Destination, -ListOfFlights)
find_flights_least_stops(O, D, L):-
    findall(
        F,
        find_flights(O, D, F),
        L
    ).