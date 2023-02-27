/*********************************************
 * OPL 22.1.0.0 Model
 * Author: samij
 * Creation Date: 13 févr. 2023 at 14:15:54
 *********************************************/
 tuple Produit {
    int vente;
    int activation;
    float cout;
    int quotas;
    int batch;
    float cout_stock;
    int Janvier;
    int Fevrier;
    int Mars;
    int Avril;
}


int m=4; /*Mois*/
range M = 1..m;


{Produit} Data = ...;


dvar int+ Vendu[M][Data];
dvar int+ Produits[M][Data];

dvar int+ storage[M][Data];

dexpr int y_J=sum(i in Data) i.activation*(Produits[1][i]!=0);
dexpr int y_F=sum(i in Data) i.activation*(Produits[2][i]!=0);
dexpr int y_M=sum(i in Data) i.activation*(Produits[3][i]!=0);
dexpr int y_A=sum(i in Data) i.activation*(Produits[4][i]!=0);

dexpr float s_JF=sum(i in Data) i.cout_stock*storage[1][i];
dexpr float s_FM=sum(i in Data) i.cout_stock*storage[2][i];
dexpr float s_MA=sum(i in Data) i.cout_stock*storage[3][i];


maximize sum(i in Data) (Vendu[1][i]+Vendu[2][i]+Vendu[3][i]+Vendu[4][i])*(i.vente - i.cout)-(y_J+y_F+y_M+y_A)-(s_JF+s_FM+s_MA);

subject to {
  sum(i in Data) Produits[1][i]/ i.quotas <= 23;
  sum(i in Data) Produits[2][i]/ i.quotas <= 20;
  sum(i in Data) Produits[3][i]/ i.quotas <= 23;
  sum(i in Data) Produits[4][i]/ i.quotas <= 22;
  
  forall(i in Data) Vendu[1][i] <= i.Janvier;
  forall(i in Data) Vendu[2][i] <= i.Fevrier;
  forall(i in Data) Vendu[3][i] <= i.Mars;
  forall(i in Data) Vendu[4][i] <= i.Avril;
  
  sum(i in Data) storage[1][i] <= 800;
  sum(i in Data) storage[2][i] <= 800;
  sum(i in Data) storage[3][i] <= 800;
  
  forall(i in Data) (Produits[1][i] == Vendu[1][i] +storage[1][i]);
  forall(i in Data) (Produits[2][i] + storage[1][i] == Vendu[2][i] +storage[2][i]);
  forall(i in Data) (Produits[3][i] + storage[2][i] == Vendu[3][i] +storage[3][i]);
  forall(i in Data) (Produits[4][i] + storage[3][i] == Vendu[4][i]);
  
  }





