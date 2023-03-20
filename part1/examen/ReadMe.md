# Fayssal EL ANSARI 
# M1 INFORMATIQUE

## Analyse du problem: Production of outsourced Products with extra days

### Reponse au questions:
#### Q1: Formulate an OPL model to determine the production plan to maximize the total income. 
* to create our model we need to define the given data (inputs), the decision variables, the objective function and  finally the constraints.
* **data**: In our model we only have the notion of a factory able to produce 3 different products, each 100kg of product have a monthly minimum demand, monthly maximum demand, selling price per 100kg, production ocst per 100kg, and a 100kg production quota per **day**. To represent our data we can either use lists or a list of tuples.
* **decision variables**: The variable that the solver will be calculating and what is being answered by our model is many 100kg per product is being produced (in our model we refer to 100kg of product by 1 unit).
* **objective function**: What will let our model decide the decicison variable is this function, according to the exercice we want to **maximize** the profit (per month).
* **contraints**: For now there are only 3 constraints, we should at least meet the minimum demand, we shouldnt surpass the maximum demand and we should respect the quota, we can think the quota as the total energy that could be consumed per day and the given data defines the amount of total amount of energy that will be consumed if the production line was dedicated to only one product.'

**RESULTS**
```
// solution (optimal) with objective 379000
// Quality Incumbent solution:
// MILP objective                                 3.7900000000e+05
// MILP solution norm |x| (Total, Max)            1.07500e+04  4.75000e+03
// MILP solution error (Ax=b) (Total, Max)        0.00000e+00  0.00000e+00
// MILP x bound error (Total, Max)                0.00000e+00  0.00000e+00
// MILP x integrality error (Total, Max)          0.00000e+00  0.00000e+00
// MILP slack bound error (Total, Max)            0.00000e+00  0.00000e+00
// 

producedUnits = [4500
         4750 1500];
```

#### Q2: Change the mathematical program and the OPL model to cater for outsourcing some of the production. The outsourced costs (per 100Kg of product)
    * We need to add new data that is the cost of outsourcing for each product.
    * We need to define a new decision variable, which is the amount of outsourced units for each product p.
    * What will affect our model given that the outsourced units production price surpass that of the local poroduction, is the quota since we have a local quota that needs to be respected, but not for the outsourced products.
    * There is no ambiguity on either or not the maximum/minimum demands constraints are affected by the outsourced products, since if there was no limit we could outsource +inf products, which is not possible.
**RESULTS**
```
// solution (optimal) with objective 469750
// Quality Incumbent solution:
// MILP objective                                 4.6975000000e+05
// MILP solution norm |x| (Total, Max)            1.60000e+04  6.00000e+03
// MILP solution error (Ax=b) (Total, Max)        0.00000e+00  0.00000e+00
// MILP x bound error (Total, Max)                0.00000e+00  0.00000e+00
// MILP x integrality error (Total, Max)          0.00000e+00  0.00000e+00
// MILP slack bound error (Total, Max)            0.00000e+00  0.00000e+00
// 

producedUnits = [4500
         6000 0];   
outsourcedUnits = [0 0 5500];
extraDays = 0;
```
**NOTES**
* We notice that there are no extra days added

#### Q4.1: What if the maximum demands of A2 is 6500 ?
**RESULTS**
```
// solution (optimal) with objective 473250
// Quality Incumbent solution:
// MILP objective                                 4.7325000000e+05
// MILP solution norm |x| (Total, Max)            1.65000e+04  6.50000e+03
// MILP solution error (Ax=b) (Total, Max)        0.00000e+00  0.00000e+00
// MILP x bound error (Total, Max)                0.00000e+00  0.00000e+00
// MILP x integrality error (Total, Max)          0.00000e+00  0.00000e+00
// MILP slack bound error (Total, Max)            0.00000e+00  0.00000e+00
// 

producedUnits = [4050
         6500 0];
outsourcedUnits = [450 0 5500];
extraDays = 0;
```
**RESULTS**
* adding extra days is not profitable.

#### Q4.2: What if the cost per extra day is 6000 ?
**RESULTS**
```
// solution (optimal) with objective 473250
// Quality Incumbent solution:
// MILP objective                                 4.7325000000e+05
// MILP solution norm |x| (Total, Max)            1.65000e+04  6.50000e+03
// MILP solution error (Ax=b) (Total, Max)        0.00000e+00  0.00000e+00
// MILP x bound error (Total, Max)                0.00000e+00  0.00000e+00
// MILP x integrality error (Total, Max)          0.00000e+00  0.00000e+00
// MILP slack bound error (Total, Max)            0.00000e+00  0.00000e+00
// 

producedUnits = [4050
         6500 0];
outsourcedUnits = [450 0 5500];
extraDays = 0;
```
**NOTES**
* adding extra days is **still** not profitable

* our program uses different solving algorithms and techniques to check if there exists a solution to our problem