
#  A small program illustrating breadth first  search , with example data for a
%"ferry route" puzzle and the Jugs puzzle from the text. Can trivially be
%modified for depth first search.

% search(+StartNode, ?EndNode, ?Soln).
% Finds path (Soln) between StartNode and EndNode 
% e.g., ?- search([4,0], [2,_], Soln).

search(Start, End, Soln) :-
  agenda_search([[Start]], End, Soln).

% agenda_search(+StartAgenda, ?Target, ?Soln).
% Given an agenda of paths, it will find  a Soln which is a path which 
% extends one of the paths on the agenda, and whose first node is a valid 
% Target state.

agenda_search([[State|Rest]|_], Target, [State|Rest]) :- 
	reached_target(State, Target).

agenda_search([Path|Paths], End, Soln) :-
   extend(Path, ExtendedPaths),
   append(Paths, ExtendedPaths, NewPaths),
   agenda_search(NewPaths, End, Soln).

% extend(+Path,?ExtendedPaths)
% Extended paths will be set of all paths one node (NewNode) longer than 
% Path, such that there is a link from the first node in Path to the new node,
% and no loops in the path.

extend([Node|RestPath], ExtendedPaths) :-
   bagof([NewNode,Node|RestPath],
         (successor(Node, NewNode), 
          \+ member(NewNode, [Node|RestPath])),   
	 ExtendedPaths), !.               
extend(_,[]).

% reached_target(State, Target)
% Succeeds if State is a Target state.
% For simple state-space search this is just if they are the same.

reached_target(State, State).

% Successor relation for ferry problem

ferry_route(piraeus, syros).
ferry_route(syros, paros).
ferry_route(paros, naxos).
ferry_route(naxos, amorgos).
ferry_route(naxos, santorini).
ferry_route(milos, santorini).
ferry_route(piraeus, kythnos).
ferry_route(piraeus, milos).
ferry_route(serifos, milos).
ferry_route(paros, serifos).

successor( X, Y) :- ferry_route(X, Y).
successor( X, Y) :- ferry_route(Y, X).



% Utilities

member(H,[H|_]).
member(H,[_|T]) :- member(H, T).

append([],L,L).
append([H|T],L,[H|R]) :- append(T, L, R).


