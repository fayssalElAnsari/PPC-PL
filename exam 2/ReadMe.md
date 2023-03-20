## Providing Service To Neighborhoods Problem
* we represent our neighborhoods in a 2d `hasHouse` variable.
* we will start by looking for a 100% coverate of all neighberhoods.

solution:
```
// solution (optimal) with objective 16
// Quality Incumbent solution:
// MILP objective                                 1.6000000000e+01
// MILP solution norm |x| (Total, Max)            1.60000e+01  1.00000e+00
// MILP solution error (Ax=b) (Total, Max)        0.00000e+00  0.00000e+00
// MILP x bound error (Total, Max)                0.00000e+00  0.00000e+00
// MILP x integrality error (Total, Max)          0.00000e+00  0.00000e+00
// MILP slack bound error (Total, Max)            0.00000e+00  0.00000e+00
// 

map = [[0
             0 0 0 0 0 1 0 0 0]
             [0 0 0 0 0 0 1 0 0 0]
             [0 0 1 1 0 0 0 0 0 0]
             [0 0 1 0 0 1 0 1 0 0]
             [0 1 1 0 0 0 0 1 0 0]
             [0 0 0 0 0 1 0 0 0 0]
             [0 0 0 0 1 1 0 1 1 0]
             [0 0 0 1 0 0 0 0 0 0]
             [0 0 0 0 0 0 0 0 0 0]
             [0 0 0 0 0 0 0 0 0 0]];

```

we have 16 towers.

* to get only 70% coverage we'll need to count the number of towers in the map and multiply by 70%.
* we introduce a coverage decision variable that we'll be mapped to the neighbors map.
* when a tower is 1 cell away from a neighberhood the coverage array == 1;
* we want the percentage of covered neighberhoods to be 70%.