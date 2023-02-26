/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 25 Feb 2023 at 16:21:32
 *********************************************/

int n = 3; // the number of products
range N = 1..n; // the range from the nb products to be used later

// decision variables
dvar int+ productQuantity[N];// How much to produce for each product
dvar boolean activated[N];// True of product i is activated, False if not

int maximumDemand[N] = [5300, 4500, 5400];
float sellingPrice[N] = [124, 109, 115];
float productionCost[N] = [73.3, 52.9, 65.4];
int productionQuota[N] = [500, 450, 550];
float activationCost[N] = [170000, 150000, 100000];
float minimumBatch[N] = [20, 20, 16];

// the Objective Function
maximize sum(i in N) (productQuantity[i]*(sellingPrice[i] - productionCost[i])-activationCost[i]*activated[i]);

subject to {
  forall (i in N) {
   productQuantity[i] <= maximumDemand[i]*activated[i]; 
   productQuantity[i] <= 22*productionQuota[i];
   productQuantity[i] >= minimumBatch[i]*activated[i];
  };
  sum(i in N) (productQuantity[i] / productionQuota[i]) <= 22;
  
}




 