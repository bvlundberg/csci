fib(X,0) :- X < 0,!.
fib(X,1) :- X < 1,!.
fib(X,Ans) :- fib(X-1,A), fib(X-3,B), fib(X-4,C), Ans is A+B+C,!.

removen(0, L, L).
removen(N, [_|Xs], Ans) :- N1 is N-1, removen(N1, Xs, Ans).

twice(X, Y) :- length(X,Xl), removen(Xl,Y,Yn), X == Yn.