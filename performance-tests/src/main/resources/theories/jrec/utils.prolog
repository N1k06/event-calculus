%Time conversion 
weeks_to_epoch(W,E):-
	E is W * 7 * 24 * 3600 * 1000.

hours_to_epoch(H,E):-
	E is H * 3600 * 1000.

%Counting how many events "E" happen inside a Tstart-Tend time window.
count_events_tw(X,E,Tstart,Tend) :-
	findall(N, check_event_tw(E,Tstart,Tend), Ns),
	length(Ns, X).

check_event_tw(E,Tstart,Tend):-
	happens(E,T),
	T=<Tend,
	T>=Tstart.

%Checking that a certain alert "A" is not triggered after a certain timepoint Tstart.
check_alert_tw(A,Tstart):-
	mholds_for(A,[T1,_]),
	T1 >= Tstart.

no_alert(A,Tstart):-
	findall(N, check_alert_tw(A,Tstart), Ns),
	length(Ns, X),
	X=0.