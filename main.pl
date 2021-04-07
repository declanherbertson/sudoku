:- [sudoku].
:- [csv].

solve_file(Filename) :- csv_to_matrix(Filename, Matrix), sudoku(Matrix), matrix_to_csv('out.csv', Matrix).