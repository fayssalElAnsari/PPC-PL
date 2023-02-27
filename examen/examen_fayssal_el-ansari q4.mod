/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 27 Feb 2023 at 14:03:46
 *********************************************/
 /////// inputs //////
int nbProducts = ...;
range P = 1..nbProducts;

int nbActiveDays = ...;

int minimumDemands[P] = ...;
int maximumDemands[P] = ...;
float sellingPrice[P] = ...;
float productionCost[P] = ...;
float productionQuta[P] = ...;
// q2: outsourcing //
float outsourcingCost[P] = ...;
/* EXTRA DAYS */
int maximumExtraDays = ...; // Per month
float extraDayCost = ...; // Per day
// questions was changed now it's easier and profitable

////// Decision variables ///////
dvar int+ producedUnits[P];
dvar int+ outsourcedUnits[P];
dvar int+ extraDays;

////// objective function 	//////
maximize sum(p in P) (producedUnits[p] * (sellingPrice[p] - productionCost[p]) + (outsourcedUnits[p] * ( sellingPrice[p] - outsourcingCost[p])) - extraDays * extraDayCost );

////// constraints 			//////
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
 	sum (p in P) (producedUnits[p]/productionQuta[p]) <= nbActiveDays + extraDays;
 
 	// the maximum number of extra days added shouldn't surpass the given max
 	extraDays <= maximumExtraDays;
}


 