%COMPLEX RULE TEMPLATES
%Initiating the rule with the artificial event avoids the need of duplicating the rule initiation 
%with every possible event considered in the body of the rule.

%COMPLEX RULE WITH 1 EVENT
initiates(alertcheck(A,W,NMax1),A,T):-
	T0 is (T-W),
	count_events_tw(N1,evc(1,A),T0,T),
	N1 >= NMax1,
	no_alert(A,T0).

terminates(alertcheck(A,W,_),A,T):-
	holds_at(A,T).

%COMPLEX RULE WITH 2 EVENTS
initiates(alertcheck(A,W,NMax1,NMax2),A,T):-
	T0 is (T-W),
	count_events_tw(N1,evc(1,A),T0,T),
	N1 >= NMax1,
	count_events_tw(N2,evc(2,A),T0,T),
	N2 >= NMax2,
	no_alert(A,T0).

terminates(alertcheck(A,W,_,_),A,T):-
	holds_at(A,T).

%An alert's fluent is terminated by any event specified in the body of the rule.
%This could be subject to changes in future system advancements, because it 
%could be also reasonable to terminate the fluent with a very specific system
%generated event, like for example "togglealert(A)".



%SEQUENTIAL RULE TEMPLATE WITH 2 EVENTS.
initiates(ev(2,A,W),A,T):-
	T0 is (T-W),
	happens(ev(1,A,_),T1),
	T > T1,
	T1 >= T0,
	no_alert(A,T0).

terminates(ev(1,A,_),A,_).