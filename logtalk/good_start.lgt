:- object(good).
/*
	:- use_module(clpfd, [
		op(450, xfx, ..), op(700, xfx, ins),
		all_different/1, (ins)/2, labeling/2, sum/3
	]).

	:- uses(meta, [map/2::maplist/2]).
*/
	:- public(t1/1).

	t1(X) :- X = 'Good Start'.


:- end_object.
/*
?- good::t1(Z).
Z = 'Good Start'.

?- good::t1(Z), writeln(Z).
Good Start
Z = 'Good Start'.

?- 
*/
