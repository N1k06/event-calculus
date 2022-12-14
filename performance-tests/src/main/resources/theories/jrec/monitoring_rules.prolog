:- include("src/main/resources/theories/jrec/utils.prolog").
:- include("src/main/resources/theories/jrec/rule_templates.prolog").

%COMPLEX RULE CUSTOMIZATION.
%For every event that can trigger the alert, an artificial event is generated, to be sure
%that the system evaluates the rule accordingly. 
happens(evc(1,prehypertension),T):-
	happens(blood_pressure(S,D),T),
	S >= 130,
	D >= 80.

happens(alertcheck(prehypertension,E,2),T):-
	weeks_to_epoch(1,E),
	happens(evc(1,prehypertension),T).



%SEQUENTIAL RULE CUSTOMIZATION
happens(ev(1,brittlediabetes,E),T):-
	hours_to_epoch(6,E),
	happens(glucose(G),T),
	G=<3.8.

happens(ev(2,brittlediabetes,E),T):-
	hours_to_epoch(6,E),
	happens(glucose(G),T),
	G>=8.



happens(ev(1,gainingweight,E),T):-
	weeks_to_epoch(1,E),
	happens(weight(W),T),
	W=<93.7.

happens(ev(2,gainingweight,E),T):-
	weeks_to_epoch(1,E),
	happens(weight(W),T),
	W>=94.6.