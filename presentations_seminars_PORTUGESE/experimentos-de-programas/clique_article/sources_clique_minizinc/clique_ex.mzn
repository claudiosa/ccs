include "../lib/graphs.mzn";
%% mzn-g12fd -a clique_ex.mzn --data data_clique_60.dzn > results-all-60.txt 



int: N;
array[1..N, 1..N] of int: adj_mat;
var set of 1..N: clique_vertexes;
%%array[ 1..N ] of 1..N : clique_vertexes;
var 1..N: clique_size;

constraint 
     clique_vertexes = clique(adj_mat, clique_size);

%%% specifying cliques size ... for debbuging
constraint 
     clique_size >= 20; %% 30 for 450 and 20 for 60

solve satisfy;
%solve maximize clique_size;

output["Clique size:" ++ show(clique_size) ++ "\n" ++ show(clique_vertexes)];
/*

n=30
Clique ( 15 ): 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29
Clique size:15
{2,4,6,8,10,12,14,16,18,20,22,24,26,28,30}
*/
