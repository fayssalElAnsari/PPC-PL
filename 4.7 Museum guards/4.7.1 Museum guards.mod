/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 26 Feb 2023 at 13:27:02
 *********************************************/
int nbRooms = 10;
range R = 1..nbRooms;
// 1:A; 2:B, 3:C, 4:D, 5:E, 6:F, 7:G, 8:H, 9:I, 10:J;

//String rooms[R] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"];

int nbDoors = 11;;
range D = 1..nbDoors;

range RoomsPerDoor = 1..2;// could be 4d world XD

int doorsCoord[D][RoomsPerDoor] = [[1, 2], [1, 3], [1, 7], [1, 6], [2, 8], [3, 4],
					[4, 5], [4, 6], [7, 9], [8, 9], [9, 10]];
					
// boolean list of room to room to check if door exists before constraint
int doorsGraph[r1 in R, r2 in R] = 0;

execute {
  for (var i in D){
    doorsGraph[doorsCoord[i][1]][doorsCoord[i][2]] = 1;
   doorsGraph[doorsCoord[i][2]][doorsCoord[i][1]] = 1;  
  }
  writeln(doorsGraph);
}	

// decision variables
dvar int+ guardsGraph[r1 in R, r2 in R];			
					
// objective function
minimize sum(r1 in R, r2 in R) ((guardsGraph[r1][r2])) / 2;

subject to {
  // a door should exist between two rooms before adding a guard
  forall(r1 in R, r2 in R) {
    guardsGraph[r1][r2] <= doorsGraph[r1][r2];
  }
  
  // there should be at least one guard in a room
  // we need to sum all the guards in a room
  forall(r1 in R, r2 in R) {
    sum(r1 in R) guardsGraph[r1, r2] >= 1;
    sum(r2 in R) guardsGraph[r1, r2] >= 1;// symmetry condition
  }
  
  // symmetry condition
//  forall(r1 in R, r2 in R) {
//    guardsGraph[r1][r2] == guardsGraph[r2][r1];
//  }

}

execute {
  var totalGuards = 0;
  for (var i in R){
    for (var j in R) {
      totalGuards += guardsGraph[i][j];
    }
  }
  writeln("the total nb of guards is ", totalGuards/2);
}