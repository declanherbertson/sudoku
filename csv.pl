:- use_module(library(csv)).

row_to_list(row(A,B,C,D,E,F,G,H,I,_), [A,B,C,D,E,F,G,H,I]).

rows_to_matrix([], []).
rows_to_matrix([Row|T], [List|T1]) :- row_to_list(Row, List), rows_to_matrix(T, T1).

replace_zeros_row([], []).
replace_zeros_row([0|T], [_|T1]) :- replace_zeros_row(T, T1).
replace_zeros_row([L|T], [L|T1]) :- not(L is 0), replace_zeros_row(T, T1).

replace_zeros([], []).
replace_zeros([Row|T], [NewRow|T1]) :- replace_zeros_row(Row, NewRow), replace_zeros(T, T1).

csv_to_matrix(Filename, Matrix) :- csv_read_file(Filename, Rows), rows_to_matrix(Rows, OMatrix), replace_zeros(OMatrix, Matrix).

matrix_to_csv(Filename, Matrix) :- rows_to_matrix(Rows, Matrix), csv_write_file(Filename, Rows).