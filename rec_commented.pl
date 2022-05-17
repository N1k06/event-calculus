%-----------------------------------------------------------------------------%
% Re-definition of inequality signs to include infinite quantities.
lt(A,B):-gt(B,A).
le(A,B):-ge(B,A).

gt(inf,B):- B\==inf,!.
gt(_,inf):-!,fail.
gt(A,B):- A>B.

ge(A,A):-!.
ge(A,B):-gt(A,B).
%-----------------------------------------------------------------------------%

%-----------------------------------------------------------------------------%
% Re-definition of setof predicate.
my_setof(A,B,C):-
	setof(A,B,C),!.
my_setof(_,_,[]).
%-----------------------------------------------------------------------------%

%-----------------------------------------------------------------------------%
%Takes the list of events without duplicates and orders them.
order_events(Trace,OTrace):-
	order_events(Trace,[],OTrace).
	
order_events([],OTrace,OTrace).
order_events([H|T],OPTrace,OTrace):-
	ordered_insert(OPTrace,H,OPTraceNew),
	order_events(T,OPTraceNew,OTrace).

ordered_insert([],H,[H]).
ordered_insert([happens(Ev1,T1)|Trace],happens(Ev,T),[happens(Ev,T),happens(Ev1,T1)|Trace]):-
	T=<T1,!.
ordered_insert([H1|Trace],H,[H1|NewTrace]):-
	ordered_insert(Trace,H,NewTrace).
%-----------------------------------------------------------------------------%

%-----------------------------------------------------------------------------%
% Generic E.C. predicates.
holds_at(F, T):-
	holds_from(F, T, _).
	
holds_from(F, T, T1):-
	mholds_for(F, [T1, T2]),
	gt(T, T1),
	le(T, T2).


initiates(start, F, T):-
	initially(F).
	
declip(F,T):-
	happens(E,T),
	initiates(E, F, T),
	\+ holds_at(F, T).

clip(F,T):-
	happens(E,T),
	terminates(E, F, T),
	holds_at(F, T).
%-----------------------------------------------------------------------------%

%-----------------------------------------------------------------------------%
% Starts the REC engine, calculating fluents the initial state.
start:-
	update([happens(start,-1)]).
%-----------------------------------------------------------------------------%

%-----------------------------------------------------------------------------%
% REC engine backbone.
update(ExtTrace):-
	remove_duplicates(ExtTrace,NExtTrace),
	order_events(NExtTrace,OTrace),
	manage_concurrency(OTrace, Trace),
	update_events(Trace).

update_events([]).
update_events([H|T]):-
	update_events(H),
	update_events(T).	
	
update_events([happens(E,T)|Events]):-
	future_trace(T,FTraceRaw),
	order_events(FTraceRaw,FTraceO),
	manage_concurrency(FTraceO,FTrace),
	roll_back(T),
	calculate_effects([[happens(E,T)|Events]|FTrace]).
%-----------------------------------------------------------------------------%

%-----------------------------------------------------------------------------%
% Given an input timepoint, returns a list of all events which happen after that.
future_trace(T,FTrace):-
	my_setof(H,happens_after(H,T),FTrace).

% Predicate used for the previous setof. Returns an event which appen after Tref.
happens_after(happens(E,T),Tref):-
	happens(E,T),
	T > Tref.
%-----------------------------------------------------------------------------%

%-----------------------------------------------------------------------------%
% Given a timepoint T:
% - it removes all the events that happen after
% - it removes all the MVIs that start to hold after
% - it opens all the fluents that are holding at T
roll_back(T):-
	truncate_trace(T),
	remove_future_MVIs(T),
	open_current_MVIs(T).
%-----------------------------------------------------------------------------%

%-----------------------------------------------------------------------------%
% Given an input timepoint, obtains the future trace relative to those events 
% (i.e. all the events happened after T) and retracts them.
truncate_trace(T):-
	future_trace(T,FTrace),
	remove_events(FTrace).

remove_events([]).
remove_events([H|Trace]):-
	retract(H),
	remove_events(Trace).
%-----------------------------------------------------------------------------%	
	
%-----------------------------------------------------------------------------%
% Given a certain timepoint, removes all the MVI that start to hold
% afterwards.
remove_future_MVIs(T):-
	my_setof(MVI,future_MVI(MVI,T),MVIs),
	remove_MVIs(MVIs).

% Predicate used in the previous setof. Returns an MVI which starts to hold after
% the timepoint reference (Tref).
future_MVI(mholds_for(F,[Ts,Te]),Tref):-
	mholds_for(F,[Ts,Te]),
	gt(Ts,Tref).
%-----------------------------------------------------------------------------%

