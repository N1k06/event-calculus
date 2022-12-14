initiates_at(alert(first)=situation('Brittle diabetes'),T):-
        hours_ago(6,Tago,T),
        not query_kd(happens_at(alert(first,'Brittle diabetes'),Tev0), [Tago, T]),
        query_kd(happens_at(glucose(Value1),Tev1), [Tago, T]),
        query_kd(happens_at(glucose(Value2),Tev2), [Tago, T]),
        Value1 =< 3.8,
        Value2 >= 8,
        Tev2 > Tev1.

initiates_at(alert(second)=situation('pre-hypertension'),T):-
        weeks_ago(1,Tago,T),
        not query_kd(happens_at(alert(second,'pre-hypertension'),Tev0), [Tago, T]),
        query_kd(happens_at(blood_pressure(Sys2,Dias2),Tev2), [Tago, T]),
        Tev2 = T,
        Sys2 >=130,
        Dias2 >= 80,
        more_or_equals_to(2,(
                query_kd(happens_at(blood_pressure(Sys,Dias),Tev), [Tago, T]),
                Sys >= 130,
                Dias >= 80,
                within_weeks(1,Tev,T)
        )).

initiates_at(alert(third)=situation('Gaining weight'),T):-
        weeks_ago(1,Tago,T),
        not query_kd(happens_at(alert(third,'Gaining weight'),Tev0), [Tago, T]),
        query_kd(happens_at(weight(Value1),Tev1), [Tago, T]),
        query_kd(happens_at(weight(Value2),Tev2), [Tago, T]),
        Value1 =< 93.7,
        Value2 >= 94.6,
        Tev2 > Tev1,
        Tev2 = T.