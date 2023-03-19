/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 18 Mar 2023 at 06:22:10
 *********************************************/
// in this first example we'll be using a 4x4 grid
int n = 4;
range N = 1..n;

dvar int+ board[N][N];

// constraints
subject to {
  	// choice constraint
	forall(i in N, j in N){
	  board[i][j] <= n;
	  board[i][j] >= 1;
	}
	
	// predefined choices
	board[3][2] == 1;
	board[4][1] == 2;
	
	// comparisons
	board[1][2] <= board[1][3];
	board[2][2] <= board[1][2];
	board[2][2] <= board[2][3];
		
	// choice number is present only one time for each column
	forall(j in N) {
	   	forall(i in N) {
	   	  forall(k in N: k > i) {
	   	    board[i][j] != board[k][j]; 
	   	  }
	   }
	}
	
	// choice number is present only one time for each row
	forall(i in N) {
	   	forall(j in N) {
	   	  forall(k in N: k > j) {
	   	    board[i][j] != board[i][k]; 
	   	  }
	   	}
	}
  	
}