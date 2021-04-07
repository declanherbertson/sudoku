:- use_module(library(clpfd)).

p1([[1,_,_,8,_,4,_,_,_],
    [_,2,_,_,_,_,4,5,6],
    [_,_,3,2,_,5,_,_,_],
    [_,_,_,4,_,_,8,_,5],
    [7,8,9,_,5,_,_,_,_],
    [_,_,_,_,_,6,2,_,3],
    [8,_,1,_,_,_,7,_,_],
    [_,_,_,1,2,3,_,8,_],
    [2,_,5,_,_,_,_,_,9]]).

p2([[8,2,7,1,5,4,3,9,6],
    [9,6,5,3,2,7,1,4,8],
    [3,4,1,6,8,9,7,5,2],
    [5,9,3,4,6,8,2,7,1],
    [4,7,2,5,1,3,6,8,9],
    [6,1,8,9,7,2,4,3,5],
    [7,8,6,2,3,5,9,1,4],
    [1,5,4,7,9,6,8,2,3],
    [2,3,9,8,4,1,5,6,7]]).

% This work attempted to recreate the library functions in clpfd to show strong understanding of prolog
% The board validation works correctly, but can only confirm if a solution is correct, not generate the correct solution from a partial board
% This is because a special domain function (INS) is needed to prevent the possible board combinations to take up exponential space and all validation functions must be configured to interact with it.
all_unique([]).
all_unique([H|T]) :- not(member(H,T)), all_unique(T).

valid_rows([]).
valid_rows([R|T]) :- all_unique(R), valid_rows(T).

valid_sections([[], [], []]).
valid_sections([]).
valid_sections([[E1, E2, E3 | T1], [E4, E5, E6 | T2], [E7, E8, E9 | T3] | T]) :- 
  all_unique([E1, E2, E3, E4, E5, E6, E7, E8, E9]),
  valid_sections([T1, T2, T3]),
  valid_sections(T).

valid_board(M) :- 
    valid_rows(M),
    valid_sections(M),
    transpose(M, MT),
    valid_rows(MT).

% Start of Source: https://www.metalevel.at/sudoku/sudoku.pl

sudoku(Rows) :-
        length(Rows, 9), maplist(same_length(Rows), Rows),
        append(Rows, Vs), Vs ins 1..9,
        maplist(all_distinct, Rows),
        transpose(Rows, Columns), maplist(all_distinct, Columns),
        Rows = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],
        blocks(As, Bs, Cs), blocks(Ds, Es, Fs), blocks(Gs, Hs, Is).

blocks([], [], []).
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
        blocks(Ns1, Ns2, Ns3).

% End of Source: https://www.metalevel.at/sudoku/sudoku.pl