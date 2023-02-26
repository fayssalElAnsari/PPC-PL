/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 25 Feb 2023 at 16:21:32
 *********************************************/

int n = 3; // the number of products
range N = 1..n; // the range from the nb products to be used later

// decision variables
dvar int+ productQuantity[N];// How much to produce for each product

int maximumDemand[N] = [5300, 4500, 5400];
float sellingPrice[N] = [124, 109, 115];
float productionCost[N] = [73.3, 52.9, 65.4];
int productionQuota[N] = [500, 450, 550];

// the Objective Function
maximize sum(i in N) (productQuantity[i]*(sellingPrice[i] - productionCost[i]));

subject to {
  forall (i in N) {
   productQuantity[i] <= maximumDemand[i]; 
  };
  sum(i in N) (productQuantity[i] / productionQuota[i]) <= 22;
}




 