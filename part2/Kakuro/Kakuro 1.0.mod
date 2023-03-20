/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 19 Mar 2023 at 23:58:06
 *********************************************/
 
 //
 
int nums = 9;
int nbRows = 6;
int nbCols = 6;

range R = 1..nbRows;
range C = 1..nbCols;

dvar int+ board[C][R];
int usable[C][R];

execute{
  for(var i in C){
	for(var j in R){
	  usable[i][j] = 1;
	}    
  }
  
  usable[3][1] = 0;
  usable[4][1] = 0;
  usable[3][2] = 0;
  usable[4][2] = 0;
  
  usable[1][3] = 0;
  usable[1][4] = 0;
  
  usable[6][3] = 0;
  usable[6][4] = 0;
  
  usable[3][5] = 0;
  usable[4][5] = 0;
  usable[3][6] = 0;
  usable[4][6] = 0;
  
}

subject to {
  // all rows have different values
  forall (i in C) {
    forall (j in R: usable[i][j] != 0) {
      forall (k in R: k > j){
        board[i][j] != board[i][k];
      } 
    }
  }
  
  // all columns have different values
  forall (j in R) {
    forall (i in C: usable[i][j] != 0) {
      forall (k in C: k > i) {
         board[i][j] != board[k][j]; 
      }
    }
  }
  
  // range of possible values
  // with usability
  forall (i in C) {
    forall (j in R : usable[i][j] != 0) {
      board[i][j] >= 1;
      board[i][j] <= nums;
    }
  } 
  
  // sum constraints
	board[1][1] + board[1][2] == 3;
	board[2][1] + board[2][2] + board[2][3] + board[2][4] + board[2][5] + board[2][6] == 22;
	board[1][1] + board[2][1] == 5;
	board[1][2] + board[2][2] == 8;
	
//	board[3][1] + board[3][2] + board[3][3] + board[3][4] + board[3][5] + board[3][6] == 22;
//	board[4][1] + board[4][2] == 3;
//	board[3][1] + board[4][1] == 3;
//	board[3][2] + board[4][2] == 6;
//
//	board[1][3] + board[2][3] + board[3][3] + board[4][3] == 13;
//	board[1][4] + board[2][4] + board[3][4] + board[4][4] == 11;
//	board[2][3] + board[2][4] == 11;
//	board[3][3] + board[3][4] == 3;
//	
//	board[1][5] + board[2][5] == 4;
//	board[1][6] + board[2][6] == 6;
//	board[1][5] + board[1][6] == 4;
//	
//	board[3][5] + board[4][5] == 6;
//	board[4][5] + board[4][6] == 4;
//	board[3][6] + board[4][6] == 10; 
  
}