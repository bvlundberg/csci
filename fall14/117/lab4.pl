% Author: Brandon Lundberg
% File Name: lab4.pl
% Date: 19 Sept 2014

% PART 1

% Delete first occurrence of some element 'X' of a list
firstx(_, [], []).
firstx(X, [X|Xs], Xs).
firstx(X, [X1|Xs], [X1|Ans]) :-
	firstx(X, Xs, Ans).

% Sub all ocurrence of some element 'X' of a list with 'Y'
allX(_, _, [], []).
allX(X, Y,[X|Xs], [Y|Ans]) :-
	allX(X, Y, Xs, Ans).
allX(X, Y,[X1|Xs], [X1|Ans]) :-
	allX(X, Y, Xs, Ans).

% Checks if a list has an odd length
oddX(Xs) :- 
	length(Xs, X), X mod 2 =\= 0.

% Checks to see if a list is a palindrome
reverseXs([], Rs, Rs).
reverseXs([X|Xs], As, Rs) :- 
	reverseXs(Xs, [X|As], Rs).
palindrome(Xs) :-
	reverseXs(Xs, [], Rs), Xs == Rs.

% PART 2

%[1,Y|[X,2|[Y,3|W]]] = [U,3,2|[2,A,3,B,2,U]].
% A = Y = 3,
% U = 1,
% W = [B,2,1],
% X = 2

%[1,Y|[X,2|[X,3|W]]] = [U,3,2|[2,B,U,B,2,U]].
% false
% because U cannot equal 1 and 3

:=