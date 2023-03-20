/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 27 Feb 2023 at 14:03:46
 *********************************************/
 // inputs
int nbProducts = 3;
range P = 1..nbProducts;

int nbActiveDays = 22;

int minimumDemands[P] = [1000, 2000, 1500];
int maximumDemands[P] = [4500, 6000, 5500];
float sellingPrice[P] = [130, 105, 95];
float productionCost[P] = [90.5, 71, 68.5];
float productionQuta[P] = [450, 500, 600];
// q2: outsourcing //
float outsourcingCost[P] = [120.5, 110, 79];

// decision variables
dvar int+ producedUnits[P];
dvar int+ outsourcedUnits[P];

// objective function
maximize sum(p in P) (producedUnits[p] * (sellingPrice[p] - productionCost[p]) + (outsourcedUnits[p] * ( sellingPrice[p] - outsourcingCost[p])) );
// constraints
// outsourcing the production means that we will keep respecting 
// the given upper and lower demand limits 
subject to {
  
  forall (p in P) { 
  	// should meet at least the minimum demand for each product
  	producedUnits[p] + outsourcedUnits[p] >= minimumDemands[p];
  	
  	// shouldn't surpass the maximum demand for each product
  	producedUnits[p] + outsourcedUnits[p] <= maximumDemands[p];
 }  
 
 	// should respect the quota (for month => * 22)
 	sum (p in P) (producedUnits[p]/productionQuta[p]) <= nbActiveDays;
 
}

///// ANALYSE ////
// Q1:

// Q2:

 