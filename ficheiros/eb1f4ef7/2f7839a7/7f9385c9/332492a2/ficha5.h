#ifndef _FICHA5_
#define _FICHA5_

typedef struct sPonto
{
	float x;
	float y;
} Ponto;

typedef struct sRectangulo
{
	Ponto p1;
	Ponto p2;
} Rectangulo;


typedef int Golos;
typedef char Equipa[30];

typedef struct sInterv
{
	Equipa e;
	Golos g;
} Interv;

typedef struct sJogo
{
	Interv i1;
	Interv i2;
} Jogo;

typedef Jogo Jornada[20];

typedef struct sTermo
{
	float coef;
	int exp;
} Termo;

typedef struct sPolinomio
{
	Termo pol[50];
} Polinomio;

#endif