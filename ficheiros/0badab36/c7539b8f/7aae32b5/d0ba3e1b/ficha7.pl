
- jogo(N,A,V) :-
	nao(jogo(N,A,V)),
	nao(excepcao(jogo(N,A,V))).
	
%- ------------------- - - - 
jogo(1, AA, 500).
%- ------------------- - - - 
jogo(2,BB, desc).

excepcao(jogo(N,A,V)) :-
	jogo(N,A,desc).
%- ------------------- - - - 
excepcao(jogo(3,CC,550)).
excepcao(jogo(3,CC,2500)).
%- ------------------- - - - 
jogo(4,DD,desc).
excepcao(jogo(N,A,V)):-
	V >=250,
	V <= 750.
%- ------------------- - - - 
jogo(5,EE,valor).
excepcao(jogo(N,A,V)):-
	jogo(N,A,valor).
	
nulo(valor).

	
%- ------------------- - - - 
jogo(6,FF, valor).

excepcao(jogo(J,A,V)):-
	jogo(6,FF,250),
	valor >= 5000.
	
%- ------------------- - - - 

%- ------------------- - - - 
