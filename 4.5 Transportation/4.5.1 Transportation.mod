/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 26 Feb 2023 at 17:21:42
 *********************************************/
// inputs
 int nbStores = 6;
 range S = 1..nbStores;
 
 int nbPorts = 5;
 range P = 1..nbPorts;
 
 int stores[S] = [10, 12, 20, 24, 18, 40];
 int ports[P] = [20, 15, 25, 33, 21];
 
 int travelingDistance[S][P] = [
								  [290, 115, 355, 715, 810],
								  [380, 340, 165, 380, 610],
								  [505, 530, 285, 220, 450],
								  [655, 450, 155, 240, 315],
								  [1010, 840, 550, 305, 95],
								  [1072, 1097, 747, 372, 333]
								];
 
 int pricePerKm = 30; // euros
 int nbContainersPerTrip = 2;
 
 // decision variables
 // we need to define how many containers were sent from which store to which port
 dvar int+ transportedContainers[S][P];
 
 // Objective Function
 // we need to minimize the total cost of transportation
 minimize sum(s in S, p in P) ( (transportedContainers[s][p]/nbContainersPerTrip) * travelingDistance[s][p] * pricePerKm );
 
 subject to {
   // the number of transported containers from stores 
   //	should be less than that available in stores
   // explaination:
   //	for each s (s is fixed), calculate the sum of all p 
   //	and compare it to the number of available empty containers
   forall(s in S) {
     sum(p in P) ( transportedContainers[s][p]) <= stores[s]; 
   }
   
   // should meet the demand at the end...
 	forall(p in P) {
 	  sum(s in S) ( transportedContainers[s][p]) >= ports[p];
 	}
 }
 