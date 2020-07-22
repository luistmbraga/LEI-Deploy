%------------------------- - --  - - - 

par(0).
par(X) :-
	N is X-2,
	N >= 0,
	par(N).
	
%------------------------- - --  - - - 
impar(1).
impar(X) :-
	N is X-2,
	N >= 1,
	impar(N).

%------------------------- - --  - - - 
nao(X) :-
	X, !, fail.
nao(X).

atravessar(Estrada) :-
	nao(carros).
atravessar(Linha) :-
	- comboio.
%------------------------- - --  - - - 
nodo(a).
nodo(b).
nodo(c).
nodo(d).
nodo(e).
nodo(f).
nodo(g).
arco(b,a).
arco(b,c).
arco(c,a).
arco(c,d).
arco(f,g).

- terminal(X) :-
	arco(X,_),
	nodo(X).
terminal(X) :-
	nao(- terminal(X)).
	
