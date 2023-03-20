/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 20 Mar 2023 at 14:04:52
 *********************************************/
using CP;

int n = 4;
range N = 1..n;    

dvar int+ queens[N][N];

dexpr int nb_queens = sum(i in N)(sum (j in N) queens[i][j]);

subject to {
  forall (i in N) {
    sum (j in N) (queens[i][j])<=1;
    sum (j in N) (queens[j][i])<=1;
  }
  forall(i in N) {
    forall(j in N) {
      queens[i][j]<=1;
    }
  }
  forall (k in 1-n..n-1){
      sum(i in N) ( sum(j in N) ((queens[i][j])*(i-j==k)))<=1;
  }
  forall (k in 1..2*n){
      sum(i in N) ( sum(j in N) ((queens[i][j])*(i+j==k)))<=1;
  }
  nb_queens==n;
}

main {
    thisOplModel.generate();
    cp.startNewSearch();
    var a=0;
    while (cp.next()) {
        a=a+1;
        write("Solution:", a," -> [ ")
        var i,j;
        for(var i in thisOplModel.N) {
              for(var j in thisOplModel.N) {
                if(thisOplModel.queens[i][j]==1) {write(j," ");}          
                }  
            }
        writeln("]");
    }
}