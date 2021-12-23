%% USAGE:
/*

%%$ time(swipl -f diff_CP_search.pl -t go1)

%% TRAP of PL
%%$ time(swipl -f diff_CP_search.pl -t go2)
$ time(swipl -f diff_CP_search.pl -t go2)
..............
after almost 3 min
..............
===============
[9,5,6,7,1,0,8,2]
===============
% halt

real	2m17,524s
user	2m17,164s
sys	0m0,047s


%% with CP
$ time(swipl -f diff_CP_search.pl -t go)

*/
:- use_module(library(clpfd)).

%%% without CP
go1:- solve([X,Y,Z], L_Sol),
    writeln("==============="),
    write(L_Sol),
    writeln("\n===============").

go2:- solve([S,E,N,D,M,O,R,Y], L_Sol),
    writeln("==============="),
    write(L_Sol),
    writeln("\n===============").  

solve(L_inp, L_sol) :-
    search_value(L_inp, L_sol),
    my_different(L_sol),
    %% test_XYZ(L_sol). %% for go1
    test_sum(L_sol).

%% a domain
dom( [0,1,2,3,4,5,6,7,8,9] ).

% a search and assignment
search_value( [] , []) :- !.
search_value([ _ |L1], [X|L2]) :-
    dom(D),
    member(X,D),
    search_value(L1, L2).

%% a logical condition
my_different([]).
my_different([H|T]) :- not(member(H,T)),
                     my_different(T).

%% a toy condition
test_XYZ([X,Y,Z]) :-
    X >= 0,
    Y >= 1,
    (X + Y) =:= Z.
  
%[9,5,6,7,1,0,8,2]
%% test of SUM
test_sum([S,E,N,D,M,O,R,Y]) :-
    MONEY is (10000*M + 1000*O + 100*N + 10*E + Y),
    M \= 0,
    S \= 0,
    (1000 * S + 100 * E + 10 * N + D +
    1000 * M + 100 * O + 10 * R + E) =:=  MONEY.

%
% Plain CLP ===> HAKAN ===> modified by CCS
%
go :-
    writeln(digits_most_before=Digits),
    send_more_money_CLP(Digits),
    writeln(digits_before=Digits),
    %% HERE YOU MUST CHANGE A LOT ...
    %% see the labeling/2 ===> options of variable choice
    %% and selection from domain
    search_CP([ max , down ], Digits),
    writeln(digits_after=Digits).


search_CP(Options, Vars):-
    labeling(Options, Vars). %%% HERE the biggest difference

/*
Like all_distinct/1, but with weaker propagation. 
Consider using all_distinct/1 instead, s
ince all_distinct/1 is
 typically acceptably efficient 
 and propagates much more strongly.

*/

send_more_money_CLP(Digits) :-
    Digits = [S,E,N,D,M,O,R,Y],
    Digits ins 0..9,

    %all_distinct(Digits),
    all_different(Digits), %% WEAKER
    S #> 0,
    M #> 0,
           1000*S + 100*E + 10*N + D
    +      1000*M + 100*O + 10*R + E
    #= 10000*M + 1000*O + 100*N + 10*E + Y.

/*
ATTENTION HERE:
https://www.swi-prolog.org/pldoc/doc_for?object=labeling/2
*/
