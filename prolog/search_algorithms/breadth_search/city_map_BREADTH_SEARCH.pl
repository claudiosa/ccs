/* 

swipl -q -t main -f graph_map_BREADTH_FS
BUSCA EM LARGURA - PROBLEMA DO MAPA
*/
/******************************************
 * Rrepresentação de um MAPA/GRAFO QUALQUER     *
 *****************************************/
/* MODELAGEM do Problema ===> parte mais dificil */
a(casa, hospital). 
a(casa, clube).
a(hospital, parque).
a(hospital, farmacia ).
a(farmacia, udesc).
a(teatro, farmacia ).
a(fabrica, clube).
a(fabrica, teatro).

/*
                  casa
            /             \
         hospital          clube
         /    \                \
   parque   farmacia          fabrica   
             /  \                  \
        udesc  teatro             teatro  

*/

/* para não ter que reescrever que:
  a(fabrica, teatro) \== a(teatro,fabrica). 
*/

conexao(X,Y) :- a(X,Y).
conexao(X,Y) :- a(Y,X).

/* Nós iniciais e finais do problema */
no_origem(casa).
no_destino(parque).
/*************************************************************/
a_solution(Sol_invertida) :-  
 %   statistics(cputime,T1),
    no_origem(No_inicial),
    search_BREADTH([[No_inicial]], Solucao), /* lista de lista */
    /* Nó inicial: entra na lista inicial */
    reverse(Solucao, Sol_invertida).
  
/*  
    DEVIDO AO BACKTRACKING REMOVER ISTO
    length(Sol_invertida, Total),
   	no_destino(FIM), nl,
   	format('\n CAMINHO PERCORRIDO: ~w ', [Sol_invertida]),
	format('\n NÓ de origem do mapa era: : ~w ', [No_inicial]),
    format('\n NÓ de destino do mapa era: ~w', [FIM]),
    format('\n Total de estados: ~d', Total), 
    Aux is (Total -1),
    format('\n Total de movimentos: ~w', Aux), 
    statistics(cputime ,T2),
    Temp is T2 - T1, 
    format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
    format('\n Tempo total: ~10f  msec', Temp).
*/	

a_solution(' NAO HAH MAIS SOLUCOES\n\n'):- !.
       /* para terminar com yes */    
/*********************************************************/
all_sol:- findall(X, a_solution(X), L), 
                 write('\n RESUMO DAS SOLUCOES :'),
                 w_L(L).
/*************************************************************/
%% condição de parada.... o nó corrente é o desejado
search_BREADTH(  [ [No_corrente|Caminho] |_] , [No_corrente | Caminho ] ):-
          no_destino(No_final),
          member(No_final, [No_corrente|Caminho]). 
          %% termina a busca...

/* parte recursiva geral  => DETALHE: LISTA DE LISTA */
search_BREADTH([Nodo|Caminho],Solucao):-
         expanding_NODE(Nodo, Expansao_do_NODO ),
         /* na primeira vez Caminho = [] */
         append(Caminho, Expansao_do_NODO, Novos_caminhos),
         /* observar que o append está ao contrário....  fazendo
         que no próximo passo Nodo, seja um proximo deste nível */
         search_BREADTH(Novos_caminhos , Solucao).

expanding_NODE([Nodo|Caminho], Novos_caminhos) :-
         findall([Novo_nodo, Nodo|Caminho],
         (conexao(Nodo, Novo_nodo),
          not(member(Novo_nodo,[Nodo|Caminho]))),
          Novos_caminhos), !. 
          /* ultima linha do findall */

%%% expande e adiciona TODOS NAO VISITADOS AINDA

expanding_NODE(_,[]):- !.

/******************************************************/
w_L([]).
w_L([A|Cauda]):- format('\n ==> ~w ', [A]), 
                 w_L(Cauda).
/******************************************************/
/*
SAIDA:
?- inicio(X).


 CAMINHO PERCORRIDO: [casa, hospital, parque] 
 Nó de origem do mapa era: : casa 
 Nó de destino do mapa era: parque
 Total de estados: 3
 Total de movimentos: 2
 T1: 0.090000 	 T2: 0.090000  msec
 Tempo total: 0.0000000000  msec
X = [casa, hospital, parque] .

?- todas_solucoes.


 CAMINHO PERCORRIDO: [casa, hospital, parque] 
 Nó de origem do mapa era: : casa 
 Nó de destino do mapa era: parque
 Total de estados: 3
 Total de movimentos: 2
 T1: 0.090000 	 T2: 0.090000  msec
 Tempo total: 0.0000000000  msec

 CAMINHO PERCORRIDO: [casa, clube, fabrica, teatro, farmacia, hospital, parque] 
 Nó de origem do mapa era: : casa 
 Nó de destino do mapa era: parque
 Total de estados: 7
 Total de movimentos: 6
 T1: 0.090000 	 T2: 0.090000  msec
 Tempo total: 0.0000000000  msec
 RESUMO DAS SOLUCOES :
 ==> [casa, hospital, parque] 
 ==> [casa, clube, fabrica, teatro, farmacia, hospital, parque] 
 ==> Nao hah mais solucoes 
true.

?- 
*/
