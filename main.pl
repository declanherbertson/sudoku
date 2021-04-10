:- [sudoku].
:- [csv].


solve_file(Filename,OutFile) :- csv_to_matrix(Filename, Matrix), sudoku(Matrix), matrix_to_csv(OutFile, Matrix).

solve_sudoku:-
	write('Enter input file name'),
	nl,
	read(Input),
	write('Enter output file name'),
	nl,
	read(Output),
	solve_file(Input,Output).
