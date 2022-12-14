:-include("/home/nicola/Documents/rec_tupl_commented.pl").

% implementation of lazy clocks
% every time a a clock has to be reset, the offset simply gets initiated to the reset event's timepoint minus the reset value.
% this mechanism simulates that whenever the reset event happens, the clock starts counting time again (from the specified reset value).
% for each new relative clock, its offset must be initialized with an initially clause.
initiates(reset(C,V),status(offset(C),Tnew),T):-
	holds_at(status(offset(C),Told),T),
	Tnew is T-V.

terminates(reset(C,_),status(offset(C),Told),T):-
	holds_at(status(offset(C),Told),T).

% relative clocks update
%holds_at(status(rclk(C),Told),T),
initiates(E,status(rclk(C),Tnew),T):-
	holds_at(status(offset(C),Tres),T),
	Tnew is T - Tres,
	not (E = reset(C,_)),
	print("Initiating "),print(status(rclk(C),Tnew)),nl.

initiates(reset(C,V),status(rclk(C),V),_).
%	holds_at(status(rclk(C),Told),T).

terminates(_,status(rclk(C),Told),T):-
	holds_at(status(rclk(C),Told),T),
	print("Terminating "),print(status(rclk(C),Told)),nl.

% implementation of states and transitions
% state transitions are caused by events, denoted by the variable "Lab". Such name recalls the labels from the graph notation used for automatons.
initiates(Lab,Snew,T):-
	arc(Lab,Sold,Snew),
	holds_at(Sold,T),
	clockset(Lab,Sold,Snew,T),
	guard(Lab,Sold,Snew,T).

terminates(Lab,Sold,T):-
	arc(Lab,Sold,_),
	holds_at(Sold,T).

% the actual automaton (Domain Dependent)
initially(status(offset(x),0)).
initially(status(rclk(x),0)).

arc(press,off,light).
clockset(press,off,light,T):-
	update([happens(reset(x,0),Tnext)]),
	Tnext is T + 1.
guard(press,off,light,_).

arc(press,light,off).
guard(press,light,off,T):-
	holds_at(status(rclk(x),X),T),
	X > 3.
clockset(press,light,off,_).

arc(press,light,bright).
guard(press,light,bright,T):-
	holds_at(status(rclk(x),X),T),
	X =< 3.
clockset(press,light,bright,_).

arc(press,bright,off).
guard(press,bright,off,_).
clockset(press,bright,off,_).

initially(off).

%initiates(a,fa,T):-
%	update([happens(b,T)]).
%initiates(b,fb,_).

%happens(c,T):-
%	happens(a,T),
%	happens(b,T).
%initiates(c,fc,_).

%old fluents are not terminated
prova_rclk:-
	start,
	update([happens(a,1),happens(a,10),happens(a,20)]),
	status(M),
	print(M),nl,
	reset.

%looks like ok
prova_offset:-
	start,
	update([happens(reset(x,2),3),happens(reset(x,0),5)]),
	status(M),
	print(M),nl,
	reset.

prova_aut:-
	start,
	update([happens(press,1)]),
	status(M),
	print(M),nl,
	reset.
