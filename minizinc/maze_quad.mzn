int: x_MAX = 6;
int: y_MAX = 6;
int: meio = 3;

array[0..x_MAX, 0..y_MAX] of var  0..1: X;

var set of int : set_LINHAS = 1 .. (x_MAX-1); %%% valid index
var set of int : set_COLUNAS = 1 .. (y_MAX-1); %%% valid

constraint
     X[meio , 0] == 1
       /\
     X[meio , y_MAX] == 1
        /\
     X[x_MAX , meio] == 1
       /\
     X[0, meio] == 1
     ;


constraint 
     sum(j in 0.. y_MAX) ( X[0,j] ) == 1
      ;
constraint 
     (sum(j in 0.. y_MAX) (X[x_MAX,j]) == 1 )
     ;
constraint 
     (sum(i in 0.. x_MAX) (X[i,0]) == 1 )
     ;
constraint 
     (sum(i in 0.. x_MAX) (X[i,y_MAX]) == 1 )
     ;

/*
constraint 
      exists(j in 1 .. (y_MAX-1))(
       sum(i in 1.. (x_MAX-1)) (X[i,j]) <= 2) ;

constraint 
     exists(i in 1 .. (x_MAX-1))(
       sum(j in 1.. (y_MAX-1)) (X[i,j]) <= 2) ;
 */      
constraint        
  forall (i in 1..(x_MAX-1), j in 1..(y_MAX-1) )
    ( 
     (X[i,j] == 1) <-> ((i+j) mod 2 == 0)
     %(X[i,j] == 1) <-> ( (X[i-1 , j+1] == 1) /\ (X[i+1 , j-1] == 1) ) 
     % Diagonal para direita
     % \/
     %(X[i,j] == 1)  <-> ( (X[i-1 , j-1] == 1) /\ (X[i+1 , j+1] == 1) ) 
    % Diagonal para esquerda
    );

%constraint 
%     (sum(i in 0..(x_MAX), j in 0..(y_MAX-1)) (X[0,j]) <= 14)
%     ;       
     
solve satisfy;
output [  show(X[i,j]) ++
        if j == y_MAX then "\n" else " " endif |
        i in 0..x_MAX, j in 0..y_MAX];
%show2d(X) ++        