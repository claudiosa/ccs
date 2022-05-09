
%%%% CABO DE GUERRA
int: n; %% total de pessoas

%% Quantos em cada lado
var int: NA;
var int: NB;

%%% quantidade de pessoas e seu peso : ARQ EXTERNO
%n = 4; 
%peso = [ 77, 9, 100, 15 ];

array[1..n] of int : peso;

%% var de decisao BINARIA
array[1..n] of var 0..1 : x_decision;

var int: PESO_TOTAL;
var int: PA;
var int: PB;

%%% ilustrando uma funcao em MINIZINC
function var int: metade( int: n) = n div 2 ;

%% quantos em cada lado
constraint
   NA = metade(n)
   /\
   NB = (n - NA);

constraint
   PESO_TOTAL = sum( i in 1..n ) (peso[i]);

constraint
  NB = sum( i in 1..n ) ( x_decision[i] );

constraint
  PB = sum( i in 1..n ) ( x_decision[i]*peso[i] );

constraint
  PA = (PESO_TOTAL - PB);

% minimizar a diferenca entre os PESOS
solve minimize abs(PA-PB);

output [
  " Peso Total: " ++ show(PESO_TOTAL) ++ 
  "\tVetor de pesos: " ++ show(peso) ++"\n"++
  " PA : NA: " ++ show( PA )++" : "++show( NA )++"\n"++
  " PB : NB: " ++ show( PB )++" : "++show( NB )++"\n"++
  " TIME B: " ++ show( x_decision ) ++ "\n" 
  ]   ++	
  [" TIME A: " ++
   show([peso[i] | i in 1..n where fix(x_decision[i]) == 0 ])
  ]  ++	
  ["\n TIME B: " ++
   show([x_decision[i]*peso[i] | i in 1..n where fix(x_decision[i]) == 1 ])
  ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%