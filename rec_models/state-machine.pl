initiates(exec(L),Snew,T):-
 arc(L,Sold,Snew),
 holds_at(Sold,T).

terminates(exec(L),Sold,T):-
 arc(L,Sold,_),
 holds_at(Sold,T).

arc(e1,s1,s2).
arc(e2,s2,s1).

initially(s1).
