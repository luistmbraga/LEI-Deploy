%ii

nao(X) :-
	X, !, fail.
nao(X).

%iii

pertence(X, [X | _]).
pertence(X, [Y | L]) :-
	X \= Y,
	pertence(X,L).

%iv

comprimento([],0).
comprimento([X | Y], R) :- comprimento(Y, R2),
							R is 1+R2 .

%v
%-nao ta direito

quantos([],0).
quantos([X | Y], R) :-
	pertence(X,Y),
	quantos(T,R).

quantos([X | Y], R) :-
	quantos(T,R1),
	R is 1+R1.
	
%----------------------------- - - - - 
apagar(X, [X | T],[T]).
apagar(X, [Y | T], [Y | R]) :-
	apagar(X, T, R).
	
apagartudo(_,[],[]).
apagartudo(X, [X | Y], R) :-
	apagartudo(X, Y, R).
apagartudo(X, [Z | Y], [Z | R]) :-
	apagartudo(X, Y, Z).

%----------------------------- -- - - - 
adicionar(X,[],[X|[]]).
adicionar(X,[X|L],[X|L]).
adicionar(X, [Y|L],[Y|R]) :-
	adicionar(X,L,R).

%-------------------------- - - - - 
concat([],L,L).
concat([H|T],L1,[H|R]) :-
concat(T,L1,R).

%-------------------------- - - - - 
inverter([],[]).
inverter([H|T],R) :-
	inverter(T,Z),
	concat(Z,[H],R).

	
%-------------------------- - - - - 
