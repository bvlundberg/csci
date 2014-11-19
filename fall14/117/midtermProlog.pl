a --> b, [a], a.
a --> [a], a.
a --> [b].
b --> [d].

aa(S0,S) :- bb(S0,S1), aa(S1,S).
aa(S0,S) :- S0 = [b|S].
bb(S0,S) :- S0 = [d|S].

%l(Ls) :- m(M), {Ri is 2*M}, r(Ri, Rs), {Ls = Rs}.
%r(Ri, Rs) :- [+], m(M), {Ri is L + M}, r(Ri, Rs), {Rs = Ri}.

lA(lA(A,a,B), String, A0) :- lB(A, String, Break), Break = [a|Tail], lA(B, Tail, A0).
lA(lA(a, A),[a|Tail], A0) :- lA(A, Tail, A0).
lA(lA(b),[b|Tail], Tail).
lB(lB(d),[d|Tail], Tail).

fA(String, A0) :- fB(String, Break), Break = [a|Tail], fA(Tail, A0).
fA([a|Tail], A0) :- fA(Tail, A0).
fA([b|Tail], Tail).
fB([d|Tail], Tail).

