%%% A - star: f = g + h
%%% IMPLEMENT BREADTH FIRST ALGORITHM + the Best choice + Heuristic
%%% Problem: find the best path or A^*
%%% swipl -q -t main -f xxx.pl 
%%%


%%% the MAP or graph is this file and evaluation function
:-['a_graph_with_weight.pl']. %%% look the map given

 
%%% MY contribution and corrections    
main :-  best_sol.
    %%%     findall(X, best_sol(X), L),
    %%%     imp_lst(L).            


/** see the file with the map */    
/*
start_vertex(va).    
% a -> g 
end_vertex(vg).
*/

start_vertex(va).    
% a -> g 
end_vertex(vh).


best_sol :-
        start_vertex(Start),
        end_vertex(End),
        format("\n start_vertex: ~w\t end_vertex: ~w  \n", [ Start , End ]),
        %%%  NODE  OPEN CLOSE, SOL
        search_a_star( [[ Start ]], End,  Solution),
        %%% LIST OF LIST ... many possible paths will be explored
        
        writeln('THE SOLUTION' : Solution),
        writeln(one_solution_is  :Solution),
        g(Solution, Cost),
        writeln('Lower_bound in this A*' :Cost),
        format("\n ============================= \n").

%%% KERNEL of SEARCH
 search_a_star([ [End | Path] | _ ] , End, Path_Reversed ):-
        %end_point(End),
        reverse([End|Path], Path_Reversed),
        format("\n ... FOUND A SOLUTION (halt clause) ... \n"), 
        !. 

%%% CURR_NODE --- a sequence of nodes ... by level
%%% [ CURR_NODE  | L_CLOSED ] = [ [ path1 ],[ path2 ],[ ],[ ],[path-n ]]

search_a_star( [ CURR_PATH  | L_PATHS ], End,  SOL ) :-
    
    expand_current_path(  CURR_PATH , Expanded_PATH ),
    %%% A queue here appended ... LISTS of LISTS ... many paths   
    append( L_PATHS, Expanded_PATH, ALL_PATHS ),
    ordering_path(ALL_PATHS, End, PATHS_classified),
    search_a_star(  PATHS_classified , End,  SOL ).

%%% SORT by F heuristic ... f = g + h
%%% this predicate will redo in the future
ordering_path([],_,[]).
ordering_path( Lista, End ,[Menor_caminho | Lista_classificada]):-
  min_path(Lista, End , Menor_caminho, Novo_caminho),
  ordering_path(Novo_caminho, End , Lista_classificada).


%%% this predicate will redo in the future
min_path([Caminho1|Lista], Objetivo, Caminho2, [Caminho1|Novo_caminho]):-
  min_path(Lista, Objetivo, Caminho2, Novo_caminho),
  f(Caminho1,Objetivo,F1),
  f(Caminho2,Objetivo,F2),
  F2<F1,
  !.
  
  min_path([Rota|Lista], _ , Rota, Lista).



%% NEIGHBOURG NEW
% format("\n CURR_NODE_L: ~w\t OPEN_NEW: \t ~w CLOSED: ~w \n", [ CURR_NODE , L_OPEN_NEW, L_CLOSED ]),
% format("\n LISTS_of_LISTS_OPEN_NEW: ~w ", [ L_OPEN_NEW ]),
  
 %%% a list of list with all possible paths in this transversal tree by level


expand_current_path( [ Curr_Node | L_CLOSE ], L_Expanded) :-
  findall(
       [New_Node, Curr_Node | L_CLOSE ],
     ( 
       %%% conection or next movement or node
       edge(Curr_Node, New_Node, _ ),
       not( member(  New_Node , [ Curr_Node | L_CLOSE ] ) )
      ),
      L_Expanded
    )
%    , 
%    %%%% ultima linha do findall 
%     format("\n [Xc,Yc]: [~w,~w]", [X0,Y0]),
%     format("==> Expanded :: ~w", [L_Expanded ] )
     , 
    
     !. 
     
%%% expande e adiciona TODOS NAO VISITADOS AINDA
expand_current_path(_,[]):- !.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% end of KERNEL 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imp_lst([]).
imp_lst([Cabeca|Cauda]):- 
         format("\n A SOLUTION is:\n ~w", [Cabeca]), 
         imp_lst(Cauda).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
