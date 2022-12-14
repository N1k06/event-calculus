happens(trigger(brittlediabetes),T2):-
	weeks_to_epoch(6,W),
	happens(glucose(G2),T2),
	happens(glucose(G1),T1),
	G2 >= 8,
	G1 =< 3.8,
	(T2-T1) =< W,
	\+ holds_at(noalert(brittlediabetes,_),T2).

%Il primo evento della catena di eventi resetta il fluente.
happens(toggle(brittlediabetes),T):-
	happens(glucose(G),T),
	G =< 3.8.

initiates(trigger(S),alert(S),T).
terminates(toggle(S),alert(S),T).

initiates(trigger(S),noalert(S,Tend),T):-
	weeks_to_epoch(6,W),
	Tend is T+W.

terminates(toggle(S),noalert(S,Tend),T):-
	holds_at(noalert(S,Tend),T),
	T > Tend.
		
weeks_to_epoch(W,E):-
	E is W * 7 * 24 * 3600 * 1000.


/*
glucose(2) 1
glucose(10) 2
glucose(2) 3
glucose(10) 4
glucose(2) 5
glucose(10) 6
glucose(2) 21
glucose(10) 22
glucose(2) 23
glucose(10) 24
glucose(2) 25
glucose(10) 26
*/
