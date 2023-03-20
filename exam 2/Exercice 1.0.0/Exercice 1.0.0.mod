/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 20 Mar 2023 at 14:10:43
 *********************************************/
int size = ...;
range S = 1..size;
int hasHouse[S][S] = ...;
int nbHouses;
execute {
  for (var i in S){
    for(var j in S){
      if (hasHouse[i][j] == 1){
        nbHouses++;
      }
    }
  }
}
						
// this map represents where we will put our signal towers
dvar int+ map[S][S];
dvar int+ covered[S][S] in 0..1; // this represents the neighborhoods that have signal coverage

// we want to put as less towers as possible
dexpr int x = sum(i in S, j in S) map[i][j];
minimize x;

// how to know if a house has signal?
// * it should be just 1 cell away from the tower
// so the condition is for 70% of all house there 
// should be a tower only one cell away
// we'll try to solve with 100% first
// there should be no signal tower one cell away from 
subject to { 
	// in a 9 cell block there should be only one cell tower at all times
	// and if there is no house no tower should be present
	forall(i in 2..size-1) {
	  forall(j in 2..size-1: hasHouse[i][j] != 0) {
	    sum(k in -1..1) map[i+k][j+k] == 1;
	  }
	}
	
//	x <= 0.7 * nbHouses;
	
}