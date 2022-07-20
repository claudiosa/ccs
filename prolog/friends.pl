% ?-['friends.pl']. ===> to load the code in SWI-PROLOG
%
% PART A -- the SWI-IMPLEMENTATION
% 
% 
%% TO DECLARE IN MANY PREDICATES IN DIFFERENT PARTS of this code 
:- discontiguous live_away/1. 
:- discontiguous live_close/1.
:- discontiguous has_car/1. 
:- discontiguous drink/2. 
:- discontiguous friends/2. 

/*Juan, José, Jeremías and Jorge have their own cars.*/
has_car(juan).
has_car(jose).
has_car(jeremias).

/*Aida and Analía live close enough to the party to walk.*/
live_close(aida).
live_close(analia).

/* Roberto, Raul, Rodrigo and Ana live too far away.*/
live_away(roberto).
live_away(raul).
live_away(rodrigo).
live_away(ana).

/* José and Jeremías only drank juice.*/
drink(jose,juice).
drink(jeremias,juice).

/*Anacleta lives far away and is friends with Juan.*/
live_away(anacleta).
friends(anacleta,juan).

/* Anastasia lives far away and is friends with José. */
live_away(anastacia).
friends(anastacia,jose).

 /* Raúl and José are not friends, but Roberto and Jeremías are friends.*/
friends(raul,jose) :- false.
friends(roberto,jeremias).

%Ana is a friend of José.
friends(ana,jose).

%Analía is a friend of Juan's.
friends(analia,juan).

%Aida doesn't know anyone.

%Juan drank liters of wine.
drink(juan,wine).

%Jorge danced.
dance(jorge).

%Jorge was the only one who had a car that didn't bring him to the party.
has_car(jorge).


%% Given the friendship of each of the characters, consider that you can offer your friend a ride home in the car.
offer_a_ride(X, Y) :- 
    friends(X,Y),
    X \== Y,
    has_car(Y),
    Y \== jorge, %% didn't bring him to the party.
    live_away(X),
    drink(Y,D),
    ( D \== wine ; D == juice ). %% avoiding duplication of this clause

%offer_a_ride(_,_) :- write("NO MORE SOLUTIONS").
lst_offer_a_ride :- 
    findall((X,Y), offer_a_ride(X, Y), L), 
    remove_duplicates(L,L_out), 
    print_pairs(L_out).

% ALTERNATIVE CODE of FINDALL ... exactly at the same
%lst_offer_a_ride :- offer_a_ride(X,Y), write(X), write(" <--> "), write(Y), nl, fail.
%lst_offer_a_ride :- !.

%% END OF PART A

% PART B -- Create the following rule and give all possible answers, fully reasoning why:
sure(X) :-  findall((X,Y), offer_a_ride(X, Y), L), 
            remove_duplicates(L,X), 
            print_pairs(X).
/*
?- sure(X), write(X).
anastacia <--> jose
roberto <--> jeremias
ana <--> jose
[(anastacia,jose), (roberto,jeremias), (ana,jose)]
X = [(anastacia,jose), (roberto,jeremias), (ana,jose)]
*/

% PART C -- Create the following rule NOT based on the previous one, reasoning it completely:
not_sure(X)	:-   %%% the driver can drink ANYTHING
      findall((X,Y), not_safe(X, Y), L), 
      remove_duplicates(L,X), 
      print_pairs(X).
    
% NOT SAFE ... the driver can drink anything 
not_safe(X,Y) :-
    friends(X,Y),  %%% supposition that the rider is a friend of this driver
    X \== Y,
    has_car(Y),
    Y \== jorge, %% didn't bring him to the party. -- jorge is driver that goes alone
    live_away(X) .

/*
?- not_sure(X), write(X).
anacleta <--> juan
anastacia <--> jose
roberto <--> jeremias
ana <--> jose
[(anacleta,juan), (anastacia,jose), (roberto,jeremias), (ana,jose)]
X = [(anacleta,juan), (anastacia,jose), (roberto,jeremias), (ana,jose)]

*/

%% PART --  D

%1) That other people's friends are represented by a list. 
/*
 * YES
The friendship can be represented by a list tuple-2 
with all relations:
friends([(anacleta,juan), (anastacia , jose), (roberto, jeremias), .....]).
*/

%2) That the drinks people have had are represented by a list.
/*
 * YES ... with this representation:
drinks([(jose, juice), (jeremias, juice), (juan, wine)]).
*/


%% PART -- E (40%) Analyze your program
/*
   Once you have solved the problem, justify the elements you have chosen for the creation of the program by explaining the process you have followed to obtain your code and the problems encountered at the same time if you have been able to solve the way you have done it. solved them.

The strategy of this solution and comments:

1. The problem has a short description, so an immediate assertive
was declared in PROLOG

2. The predicates were created following a "natural" language of its propositon
Example:
%Analía is a friend of Juan's.
friends(analia,juan).

3. Due the backtracking embeded of Prolog, duplicate answers must be avoid, so was 
created "remove_duplicates"

4. A list approach could be adopted, but, it is not the case due the size and atypical
cases such: 
Raúl and José are not friends ..... represented in Prolog by:
friends(raul,jose) :- false.
if it was ommitted the solution are the same.

5. A declarativity in a natural language become everything clear to debug et all

*/


%%% AUXILIAR predicates    
%
%
remove_duplicates([],[]):- !.
%remove_duplicates([A],[A]):- !.
remove_duplicates([H | T], [H|T1]) :- 
       \+member(H, T), 
       remove_duplicates( T, T1).
remove_duplicates([H | T], T1 ) :- 
       member(H, T), 
       remove_duplicates( T, T1).

%
print_pairs([]) :-  write(" EMPTY LIST TO PRINT"),  !.
print_pairs([(X,Y)]) :-  write(X), write(" <--> "), write(Y), nl, !.
print_pairs([(X,Y)|L]) :-  
    write(X), write(" <--> "), write(Y), nl,
    print_pairs(L).
  
%
%friends(X,Y) :- friends(Y,X), !.
%
%% LISTING the friends
lst_friends :- friends(X,Y), write(X), write(" <--> "), write(Y), nl, fail.
lst_friends :- !. 
/*
?- lst_friends .
anacleta <--> juan
anastacia <--> jose
roberto <--> jeremias
ana <--> jose
analia <--> juan
true
*/
%live_close(X) :-  \+  live_away(X), !.
%% LISTING who is live close
lst_live_close :- live_close(X), write(X), nl, fail.
lst_live_close :- !.

%live_away(X) :-  \+  (live_close(X)), !.
%% LISTING who is live away
lst_live_away :- live_away(X), write(X), nl, fail.
lst_live_away :- !.

%%% listing persons and drinks
lst_drinks :- drink(X,Y), write(X), write("  drinks  "), write(Y), nl, fail.
lst_drinks :- !. 
/*
jose drinks juice
jeremias drinks juice
juan drinks wine
true
 */
