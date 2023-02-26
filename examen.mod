/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 25 Feb 2023 at 22:04:01
 *********************************************/
 // inputs
int nbTours = 3;
range T = 1..nbTours;

int nbPieces = 4;
range P = 1..nbPieces;

int availableTime[T] = [80, 30, 130];
int fabricationTime[T][P] = [[3, 3, 2, 5],
							[4, 1, 1, 2],
							[2, 2, 3, 1]];
int demand[P] = [10, 40, 50, 20];

// decision variables is for how much time
//		 we're using each machine to produce which piece
dvar int+ usingTime[T][P];

// the objective function is to MINIMIZE for how much time
//		 we're using each machine to produce which piece
minimize sum(t in T, p in P) (usingTime[t][p]);

subject to {
  // the time of using each machine shouldn't surpass that of the available time
  // so we loop through all the machine 
  // and for each machine we calculate the sum of
  //	 	how much time is spent on producing each piece kind
  forall (t in T) {
    sum (p in P) (usingTime[t][p]) <= availableTime[t];
  }
  
  // need to at least make the demanded number for each piece
  // so we loop on all pieces and for each piece kind
  //		the total amout made by all the towers should be 
  //		atleast that of the demand amount
  forall (p in P) {
    sum (t in T) (usingTime[t][p]/fabricationTime[t][p]) >= demand[p];
  }
}
