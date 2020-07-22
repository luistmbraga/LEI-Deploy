%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- dynamic soma/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,R -> {V,F}

soma(X,Y,R) :-
	R is X+Y .


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado op: X,Y,OP,R -> {V,F}

op(X,Y,+,R) :- R is X+Y .
op(X,Y,-,R) :- R is X-Y .
op(X, Y, * , R) :- R is X * Y .
op(X, Y, / , R) :- R is X / Y .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,Z,R -> {V,F}

soma(X,Y,Z,R) :-
	R is X + Y + Z.
	
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma2: L,R -> {V,F}

soma2([],0).
soma2([X | Rest],R) :-
	soma2(Rest, R2), R is X + R2 .
	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado op_conj: L,OP,R -> {V,F}

	
Construir a extensão de um predicado que aplique uma operação aritmética (adição, subtracção, multiplicacao, divisão) a um conjunto de valores;

op_conj([], + , 0).
op_conj([], - , 0).
op_conj([], * , 1).
op_conj([], / , 1) .
op_conj([X | Rest], OP, R) :-
	op(Rest, OP, R2),
	op(R2, X, OP, R).
	
%/

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maior: X,Y,R -> {V,F}

maior(X,Y,X) :- X > Y .
maior(X,Y,Y) :- Y > X .


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maior2: X,Y,R -> {V,F}

maior2([X],X) .
maior2([X | Y], R) : -
	maior2(Y, R2), maior(X, R2, R) .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado menor: X,Y,R -> {V,F}

menor(X,Y,X) :- X < Y .
menor(X,Y,Y) :- Y < X .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado menor2: X,Y,R -> {V,F}

menor2([X],X).
menor2([X | Y], R) :- 
	menor2(Y, R2), menor(X, R2, R).


