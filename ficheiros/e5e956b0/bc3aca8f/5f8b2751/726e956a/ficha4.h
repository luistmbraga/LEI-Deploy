#ifndef _FICHA4_
#define _FICHA4_

#define MAXNOME 100
#define MAXALUNOS 50
#define MAXNOTAS 10

typedef struct sAluno
{
	char numero[8];
	char nome[MAXNOME];
	int notas[MAXNOTAS];
} Aluno;

typedef struct sTurma
{
	int numalunos;
	Aluno alunos[MAXALUNOS];
} Turma;

#endif