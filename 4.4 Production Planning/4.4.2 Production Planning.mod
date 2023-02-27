/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 25 Feb 2023 at 23:15:01
 *********************************************/
 // inputs
int nbProducts = 3;
range P = 1..nbProducts;

int nbMonths = 4;
range M = 1..nbMonths;

int demand[P][M] = [[5300, 1200, 7400, 5300],
					[4500, 5400, 6500, 7200],
					[4400, 6700, 12500, 13200]];
					
float unitPrice[P] = [124, 109, 115];
float productionCosts[P] = [73.3, 52.9, 65.4];
int productionQuotas[P] = [500, 450, 550];
float activationCosts[P] = [150000, 150000, 100000];
int minimumBatches[P] = [20, 20, 16];

/* storage */
// the idea behind adding storage space to maximize profits 
//		is that there is an activation cost per product per month
//		if we produce the maximum possible of a product then put it in storage we would have
//		more profits? or is it that we're adding a new limit on how much we can produce in total?
// 		- we will add the cost of storage which will lower the profits
//		- the number of stored units is the number of produced units in this month + 
//			the number of already stored units - the number of sold units in a month
//		- should we add the notion of sold units?
//		there is a fixed price of selling a product per month so no effect here
// so how to define storage in our model?
// it will affect other predefined variables
float storageCost[P] = [3.5, 4, 3];
int totalStorageVolume = 800;

int nbProductiveDays[M] = [23, 20, 23, 22];

// decision variables
 dvar int+ unitsProduced[P][M];
 dvar boolean activationStatus[P][M];
 dvar int+ nbStoredUnits[P][M];
 dvar int+ nbSoldUnits[P][M];
 
 // objective function
 // should maximize the total profit
 maximize sum(p in P, m in M) (nbSoldUnits[p][m] * (unitPrice[p] - productionCosts[p]) 
 - activationCosts[p] * activationStatus[p][m] - nbStoredUnits[p][m] * storageCost[p]);
 
 subject to {
   // should reach the demand for each piece per month EXACTLY
   forall(p in P, m in M) {
     unitsProduced[p][m] >= demand[p][m]*activationStatus[p][m];
   } 
   
   // should at least make the minimum batch for each product (in all months)
   // 		therefore we calculate the sum produced for all months of each product
   //		and then we compare it to the minimum batch
   //		because the min batch depends on the product only
   //		therefore we loop on products and we calculate the sum on months for each step
   forall (p in P){
     sum (m in M) (unitsProduced[p][m]) >= minimumBatches[p];
   }
   
   // should respect the quota of production
   // the quota is for each product if for one day only
   // the production quota applies to all products at once
   // the sum of the the quantity produced / production quota 
   //		of all products should be 1 (for one day)
   forall (m in M) {
     sum (p in P) (unitsProduced[p][m]/productionQuotas[p]) <= nbProductiveDays[m];
   }
   
   /* storage */
   // at all times (each month) the total amount of stored product units
   //		shouldn't surpass the limit of available storage space
	sum (p in P, m in M) (nbStoredUnits[p][m]) <= totalStorageVolume;

   
   // in the last month there should be 0 stored units to max profit (logically)
   // 		this condition should be implicit, no need to write it
   
   // we cannot sell more than we we have in store
   forall (m in M, p in P){
		nbSoldUnits[p][m] <= nbStoredUnits[p][m];
   }
   
   // we cannot store more than we have produced
   forall (m in M, p in P) {
     nbStoredUnits[p][m] <= unitsProduced[p][m];
   }
   
   // do we sell units at the beginning or end of month?
   //	- at the end of each month we will sell units (we can't sell at the beginning of month1)
   // nbStoredUnits[p][m] = nbProducedUnits[p][m] + nbStoredUnits[p][m-1] - nbSoldUnits[p][m]
   // how to define the notion of m-1 without explicitly writing m-1?
   forall (m in M: m < nbMonths, p in P) {
      nbStoredUnits[p][m+1] == nbStoredUnits[p][m] + unitsProduced[p][m+1] - nbSoldUnits[p][m+1];
   }
   
   // to make sure we don't waste produced units we need to have a condition
   // the sum of all produced units on all months for each product == soldUnits
   forall (p in P) {
     sum (m in M) (unitsProduced[p][m]) == sum (m in M) (nbSoldUnits[p][m]);
   }
   
   
   
 }
