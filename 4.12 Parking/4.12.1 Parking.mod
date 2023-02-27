/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 26 Feb 2023 at 17:51:34
 *********************************************/
int nbCars = 15;
range C = 1..nbCars;

float carLengths[C] = [4, 4.5, 5, 4.1, 2.4, 5.2, 3.7, 3.5, 3.2, 4.5, 2.3, 3.3, 3.8, 4.6, 3];

// decision variables
// if a car is in a certain street
dvar int+ street1[C];
dvar int+ street2[C];

float lengths[i in 1..2];

execute {
  for (var i in 2){
    lengths[i] = sum(c in C) (street1[c] * carLengths[c]); 
  }
}

// objective function
// according to the exercise we need to minimize the length of occupied street
// meaning the bigger length of occupied distance in both streets 
// => max or calc diff of occupied lengths
minimize (max(i in 1..2) lengths[i]);

subject to {
  forall (c in C) {
    street1[c] + street2[c] <= 1;
  }
}
