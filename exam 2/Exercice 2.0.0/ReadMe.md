## Classic Sudoku
* we will use a simple 2d array to represent our data.
* for the predefined values we'll add a constraint for each value.
* we have three main constraints:
    * only one occurence of a number for all the cells in the same line.
    * only one occurence of a number for all the cells in the same column.
    * only possible values are numbers between 1 and 9.

solution:
```
// solution (optimal) with objective 0
// Quality Incumbent solution:
// MILP objective                                 0.0000000000e+00
// MILP solution norm |x| (Total, Max)            4.05000e+02  9.00000e+00
// MILP solution error (Ax=b) (Total, Max)        0.00000e+00  0.00000e+00
// MILP x bound error (Total, Max)                0.00000e+00  0.00000e+00
// MILP x integrality error (Total, Max)          0.00000e+00  0.00000e+00
// MILP slack bound error (Total, Max)            0.00000e+00  0.00000e+00
// MILP indicator slack bound error (Total, Max)  0.00000e+00  0.00000e+00
// 

board = [[5
             6 1 8 4 7 9 3 2]
             [3 8 9 4 7 5 6 2 1]
             [1 7 8 9 2 4 3 6 5]
             [6 1 7 2 8 9 5 4 3]
             [7 9 3 6 5 2 4 1 8]
             [4 5 2 7 3 8 1 9 6]
             [9 4 5 1 6 3 2 8 7]
             [2 3 6 5 9 1 8 7 4]
             [8 2 4 3 1 6 7 5 9]];

```

## Chain Sudoku
We now have a 5 by 5 example and less predefined values.
We will introduce a constraint for each chain.
Cells on the same chain cannot have the same value. We have 5 chains, 
the same number as the size of our board.
we will make our grid three dimensional, the third dimension z will represent 
the cells that are on the same leverl (or on the same chain).
the cells the same i, j but the same k have the same value.

Solution
```
// solution (optimal) with objective 0
// Quality Incumbent solution:
// MILP objective                                 0.0000000000e+00
// MILP solution norm |x| (Total, Max)            7.50000e+01  5.00000e+00
// MILP solution error (Ax=b) (Total, Max)        0.00000e+00  0.00000e+00
// MILP x bound error (Total, Max)                0.00000e+00  0.00000e+00
// MILP x integrality error (Total, Max)          0.00000e+00  0.00000e+00
// MILP slack bound error (Total, Max)            0.00000e+00  0.00000e+00
// MILP indicator slack bound error (Total, Max)  0.00000e+00  0.00000e+00
// 

board = [[2
             5 1 4 3]
             [3 1 4 2 5]
             [5 3 2 1 4]
             [1 4 3 5 2]
             [4 2 5 3 1]];
```
