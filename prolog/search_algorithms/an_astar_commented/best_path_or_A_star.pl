%%% A - star: f = g + h
%%% IMPLEMENT BREADTH FIRST ALGORITHM + the Best choice + Heuristic
%%% Problem: find the best path or A^*
%%% swipl -q -t main -f xxx.pl 
%%%


%%% the MAP or graph is this file and evaluation function
:-['a_graph_with_weight.pl']. %%% look the map given

 
%%% MY contribution and corrections    
main :-  best_sol.


/** see the file with the map */    
/*
main :-    findall(X, best_sol(X), L),
            imp_lst(L).            

Va -> Vg 

% Graph #2
start_vertex(va).    
end_vertex(vg).
*/

% Graph #1
start_vertex(vs).    
end_vertex(vg).


best_sol :-
        start_vertex(Start),
        end_vertex(End),
        format("\n start_vertex: ~w\t end_vertex: ~w  \n", [ Start , End ]),
        %%%  NODE CLOSE is in the path because it is start node
        search_a_star( [[ Start ]], End,  Solution),
        %%% LIST OF LIST ... many possible paths will be explored identical a BFS
        
        writeln('THE SOLUTION ' : Solution),
        %writeln(one_solution_is  :Solution),
        g(Solution, G_Cost),
        h(Solution, End, H_Cost),
        %writeln('The lower_bound in this A*' :Cost),
        format("\n G value: ~w\t H heuristic: ~w  \n", [ G_Cost , H_Cost ]),
        format("\n ============================= \n").



%%% KERNEL of SEARCH
 search_a_star([ [ End | Path ] | _ ] , End, Path_Reversed ):-
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
    %%%% ordering_path(ALL_PATHS, End, PATHS_classified),
    %%%% OR 
    sort_path(ALL_PATHS, End, PATHS_classified),
    search_a_star(  PATHS_classified , End,  SOL ).

%%% SORT by F heuristic ... f = g + h

%%%%%%%%%%%%%%%%%%%%%% ORIGINAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% this predicate will redo in the future -- TODO
ordering_path([],_,[]).
ordering_path( L_PATHS, End ,[Shortest_Path | L_Paths_Sorted]):-
  %%% allways getting the shortest path and remove it
  min_path(L_PATHS, End , Shortest_Path, Others_Paths),
  
  ordering_path(Others_Paths, End , L_Paths_Sorted).


%%% this predicate will redo in the future  -- TODO
min_path([Path_1|L_PATHS], END_NODE, Path_2, [Path_1|Others_Paths]):-
  min_path( L_PATHS , END_NODE, Path_2, Others_Paths),
  f(Path_1, END_NODE, F1),
  f(Path_2, END_NODE, F2),
  F2<F1,
  !.
  
  min_path([Path |L_PATHS], _ , Path, L_PATHS).

%%%%%%%%%%%%%%%%%%%%%% CHANGED by  these LINES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% the End is goind due f evaluation
sort_path([],_,[]).
sort_path( L_PATHS, End , [Shortest_Path | L_Paths_Sorted]):-
    get_lowest_path(L_PATHS, End, Shortest_Path),
    delete( L_PATHS, Shortest_Path, Others_Paths),
    sort_path( Others_Paths, End , L_Paths_Sorted).

get_lowest_path([ Unique ], _ ,  Shortest) :- Shortest = Unique, !.
get_lowest_path([Path_1, Path_2 |L_PATHS], END_NODE,  Shortest) :- 
    f(Path_1, END_NODE, F1),
    f(Path_2, END_NODE, F2),
    F1<F2,
    get_lowest_path([Path_1 |L_PATHS], END_NODE, Shortest), !.
 
get_lowest_path([Path_1, Path_2 |L_PATHS], END_NODE,  Shortest) :- 
    f(Path_1, END_NODE, F1),
    f(Path_2, END_NODE, F2),
    F1>=F2,
    get_lowest_path([Path_2 |L_PATHS], END_NODE, Shortest), !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%% NEIGHBOURG NEW
% format("\n CURR_NODE_L: ~w\t OPEN_NEW: \t ~w CLOSED: ~w \n", [ CURR_NODE , L_OPEN_NEW, L_CLOSED ]),
% format("\n LISTS_of_LISTS_OPEN_NEW: ~w ", [ L_OPEN_NEW ]),
  
 %%% a list of list with all possible paths in this transversal tree by level


expand_current_path( [ Curr_Node | L_CLOSE ], L_Expanded) :-
  findall(
       [New_Node, Curr_Node | L_CLOSE ],
     ( 
       %%% Conection or next movement or node, state etc
       getedge(Curr_Node, New_Node, _ ), /* TAKE CARE HERE */
       not( member(  New_Node , [ Curr_Node | L_CLOSE ] ) )
      ),
      L_Expanded
    )

%    %%%% 
%     format("\n [Xc,Yc]: [~w,~w]", [X0,Y0]),
%     format("==> Expanded :: ~w", [L_Expanded ] )
%    %%%% 
     ,  !. 
     
%%% expande e adiciona TODOS NAO VISITADOS AINDA
expand_current_path(_,[]):- !.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% end of KERNEL OF A*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imp_lst([]).
imp_lst([Cabeca|Cauda]):- 
         format("\n A SOLUTION is:\n ~w", [Cabeca]), 
         imp_lst(Cauda).

/*
set_Sols(Tests),
    eval(Tests),

[[60,110,vg,vh,va],[160,200,vp,vh,va],[120,151.62,vi,vh,va],[40,130.55,vb,va],[90,121.62,vi,va],[150,280,vc,va]]    
*/

%%% if corrections
set_Sols([[vg,vh,va],[vp,vh,va],[vi,vh,va],[vb,va],[vi,va],[vc,va]]).

eval([]).
eval([A|L]) :-
    reverse(A, Sol),
    last(Sol,End),
    g(Sol, G_Cost),
    h(Sol, End, H_Cost),
    format("\n G value: ~w\t H heuristic: ~w  : ~w  \n", [ G_Cost , H_Cost, A ]),
    eval(L).


