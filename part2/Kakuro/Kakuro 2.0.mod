/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 20 Mar 2023 at 08:18:44
 *********************************************/
int size = 3;
range N = 1..size;
int usable[N][N];

dvar int+ board[N][N];

execute {
  for(var i in N){
    for (var j in N){
      usable[i][j] = 1;
    }
  }
  
  usable[1][1] = 0;
  usable[3][3] = 0;
}

subject to {
  // different values for cells on the same column
  forall(i in N){
    forall(j in N: usable[i][j] != 0){
      forall(k in N: k > j){
         board[i][j] != board[i][k]; 
      }
    }
  }
  
  // different values for cells on the same line
  forall(j in N){
    forall(i in N: usable[i][j] != 0){
      forall(k in N: k > i){
         board[i][j] != board[k][j]; 
      }
    }
  }
  
  // upper and lower limits
  forall(i in N){
    forall(j in N: usable[i][j] != 0){
      board[i][j] >= 1;
      board[i][j] <= 9;
    }
  }
  
  // sums
  // 1. lines
  board[2][1] + board[3][1] == 10;
  board[1][2] + board[2][2] + board[3][2] == 11;
  board[1][3] + board[2][3] == 7;
  
  // 2. columns
  board[1][2] + board[1][3] == 5;
  board[2][1] + board[2][2] + board[2][3] == 6;
  board[3][1] + board[3][2] == 17;
  
}