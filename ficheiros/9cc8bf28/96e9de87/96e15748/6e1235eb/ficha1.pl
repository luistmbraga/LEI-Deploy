:- dynamic filho/2.

filho(joao,jose).
filho(jose,manuel).
filho(carlos,jose).

pai(paulo,filipe).
pai(paulo,maria).
pai(ff,jose).

avo(antonio,nadia).


masculino(joao).
masculino(jose).
feminino(maria).
feminino(joana).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pai: Pai,Filho -> {V,F}

pai(P,F) :-
	filho(F,P).

	
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: Avo,Neto -> {V,F}

avo(A,N) :- 
	filho(N,X),
	pai(A,X).
	
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado neto: Neto,Avo -> {V,F}

neto(N,A) :-
	avo(A,N).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: X,Y -> {V,F}

descendente(X,Y) :- 
	filho(X,Y).
descendente(X,Y) :-
	filho(X,Z),
	descendente(Z,Y).
	
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: X,Y -> {V,F}

descendente(X,Y,1) :-
	filho(X,Y).
descendente(X,Y,N) :-
	filho(X,Z),
	descendente(Z,Y,G), N is G+1 .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: A,N -> {V,F}

avo(A,N) :-
	descendente(A,N,2).
	
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisavo: X,Y -> {V,F}
	
bisavo(X,Y) :-
	avo(X,Z),
	pai(Z,Y).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado trisavo: X,Y -> {V,F}

trisavo(X,Y) :-
	bisavo(X,Z),
	pai(Z,Y).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado tetraneto: X,Y -> {V,F}

tetraneto(X,Y) :-
	trisavo(Y,Z),
	pai(Z,X).
	