s(P0, P) :- np(P0, P1), vp(P1, P).
np(P0, P) :- det(P0, P1), n(P1, P2), optrel(P2, P).
np(P0, P) :- pn(P0, P).
vp(P0, P) :- tv(P0, P1), np(P1, P).
p(P0, P) :- iv(P0, P).
optrel(P, P).
optrel(P0, P) :- connects(that, P0, P1), vp(P1, P).
pn(P0, P) :- connects(terry, P0, P).
pn(P0, P) :- connects(shrdlu, P0, P).
iv(P0, P) :- connects(halts, P0, P).
det(P0, P) :- connects(a, P0, P).
n(P0, P) :- connects(program, P0, P).
tv(P0, P) :- connects(writes, P0, P).