Brandon Lundberg
CSCI 117
Lab 10
7 Novemeber 2014

% Part 6
l(Ls) :- l(Li), [+], m(M), {Ls is Li + M}.
l(Ls) :- m(M), [-], l(Li), {Ls is M - Li}.
l(Ls) :- m(M), {Ls is 2*M}.
m(M) :- [a], {M is 1}.
m(M) :- [b], {M is 2}.

Could not quite get this to run. Not sure where the error is...

% Part 7
DCG
a --> b, [a], a.
a --> [a], a.
a --> [b].
b --> [d].

Parse Tree
lA(lA(A,a,B), String, A0) :- lB(A, String, Break), Break = [a|Tail], lA(B, Tail, A0).
lA(lA(a, A),[a|Tail], A0) :- lA(A, Tail, A0).
lA(lA(b),[b|Tail], Tail).
lB(lB(d),[d|Tail], Tail).
.
?- lA(X, [d,a,b], []).
X = lA(lB(d), a, lA(b)) .

?- lA(X, [b,a], []).
false.

?- lA(X, [d,a,a,a,b], []).
X = lA(lB(d), a, lA(a, lA(a, lA(b)))) 
