%SEQUENTIAL RULE TO TRIGGER WEIGHT GAINING CONDITION.
%SEE THIRD RULE ON "monitoring_rules.pl"
%TODO: FIX TIMEWINDOWS TO DEAL WITH REAL TIMESTAMPS

happens(exec(trigger(gainingweight)),T2):-
	happens(exec(weight(W2)),T2),
	happens(exec(weight(W1)),T1),
	W2 >= 94.6,
	W1 =< 93.7,
	(T2-T1) < 6.


%Il primo evento della catena di eventi resetta il fluente.
happens(exec(toggle(gainingweight)),T):-
	happens(exec(weight(W)),T),
	W =< 93.7.

initiates(exec(trigger(S)),alert(S),T).
terminates(exec(toggle(S)),alert(S),T).



/*
weight(90) 1
weight(95) 2
weight(90) 3
weight(98) 4
weight(90) 5
weight(80) 6
weight(100) 7
weight(99) 8
weight(71) 9
weight(98) 10
weight(99) 11
weight(90) 12
weight(99) 13
*/
