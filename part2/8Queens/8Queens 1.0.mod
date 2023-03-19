/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 12 Mar 2023 at 14:11:27
 *********************************************/
 
// input
int n =8;
range N = 1..n;

// decision variables
// where to put the queens in the board
// while keeping track of the number of acheived solutions
dvar int+ queens[N][N] in 0..1;
dvar int+ nbQueens;

maximize nbQueens;

// constraints
subject to {
  	// the total number of queens on the board is the maximum possible
  	sum (j in N, i in N) queens[i][j] == nbQueens;
   
	// only one queen in each line
	forall (j in N){
	  sum(i in N) queens[i][j] == 1;
	}	
	
	// only one queen in each column
	forall (i in N){
	  sum(j in N) queens[i][j] == 1;
	}
	
	// only one queen in each diagonal
   	// Diag desc
	forall(col in N) sum(i in (col..n)) queens[i][i-col+1] <= 1;
       
	// Diag asc
	forall(col in N) sum(i in col..n) queens[i][col+n-i] <= 1;
}
using CP;

main {
	thisOplModel.generate();
	cp.startNewSearch();
	var n=0;
	while (cp.next()) {
		n=n+1;
		write("Solution:", n," -> [ ")
		var i,j;
		for(var i in thisOplModel.N) {
		  	for(var j in thisOplModel.N) {
		        if(thisOplModel.queens[i][j]==1) {
		        	write(j," "); 
		        }
			}          
		}  
	}
	writeln("]");
	write(n);
}