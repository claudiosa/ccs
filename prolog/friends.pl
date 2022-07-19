:- discontiguous live_away/1. 
:- discontiguous live_close/1. 
:- discontiguous drink/2. 
:- discontiguous friends/2. 

/*Juan, José, Jeremías and Jorge have their own cars.*/
has_car(juan).
has_car(jeremias).
has_car(jorge).

/*Aida and Analía live close enough to the party to walk.*/
live_close(aida).
live_close(amalia).
%live_close(X) :-  \+  live_away(X), !.

/* Roberto, Raul, Rodrigo and Ana live too far away.*/
live_away(roberto).
live_away(raul).
live_away(rodrigo).
live_away(X) :-  \+  (live_close(X)).

/* José and Jeremías only drank juice.*/
drink(jose,juice).
drink(jeremias,juice).

/*Anacleta lives far away and is friends with Juan.*/
live_away(anacleta).
friends(anacleta,juan).
friends(X,Y) :- friends(Y,X), !.

/* Anastasia lives far away and is friends with José. */
friends(anacleta,jose).

 /* Raúl and José are not friends, but Roberto and Jeremías are friends.*/
%%%%\+ friends(raul,jose).
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
go_by_ride(X) :- 
    friends(X,Y),
    X \== Y,
    has_car(Y),
    live_away(X),
    drink(Y,D),
    D \== wine, !.
go_by_ride(_) :- write("NO MORE SOLUTIONS").
