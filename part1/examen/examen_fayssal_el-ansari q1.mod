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
float productionQouta[P] = [450, 500, 600];

// decision variables
dvar int+ producedUnits[P];

// objective function
maximize sum(p in P) (producedUnits[p] * (sellingPrice[p] - productionCost[p]));
// constraints
subject to {
  
  forall (p in P) { 
  	// should meet at least the minimum demand for each product
  	producedUnits[p] >= minimumDemands[p];
  	
  	// shouldn't surpass the maximum demand for each product
  	producedUnits[p] <= maximumDemands[p];
 }  
 
 	// should respect the quota (for month => * 22)
 	sum (p in P) (producedUnits[p]/productionQouta[p]) <= nbActiveDays;
 
}

///// ANALYSE ////
// Q1:

 