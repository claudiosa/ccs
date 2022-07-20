
:- discontiguous live_away/1. 
:- discontiguous live_close/1. 
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

%% Given the friendship of each of the characters, consider that you can offer your friend a ride home in the car.
offer_a_ride(X, Y) :- 
    friends(X,Y),
    X \== Y,
    has_car(Y),
    live_away(X),
    drink(Y,D),
    ( D \== wine ; D == juice ).

offer_a_ride(_,_) :- write("NO MORE SOLUTIONS").

lst_offer_a_ride :- offer_a_ride(X,Y), write(X), write(" <--> "), write(Y), nl, fail.
lst_offer_a_ride :- !.
    
%%% Final predicates    
friends(X,Y) :- friends(Y,X), !.
lst_friends :- friends(X,Y), write(X), write(" <--> "), write(Y), nl, fail.
lst_friends :- !. 

live_close(X) :-  \+  live_away(X), !.
lst_live_close :- live_close(X), write(X), nl, fail.
lst_live_close :- !.

live_away(X) :-  \+  (live_close(X)), !.
lst_live_away :- live_away(X), write(X), nl, fail.
lst_live_away :- !.
