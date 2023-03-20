/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 20 Mar 2023 at 15:07:53
 *********************************************/
int size = ...;
range S = 1..size;

dvar int+ board[S][S][S];

// we will have redundunt information on each k level 
// but we can read the solution on one level only since 
// it's going to be the same
subject to {
  // the chosen number should be between 1 and size
  forall(i in S) {
    forall(j in S) {
      forall(k in S) {
        board[i][j][k] >= 1;
    	board[i][j][k] <= size; 
      }
    }
  }
  
  // for the same line there should be no same number
  forall (i in S) {
    forall(j in S) {
      forall(k in S){
        forall(l in S: l > i) {
        	board[i][j][k] != board[l][j][k];
      }
      }
    }
  }
  
  // for the same column there should be no same number
  forall (j in S) {
    forall(i in S) {
      forall(k in S) {
	        forall(l in S: l > j) {
	        board[i][j][k] != board[i][l][k];
	     } 
      }
    }
  }
	
  // all cells with the same i and j but different k have the same value
//  forall(i in S, j in S) {
//    forall(k in S: k>1) {
//      board[i][j][k] == board[i][j][k-1];
//    }
//  }
  
  
  // predefined values for all chains (all levels)
  forall (k in S) {
      board[2][3][k] == 4;
	  board[3][2][k] == 3;
	  board[3][3][k] == 2;
	  board[3][4][k] == 1;
	  board[4][3][k] == 3; 
  }
  
  // chain constraints: all cells on the same k level should have a different value
  forall(i in S) {
    forall(j in S) {
      forall(k in S) {
        forall(l in S: l > k) {
          board[i][j][k] != board[i][j][l];
        }
      }
    }
  }
  
}