/*
 * Aldo Serrano Rugerio
 * ID: 165241
 * Missionaries and Cannibals
 * Objective: Solve the puzzle missionaries and cannibals using prolog
 * finding a way to represent the movements and the states of the puzzle.
*/

% Definition of the conditions that we need to check in every movement
% in order to follow the rules of the game and solve the puzzle

% Movement from left to right
boat_movement(move(M, C, left), state(ML, CL, right),
    state(ML2, CL2, left)):-
    ML2 is ML + M, ML2 >= 0, ML2 =< 3,
    CL2 is CL + C, CL2 >= 0, CL2 =< 3.

% Movement from right to left
boat_movement(move(M, C, right), state(ML, CL, left),
    state(ML2, CL2, right)):-
    ML2 is ML - M, ML2 >= 0, ML2 =< 3, 
    CL2 is CL - C, CL2 >= 0, CL2 =< 3.	 


% Definition of the possible movements that the algorithm can follow in order
% to solve the puzzle
possible_movement(1,1,_).
possible_movement(2,0,_).
possible_movement(0,2,_).
possible_movement(1,0,_).
possible_movement(0,1,_).

% Definition of the invalid states that we can have on the puzzle, that means
% that the user could not solve the puzzle
invalid_state(state(2,3, _)).
invalid_state(state(1,3, _)).
invalid_state(state(1,2, _)).
invalid_state(state(2,1, _)). 
invalid_state(state(1,0, _)).
invalid_state(state(2,0, _)).
   
% Definition of the funcition that makes the iterations to find the solution
% following the rules of the puzzle, that have been defined before
path(Ini, Ini, _, []).
path(Ini, Fin, Visited, [move(M, C, Dir)|Path]):-
    possible_movement(M, C, Dir),
    boat_movement(move(M, C, Dir), Ini, Aux),
    \+ invalid_state(Aux),
    \+ member(Aux, Visited),
    path(Aux, Fin, [Aux|Visited], Path).	 
	 
% Function to print the movements, in order to show them on the console
print_moves([]).
print_moves([move(M, C, Dir)|Rest]):-
    format('Move ~d missionaries and ~d cannibals to the ~w side.~n', [M, C, Dir]),
    print_moves(Rest).

% Entry point to solve the puzzle and print the movements
solve_and_print_moves(InitialState, FinalState):-
    path(InitialState, FinalState, [], Moves),
    length(Moves,11),
    print_moves(Moves).   
