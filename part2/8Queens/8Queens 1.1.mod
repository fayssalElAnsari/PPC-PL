/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 12 Mar 2023 at 14:11:27
 *********************************************/
//using CP;

int num_solutions = 1000; // set solution pool capacity to a large number
range S = 1..num_solutions;
 
execute {
    var mdl = new IloModel();
    var cplex = new IloCplex();
    cplex.setParam(IloCplex.Param.MIP.Strategy.File, 2);
}


// input
int n =8;
range N = 1..n;

int nbQueens = 8;

// decision variables
// where to put the queens in the board
// while keeping track of the number of acheived solutions
dvar int+ queens[N][N] in 0..1;

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

execute {
    var mdl = new IloModel(); // create a new IloModel object
    var cplex = new IloCplex(); // create a new IloCplex object
    cplex.setParam(IloCplex.Param.MIP.Strategy.File, 2); // set a CPLEX parameter
    var sp = cplex.populateSolutionPool(num_solutions, "all"); // populate the solution pool
}

main {
    var status = cplex.getStatus();
    var solution_count = 0;
    while (status == IloCplex.Status.Feasible) {
        solution_count++;
        writeln("Solution ", solution_count, ":");
        writeln(cplex.getValues(S));
        cplex.solution().addMIPStart(cplex.getValues(S)); // add the solution to the MIP start pool
        status = cplex.populateSolutionPool(); // find the next feasible solution
    }
    writeln("Total number of solutions: ", solution_count);
}


