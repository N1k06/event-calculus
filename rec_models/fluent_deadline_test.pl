/*Fluents and deadlines for jREC*/
/*Deadline is fullfilled only if receipt is sent at least 2 timesteps and at most 5 timesteps after the payment*/
initiates(exec(pay_order(N)), status(response(N),pending), _).
terminates(exec(pay_order(N)), status(response(N),off), _).

initiates(exec(send_receipt(N)),status(response(N),violation_early),T):-
	T0 is T - 2,
	T1 is T - 5,
	\+ holds_at(status(response(N),pending),T0),
	\+ holds_at(status(response(N),pending),T1).

initiates(exec(send_receipt(N)),status(response(N),violation_late),T):-
	T0 is T - 2,
	T1 is T - 5,
	holds_at(status(response(N),pending),T0),
	holds_at(status(response(N),pending),T1).	

initiates(exec(send_receipt(N)),status(response(N),fullfilled),T):-
	T0 is T - 2,
	T1 is T - 5,
	holds_at(status(response(N),pending),T0),
	\+ holds_at(status(response(N),pending),T1).

terminates(exec(send_receipt(N)),status(response(N),pending),T).

initially(status(response(1), off)).
initially(status(response(2), off)).
initially(status(response(3), off)).
initially(status(response(4), off)).

/*
tick 1
tick 2
tick 3
tick 4
tick 5
tick 6 
tick 7
tick 8
tick 9 
tick 10
pay_order(1) 1
send_receipt(1) 3
pay_order(2) 1
send_receipt(2) 4
pay_order(3) 1
send_receipt(3) 6
pay_order(4) 1
send_receipt(4) 7
*/