%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Calculo do maior de 2 numeros.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maior: X,Y,R -> {V,F}

maior1(X,Y,X) :-
    X > Y.
maior1(X,Y,Y).

maior2(X,Y,X) :-
    X > Y,!.
maior2(X,Y,Y).

maior3(X,Y,X) :-
    X > Y.
maior3(X,Y,Y) :-
   X =< Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Calculo do maior de N numeros.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maior: X,Y,R -> {V,F}

maior( [X],X ).
maior( [X|Y],N ) :-
    maior( Y,Z ),
	maior3( X,Z,N ).
