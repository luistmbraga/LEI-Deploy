%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operacoes aritmeticas e conjuntos (listas).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,Soma -> {V,F}

soma( X,Y,Soma ) :- 
    Soma is X+Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,Z,Soma -> {V,F}

soma( X,Y,Z,Soma ) :- 
    Soma is X+Y+Z.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado operacao: Op,X,Y,Resultado -> {V,F}

operacao( adicao,X,Y,Adicao ) :- 
    Adicao is X+Y.
operacao( subtraccao,X,Y,Subtraccao ) :- 
    Subtraccao is X-Y.
operacao( multiplicacao,X,Y,Multiplicacao ) :- 
    Multiplicacao is X*Y.
operacao( divisao,X,Y,Divisao ) :- 
	Y \= 0,
    Divisao is X/Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado somatorio: Conjunto,Somatorio -> {V,F}

somatorio( [],0 ).
somatorio( [X|L],Soma ) :-
    somatorio( L,S ),
	Soma is X+S.
