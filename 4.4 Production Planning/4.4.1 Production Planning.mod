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

int nbProductiveDays[M] = [23, 20, 23, 22];

// decision variables
 dvar int+ unitsProduced[P][M];
 dvar boolean activationStatus[P][M];
 
 // objective function
 // should maximize the total profit
 maximize sum(p in P, m in M) (unitsProduced[p][m] * (unitPrice[p] - productionCosts[p]) - activationCosts[p]*activationStatus[p][m]);
 
 subject to {
   // should reach the demand for each piece per month EXACTLY
   forall(p in P, m in M) {
     unitsProduced[p][m] == demand[p][m]*activationStatus[p][m];
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
   
   
 }
