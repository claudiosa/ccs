%%%% CABO DE GUERRA
int:  n = 8;  %% total de pessoas

%%% quantidade de pessoas e seu peso
array[1..n] of int : peso;
peso = [ 77, 97, 120, 45, 57, 96, 100, 59 ];

%% Quantas pessoas em cada lado
var int: NA;
var int: NB;

%% Variavel de decisao BINARIA
array[1..n] of var 0..1 : V_DEC;
var int: PESO_TOTAL;
var int: PA;
var int: PB;

%%% Ilustrando uma funcao em MINIZINC
function var int: metade( int: n) = n div 2 ;

%% quantos em cada lado
constraint
   NA == metade(n)   /\ %% and
   NB == (n - NA); %% LOGO:  NB >= NA 

constraint %% B ... selecionados
  NB == sum( i in 1..n ) ( V_DEC[i] );

constraint
  PESO_TOTAL = sum([peso[i] | i in 1..n]) ;

constraint
  PB = sum([V_DEC[i]*peso[i] | i in 1..n]);

constraint
  PA == (PESO_TOTAL - PB);

% minimizar a diferenca entre os PESOS -- F_OBJETIVO
solve minimize abs(PA - PB);

output [
  " Peso Total: ", show(PESO_TOTAL), "\t PA : ", show( PA ),
  "\t PB : ", show( PB ),
  "\n Vetor de pesos: ", show(peso),
  "\n V_BIN_TIMES B/1 A/0: ", show(V_DEC )] ++	
  ["\n TIME A: ",
   show([peso[i] | i in 1..n where fix(V_DEC[i]) == 0 ])
  ]  ++	 ["\n TIME B: ",
   show([V_DEC[i]*peso[i] | i in 1..n where fix(V_DEC[i]) == 1 ])
  ];