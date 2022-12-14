perceive(P,T):-
    (P=generic_event(Value1),
    add(happensAt(generic_event(Value1),T)));
    (P=glucose(Value1),
    add(happensAt(glucose(Value1),T)));
    (P=blood_pressure(Sys,Dias),
    add(happensAt(blood_pressure(Sys,Dias),T)));
    (P=weight(Value1),
    add(happensAt(weight(Value1),T))).

act(A,T):-
    holds_at(alert(Number)=situation(Something),T),
    A = act(produce_alert(Number,Something)),
    not Something = no_alert,
    revise_me(A,T).

revise_me(A,T):-!,
    A = act(produce_alert(Number,Something)),
    add(happensAt(alert(Number,Something),T)).

initiates_at(alert(Number)=situation(no_alert),T):-
    holds_at(alert(Number)=situation(Something),T),
    happens_at(alert(Number,Something),T).

terminates_at(alert(Number)=situation(V1),T):-
    holds_at(alert(Number)=situation(V1),T),
    initiates_at(alert(Number)=situation(V2),T),
    not V2 = V1.

more_or_equals_to(Number,Expr):-
	findall(_,Expr,List),
	length(List,Val),
	Val >= Number.

% Predicate used to print in the Java console
println(S):-
	class('java.lang.System').out<-get(Out),
	Out<-println(S).