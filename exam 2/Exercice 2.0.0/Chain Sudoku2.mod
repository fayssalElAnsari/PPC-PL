/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 20 Mar 2023 at 15:07:53
 *********************************************/
int size = ...;
range S = 1..size;

// we will represent our chains in a 2d array: chain[chainNb][element]

int chain[S][S];

dvar int+ board[S][S];

subject to {
  // the chosen number should be between 1 and size
  forall(i in S) {
    forall(j in S) {
        board[i][j] >= 1;
    	board[i][j] <= size; 
    }
  }
  
  // for the same line there should be no same number
  forall (i in S) {
    forall(j in S) {
      forall(k in S: k > i){
        	board[i][j] != board[k][j];
      }
    }
  }
  
  // for the same column there should be no same number
  forall (j in S) {
    forall(i in S) {
        forall(k in S: k > j) {
        board[i][j] != board[i][k];
      }
    }
  }
  
  // predefined values for all chains (all levels)
  board[2][3] == 4;
  board[3][2] == 3;
  board[3][3] == 2;
  board[3][4] == 1;
  board[4][3] == 3;
  
  // chains
//  allDifferent([board[1][2], board[1][1], board[2][1], board[3][2], board[2][3]]);
  
}