e(F,E) :- f(F), e(E).
e(E,F) :- e(E), f(F).
e(F) :- f(F).
f(F,T) :- f(F), t(T).
f(T,F) :- t(T), f(F).
f(F) :- t(T).
t(T) :- e(T).
t(T) :- [int].
