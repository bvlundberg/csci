s(S0,S) :- vp(S0,S1), np(S1,S).
np(S0,S) :- masdet(S0,S1), masn(S1,S).
np(S0,S) :- femdet(S0,S1), femn(S1,S).
masn(S0, S) :- mn(S0,S1), masadj(S1, S).
femn(S0, S) :- fn(S0,S1), femadj(S1, S).
vp(S0,S) :- y(S0,S1), yconj(S1,S).
vp(S0,S) :- t(S0,S1), tconj(S1,S).
vp(S0,S) :- e(S0,S1), econj(S1,S).
vp(S0,S) :- l(S0,S1), lconj(S1,S).
vp(S0,S) :- n(S0,S1), nconj(S1,S).
vp(S0,S) :- eo(S0,S1), eoconj(S1,S).
vp(S0,S) :- ea(S0,S1), eaconj(S1,S).



masdet(S0,S) :- S0=[el|S].
femdet(S0,S) :- S0=[la|S].

mn(S0,S) :- S0=[coche|S].
mn(S0,S) :- S0=[plano|S].
fn(S0,S) :- S0=[casa|S].
fn(S0,S) :- S0=[motocicleta|S].

masadj(S0,S) :- S0=[rojo|S].
masadj(S0,S) :- S0=[grande|S].
masadj(S0,S) :- S0=[pequeno|S].

femadj(S0,S) :- S0=[roja|S].
femadj(S0,S) :- S0=[grande|S].
femadj(S0,S) :- S0=[pequena|S].

y(S0,S) :- S0=[yo|S].
t(S0,S) :- S0=[tu|S].
e(S0,S) :- S0=[el|S].
l(S0,S) :- S0=[ella|S].
n(S0,S) :- S0=[nos|S].
eo(S0,S) :- S0=[ellos|S].
ea(S0,S) :- S0=[ellas|S].

yconj(S0,S) :- S0=[compro|S].
yconj(S0,S) :- S0=[monto|S].

tconj(S0,S) :- S0=[compras|S].
tconj(S0,S) :- S0=[montas|S].

econj(S0,S) :- S0=[compra|S].
econj(S0,S) :- S0=[monta|S].

lconj(S0,S) :- S0=[compra|S].
lconj(S0,S) :- S0=[monta|S].

nconj(S0,S) :- S0=[compramos|S].
nconj(S0,S) :- S0=[montamos|S].

eoconj(S0,S) :- S0=[compran|S].
eoconj(S0,S) :- S0=[montan|S].

eaconj(S0,S) :- S0=[compran|S].
eaconj(S0,S) :- S0=[montan|S].