%% by CCS em 17/05/16
include "alldifferent.mzn";
/*
    S E N D +
    M O S T
----------------
  M O N E Y
*/
%%% VARIAVEIS .... e dominios de 0 a 9
var 0..9 : S;  var 0..9 : E;  var 0..9 : N;  var 0..9 : D;
var 0..9 : M;  var 0..9 : O;  var 0..9 : T;  var 0..9 : Y;

var int : Line_1;  var int : Line_2;   var int : Line_3;
%% Funcao  objetivo maximizar a palavra MOST
var int : F_MOST;

constraint 
      alldifferent([S, E, N, D, M, O, T, Y]);

/*
    S E N D   :  L1
    M O S T   :  L2 
----------------
  M O N E Y   :  L3
*/
constraint     %%% original formulation
     S > 0 /\
     M > 0;

constraint 
    Line_1 == S*1000 + E*100 + N*10 +D;  %% 1a linha

constraint 
    Line_2 == M*1000 + O*100 + S*10 +T;  %% 2a linha

constraint 
    Line_3 == M*10000 + O*1000 + N*100 + E*10 + Y;  %% 3a linha

constraint 
    Line_1 + Line_2 == Line_3;


constraint 
%%% maximizar o valor   "M O S T"
%  F_MOST = M*1000 + O*100 + S*10 + T; //OR
  F_MOST = M + O + S + T;
  
%solve satisfy;
solve maximize F_MOST;

output [
    "\tS: " ++ show(S) ++
    "\tE: " ++ show(E) ++
    "\tN: " ++ show(N) ++
    "\tD: " ++ show(D) ++        

    "\n\tM: " ++ show(M) ++
    "\tO: " ++ show(O) ++
    "\tS: " ++ show(S) ++
    "\tT: " ++ show(T) ++
    "\n-----------------------------------------"++    
    "\nM: " ++ show(M) ++
    "\tO: " ++ show(O) ++
    "\tN: " ++ show(N) ++
    "\tE: " ++ show(E) ++
    "\tY: " ++ show(Y) ++
    "\n\n => SOMA do MOST: " ++ show(F_MOST) ++
    "\nLine_1: "++show(Line_1)++"\tLine_2: "++show(Line_2) ++
    "\tLine_3: " ++show(Line_3)
    ];

/*
    S E N D
    M O S T
----------------
  M O N E Y
*/