remove_MVIs([]).
remove_MVIs([MVI|MVIs]):-
	retract(MVI),
	remove_MVIs(MVIs).

%-----------------------------------------------------------------------------%
% Given a certain timepoint, opens all the MVIs that hold during that timepoint.
open_current_MVIs(T):-
	my_setof(MVI,current_MVI(MVI,T),MVIs),
	open_MVIs(MVIs).

% Predicate used in the previous setof. Returns an MVI which holds at the
% reference timepoint (Tstart<Tref=<Tend).
current_MVI(mholds_for(F,[Ts,Te]),Tref):-
	mholds_for(F,[Ts,Te]),
	gt(Tref,Ts),
	le(Tref,Te).
%-----------------------------------------------------------------------------%

%-----------------------------------------------------------------------------%
% Takes a list of MVIs, retracts them, and asserts new ones.
% The new MVIs have the same starting timepoints, but the ending timepoints are
% replaced with "inf". This is the meaning opening an MVI.
open_MVIs([]).
open_MVIs([mholds_for(F,[Ts,Te])|MVIs]):-
	retract(mholds_for(F,[Ts,Te])),
	assert(mholds_for(F,[Ts,inf])),
	open_MVIs(MVIs).
%-----------------------------------------------------------------------------%			

%-----------------------------------------------------------------------------%
%Applies the calculate_effects_events predicate to every element of the event list
calculate_effects([]).
calculate_effects([H|T]):-
	calculate_effects_events(H),
	calculate_effects(T).

% This is the core mechanism of REC. Each event E in the list, which happens at T:
% -is asserted back into the database
% -is evaluated to find fluents clipped by that event (at T)
% 	-the clipped fluents are closed
% -is evaluated to find fluents de-clipped by that event (at T)
% 	-the de-clipped fluents are opened
calculate_effects_events([happens(E,T)|Events]):-
	assert_all([happens(E,T)|Events]),
	my_setof(F, clip(F,T),S),
	close_mvis(S,T),
	my_setof(F, declip(F,T),S2),
	open_mvis(S2,T).
%-----------------------------------------------------------------------------%

%-----------------------------------------------------------------------------%
% Takes a list of MVIs and closes them with respect to timepoint T.
% The meaning of closing an MVI that holds at T, is to retract it 
% (if it's open -> ending time = inf) and to assert a new MVI with
% ending time replaced with T.
close_mvis([],_).
close_mvis([F|Fs],T):-
	close_mvi(F,T),
	close_mvis(Fs,T).
	
close_mvi(F,T):-
	holds_from(F,T,T1),
	retract(mholds_for(F,[T1,inf])),
	assert(mholds_for(F,[T1,T])).
%-----------------------------------------------------------------------------%

%-----------------------------------------------------------------------------%
% Takes a list of MVIs and opens them. 
% The meaning of opening a fluent's MVI is to retract the previous MVI and to 
% assert a new MVI with the ending time set to "inf"
open_mvis([],_).
open_mvis([F|Fs],T):-
	open_mvi(F,T),
	open_mvis(Fs,T).

open_mvi(F,T):-
	assert(mholds_for(F,[T,inf])).
%-----------------------------------------------------------------------------%

%-----------------------------------------------------------------------------%
% Returns the MVIs for all the active fluents.
status(MVIs):-
	findall(
(F,[T1,T2]),mholds_for(F,[T1,T2]),MVIs).


% Cleans the memory (trace and mvis)
reset:-
	retractall(happens(_,_)),
	retractall(mholds_for(_,_)).
%-----------------------------------------------------------------------------%
		
%-----------------------------------------------------------------------------%	
%Takes the ordered events list and returns a lists of lists.
%Every sublist is a list of events that happen in the same timepoint.
manage_concurrency([],[]).
manage_concurrency(L,[H|T]):-
	separate(L,H,TL),
	manage_concurrency(TL,T).
	
separate([happens(E,T)|Tail],HF,TF):-
	separate(Tail,[happens(E,T)],HF,TF).

separate([happens(E2,T)|Tail],[happens(E,T)|Tail2],HF,TF):-
		!,
		separate(Tail,[happens(E2,T),happens(E,T)|Tail2],HF,TF).
	
separate(L,HF,HF,L).
%-----------------------------------------------------------------------------%

%-----------------------------------------------------------------------------%
%Takes a list of happens predicates (raw trace) and removes duplicate events.
remove_duplicates([],[]).
remove_duplicates([happens(E,T)|Tail],L):-
	happens(E,T),!,
	remove_duplicates(Tail,L).
remove_duplicates([H|T],[H|T2]):-
	remove_duplicates(T,T2).
%-----------------------------------------------------------------------------%			

assert_all([]).
assert_all([H|T]):-
	assert(H),
	assert_all(T).
