% implementation of lazy clocks
% every time a a clock has to be reset, the offset simply gets initiated to the reset event's timepoint minus the reset value.
% this mechanism simulates that whenever the reset event happens, the clock starts counting time again (from the specified reset value).
% for each new relative clock, its offset must be initialized with an initially clause.
initiates(exec(reset(C,V)),status(offset(C),Tnew),T):-
	holds_at(status(offset(C),Told),T),
	Tnew is T-V.

terminates(exec(reset(C,_)),status(offset(C),Told),T):-
	holds_at(status(offset(C),Told),T).

% relative clocks update
initiates(exec(E),status(rclk(C),Tnew),T):-
	holds_at(status(rclk(C),Told),T),
	holds_at(status(offset(C),Tres),T),
	Tnew is T - Tres,
	not (E = reset(C,_)).

initiates(exec(reset(C,V)),status(rclk(C),V),T):-
	holds_at(status(rclk(C),Told),T).

terminates(exec(E),status(rclk(C),Told),T):-
	holds_at(status(rclk(C),Told),T).

% implementation of states and transitions
% state transitions are caused by events, denoted by the variable "Lab". Such name recalls the labels from the graph notation used for automatons.
initiates(exec(Lab),Snew,T):-
	arc(Lab,Sold,Snew),
	holds_at(Sold,T),
	guard(Lab,Sold,Snew,T),
	clockset(Lab,Sold,Snew,T).

terminates(exec(Lab),Sold,T):-
	arc(Lab,Sold,_),
	holds_at(Sold,T).

% the actual automaton (Domain Dependent)
initially(status(offset(x),0)).
initially(status(rclk(x),0)).

arc(press,off,light).
guard(press,off,light,_).
clockset(press,off,light,T):-
	update([happens(exec(reset(x,0)),T)]).

arc(press,light,off).
guard(press,light,off,_):-
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

%initiates(exec(a),fa,T):-
%	update([happens(exec(b),T)]).
%initiates(exec(b),fb,_).
