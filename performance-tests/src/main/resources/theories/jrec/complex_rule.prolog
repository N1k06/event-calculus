%POTENTIALLY USEFUL jREC PREDICATES! THEY SHOULD BE TESTED
%holds_from(alert(brittlediabetes),T,T1).
%mholds_for(F, [T1, T2]).

initially(status(timewindow(Alert),0)).



initiates(trigger(Alert),alert(Alert),T).
terminates(E,alert(Alert),T):-
	holds_at(alert,T),
	checkevent(E),
	holds_at(status(timewindow(Alert),Tend0),T),
	T>Tend0.


% checking that E is one of the events that can
% trigger the alert.
checkevent(E):-
	E = ev1;
	E = ev2.



%creating new timewindows and terminating old ones.
initiates(E,status(timewindow(Alert),Tend),T):-
	checkevent(E),
	Tend is T + 10,
	holds_at(status(timewindow(Alert),Tend0),T),
	T>Tend0.

terminates(E,status(timewindow(Alert),Tend0),T):-
	checkevent(E),
	holds_at(status(timewindow(Alert),Tend0),T),
	T>Tend0.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rule checking is forced for every new event occurence.
happens(tick,T):-
	happens(ev1,T);
	happens(ev2,T).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% event counting. an event arrives inside the timewindow
initiates(E,status(counter(E),Cnew),T):-
	checkevent(E),
	holds_at(status(counter(E),Cold),T),
	Cnew is Cold+1,
	holds_at(status(timewindow(Alert),Tend),T),
	T=<Tend.

terminates(E,status(counter(E),Cold),T):-
	checkevent(E),
	holds_at(status(counter(E),Cold),T),
	holds_at(status(timewindow(Alert),Tend),T),
	T=<Tend.



% event counting. an event arrives outside the timewindow
% TODO: CERCARE UNA SOLUZIONE PIÙ ELEGANTE DI QUESTA!
initiates(E,status(counter(ev1),1),T):-
	checkevent(E),
	holds_at(status(timewindow(Alert),Tend),T),
	T>Tend.

initiates(E,status(counter(ev2),1),T):-
	checkevent(E),
	holds_at(status(timewindow(Alert),Tend),T),
	T>Tend.

terminates(E,status(counter(_),Cold),T):-
	checkevent(E),
	holds_at(status(counter(E),Cold),T),
	holds_at(status(timewindow(Alert),Tend),T),
	T>Tend,
	Cold\=1. 



%rule checking and alert triggering.
% IN QUESTO MODO IL SISTEMA È PIÙ LENTO. IL SISTEMA CONTROLLA
% LA REGOLA AD OGNI NUOVO EVENTO.
happens(trigger),T):-
	happens(tick,T),
	holds_at(status(counter(ev1),V1),T),
	holds_at(status(counter(ev2),V2),T),
	V1>=3,
	V2>=2.

% USANDO QUESTA, INVECE CHE LA PRECEDENTE, IL SISTEMA È PIÙ VELOCE.
% LA REGOLA VIENE CONTROLLATA SOLTANTO QUANDO IL SISTEMA INVIA 
% L'EVENTO "ticksys"
/*
happens(trigger,T):-
	happens(ticksys,T),
	holds_at(status(counter(ev1),V1),T),
	holds_at(status(counter(ev2),V2),T),
	V1>=3,
	V2>=2.
*/
