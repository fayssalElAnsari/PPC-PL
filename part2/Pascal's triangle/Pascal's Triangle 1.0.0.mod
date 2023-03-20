/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 20 Mar 2023 at 09:50:31
 *********************************************/
int height = 5;
range H = 1..height;

int usable[H][H];

execute {
  for(var i in H) {
    for(var j in H) {
      usable[i][j] = 1;
    }
  }
  
  for(var i in H) {
    for(var j in H) {
      if(j>i) {
         usable[i][j] = 0; 
      }
    }
  }
}

dvar int+ board[H][H];
dvar int+ X;
dvar int+ Y;
dvar int+ Z;

subject to {
   // the sum of the previous two cells is equal to the next cell 
   forall(i in 1..4) {
		forall (j in 1..4: usable[i][j] != 0) {
		  board[i][j] == board[i+1][j+1] + board[i+1][j];
		}
 	}
 	
// 	forall(i in H){
// 	  forall(j in H: usable[i][j] == 0) {
// 	    board[i][j] == 0;
// 	  }
// 	}
 	
 	// predefined choices (values)
 	board[1][1] == 151;
 	board[1][3] == 40;
 	board[5][2] == 11;
 	board[5][4] == 4;
 	
 	board[5][1] == X;
 	board[5][3] == Y;
 	board[5][5] == Z;
 	
 	Y == X + Z;
}

