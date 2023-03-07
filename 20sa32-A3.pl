% Name: Shakib Absar
% Student No: 20245608
% 
% PART 1
% 
% 1. The variables in this problem are the cells on the board, such as Cell_11, Cell_12,...,Cell_44
% 2. The range of values in this problem are {1, 2, 3, 4}. Each cell can be assigned a value from this set.
% 3. The constraints on this problem are - 
% 		i. Each row cannot have the same value twice
% 		ii. Each column cannot have the same value twice
% 		iiii. Each quadrant cannot have the same value twice
%
% PART 2

domain([1,2,3,4]).

valid([]).
valid([H|T]):- domain(D), member(H,D), valid(T).

check_unique([_]).
check_unique([H|T]):- not(member(H,T)),check_unique(T).

sudoku_valid([R1,R2,R3,R4]) :- valid(R1),
    						valid(R2),
    						valid(R3),
    						valid(R4).

sudoku_rows([R1,R2,R3,R4]) :- check_unique(R1),
    						check_unique(R2),
    						check_unique(R3),
    						check_unique(R4).

sudoku_columns([[],[],[],[]]).
sudoku_columns([[H1|T1],[H2|T2],[H3|T3],[H4|T4]]) :- check_unique([H1,H2,H3,H4]), 
    												sudoku_columns([T1,T2,T3,T4]).
    				
sudoku_quadrants([[Cell_11, Cell_21, Cell_31, Cell_41],
 					[Cell_12, Cell_22, Cell_32, Cell_42],
 					[Cell_13, Cell_23, Cell_33, Cell_43],
 					[Cell_14, Cell_24, Cell_34, Cell_44]]) :-
    				check_unique([Cell_11, Cell_21, Cell_12, Cell_22]),
    				check_unique([Cell_31, Cell_41, Cell_32, Cell_42]),
    				check_unique([Cell_13, Cell_23, Cell_14, Cell_24]),
    				check_unique([Cell_33, Cell_43, Cell_34, Cell_44]).

sudoku(B) :- sudoku_valid(B), sudoku_quadrants(B), sudoku_rows(B), sudoku_columns(B).
  

/*
[[Cell_11, Cell_21, Cell_31, Cell_41],
 [Cell_12, Cell_22, Cell_32, Cell_42],
 [Cell_13, Cell_23, Cell_33, Cell_43],
 [Cell_14, Cell_24, Cell_34, Cell_44]]
*/
    							
/*
[[Cell_11, 4, 3, 2],
[3, Cell_22, Cell_32, Cell_42],
[4, 1, Cell_33, Cell_43],
[Cell_14, Cell_24, 4, 1]]
*/

assignment_sudoku([[_, 4, 3, 2],
        			[3, _, _, _],
        			[4, 1, _, _],
        			[_, _, 4, 1]]).

assignment_solution(B):- assignment_sudoku(B), sudoku(B).

% Run the following query for the assignment solution
% assignment_solution(B)

% For a more CSP like query
% sudoku([[Cell_11, 4, 3, 2],[3, Cell_22, Cell_32, Cell_42],[4, 1, Cell_33, Cell_43],[Cell_14, Cell_24, 4, 1]])

% To run this on any other other 4X4 sudoku board, edit the following board
sample_sudoku([	[_, _, _, _],
        		[_, _, _, _],
        		[_, _, _, _],
        		[_, _, _, _]]).
% And then run this query
% sample_sudoku(B), sudoku(B)

% Shortcoming of this solution - Brute forces through all the possible solution to find the right solution
