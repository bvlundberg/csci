% CSci 117	Programming Languages	Fall 2014
% Brandon Lundberg


%Part I  Extension to Exponential Case

	E  ->  T R
 	R  ->  + T R  |  - T R
	R  ->  
	T  ->  F S
	S ->  * F S  |  / F S | ^ F S
	S  ->  
	F  ->  ( E )
	F  ->  identifier
	F  ->  number


%Part II  Top Down Translation
%This part is based on the materials in the section on top-down translation on pages 302 to 308 in Aho, Sethi and Ullman’s text.  First we illustrate the use of definite clause grammar with the following example, which demonstrates the use of inherited attributes on page 303

expr(Es)  -->  term(Tval), { Ri = Tval }, rem(Ri,Rs), { Es is Rs }.

rem(Ri,Rs)  -->  [+], term(Tval), { Rj is Ri + Tval}, rem(Rj,Rs1), { Rs is Rs1}.

rem(Ri,Rs)  -->  [-], term(Tval), { Rj is Ri - Tval }, rem(Rj,Rs1), { Rs is Rs1}.

rem(Ri,Rs)  -->  [], { Rs is Ri }.

term(Tval)  -->  [Tval].

mrem(Mi, Ms) → [*],  mterm(Mval), {Mj is Mi * Mval}, mrem(Mj,Ms1), {Rs is Rs1}.

mrem(Mi, Ms) → [/],  mterm(Mval), {Mj is Mi/ Mval}, mrem(Mj,Ms1), {Rs is Rs1}.

mrem(Mi, Ms) → [^],  mterm(Mval), {Mj is Mi ** Mval}, mrem(Mj,Ms1), {Rs is Rs1}.

mrem(Mi,Ms) → [], {Ms is Mi}.

mterm(Mval)  -->  [Mval].

%Part III  Parse Tree of Arithmetic Expressions

%Extended: 
    E  ->  E + T  |  E - T
 	E  ->  T
	T → T * F | T / F
	T → F
	F  ->  ( E )
	F  ->  number

exp(E,Op,T) --> exp(E),addsub(O),term(t).
exp(T) --> term(T).

term(T,Op,F) --> term(T),multdiv(O),func(F).
term(F) --> func(F).

addsub((+)) --> [+].
addsub((-)) --> [-].

multdiv((*)) --> [*].
multdiv((/)) --> [/].

func(E) → (exp(E)).
func(Int) --> [Int].



%Part IV   Syntax Tree of Arithmetic Expressions

expr(Es)  -->  term(Tval), { Ri = Tval }, rem(Ri,Rs), { Es is Rs }.

rem(Ri,Rs)  -->  [+], term(Tval), { Rj is Ri + Tval}, rem(Rj,Rs1), { Rs is Rs1}.
rem(Ri,Rs)  -->  [-], term(Tval), { Rj is Ri - Tval }, rem(Rj,Rs1), { Rs is Rs1}.
rem(Ri,Rs)  -->  [], { Rs is Ri }.

term(Tval)  -->  [Tval].

mrem(Mi, Ms) → [*],  mterm(Mval), {Mj is Mi * Mval}, mrem(Mj,Ms1), {Rs is Rs1}.
mrem(Mi, Ms) → [/],  mterm(Mval), {Mj is Mi/ Mval}, mrem(Mj,Ms1), {Rs is Rs1}.
mrem(Mi, Ms) → [^],  mterm(Mval), {Mj is Mi ** Mval}, mrem(Mj,Ms1), {Rs is Rs1}.
mrem(Mi,Ms) → [], {Ms is Mi}.

mterm(Mval)  -->  [Mval].


%Part V   Infix to Postfix Conversion

expr(Es)  -->  term(Tval), { Ri = Tval }, rem(Ri,Rs), { Es is Rs }.

rem(Ri,Rs)  -->  term(Tval), { Rj is Ri + Tval},  [+], rem(Rj,Rs1), { Rs is Rs1}.
rem(Ri,Rs)  -->  term(Tval), { Rj is Ri - Tval },  [-], rem(Rj,Rs1), { Rs is Rs1}.
rem(Ri,Rs)  -->  [], { Rs is Ri }.

term(Tval)  -->  [Tval].

mrem(Mi, Ms) →  mterm(Mval), {Mj is Mi * Mval}, [*], mrem(Mj,Ms1), {Rs is Rs1}.
mrem(Mi, Ms) →  mterm(Mval), {Mj is Mi/ Mval}, [/],  mrem(Mj,Ms1), {Rs is Rs1}.
mrem(Mi, Ms) →  mterm(Mval), {Mj is Mi ** Mval}, [^],  mrem(Mj,Ms1), {Rs is Rs1}.
mrem(Mi,Ms) → [], {Ms is Mi}.

mterm(Mval)  -->  [Mval].