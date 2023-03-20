/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 20 Mar 2023 at 15:07:53
 *********************************************/
int size = ...;
range S = 1..size;

dvar int+ board[S][S];

subject to {
  // the chosen number should be between 1 and 9
  forall(i in S) {
    forall(j in S) {
    	board[i][j] >= 1;
    	board[i][j] <= 9;
    }
  }
  
  // for the same column there should be no same number
  forall(i in S){
    forall(j in S){
      forall(k in S: k > i){
        board[i][j] != board[k][j];
      }
    }
  }
  
  // for the same row there should be no same number
  forall(j in S) {
    forall(i in S) {
      forall(k in S: k > j) {
        board[i][j] != board[i][k];
      }
    }
  }
  
  // wikipedia example predefined values
  board[1][1] == 5;
  board[2][1] == 3;
  board[5][1] == 7;
  
  board[1][2] == 6;
  board[4][2] == 1;
  board[5][2] == 9;
  board[6][2] == 5;
  
  board[2][3] == 9;
  board[3][3] == 8;
  board[8][3] == 6;
  
  board[1][4] == 8;
  board[5][4] == 6;
  board[9][4] == 3;
  
  board[1][5] == 4;
  board[4][5] == 8;
  board[6][5] == 3;
  board[9][5] == 1;
  
  board[1][6] == 7;
  board[5][6] == 2;
  board[9][6] == 6;
  
  board[2][7] == 6;
  board[7][7] == 2;
  board[8][7] == 8;
  
  board[4][8] == 4;
  board[5][8] == 1;
  board[6][8] == 9;
  board[9][8] == 5;
  
  board[5][9] == 8;
  board[7][9] == 7;
  board[9][9] == 9;
}