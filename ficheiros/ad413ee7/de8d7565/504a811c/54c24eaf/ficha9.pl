%- ------------------- - - - 
agente(ave,[cobertura(penas),movimento(voo)]).
agente(canario,[som(chilro),cor(amarelo)]).
agente(boby,[cor(branco),cor(preto)]).
agente(lulu,[cobertura(pelos),comida(tremocos)]).
agente(papagaio,[comida(pao),som(fala),cor(verde),cor(vermelho)]).

%- ------------------- - - - 
e_um(lulu,papagaio).
e_um(papagaio,ave).
e_um(boby,canario).
e_um(canario,ave).

%- ------------------- - - - 
demo(Agente,Questao) :-
	e_um(Agente,Entidade),
	demo(Entidade,Teoria).

prova(Q,[Q|L]).
prova(Q,[X|Teoria]):-
	prova(Q,Teoria).
	


%- ------------------- - - - 

