#include <string.h>
#include <stdio.h>
#include "ficha6.h"

ListAluno initLista(ListAluno l)
{

}

int procuraAluno(ListAluno l, char* nome)
{

}

void consultAluno(ListAluno l, int indice)
{

}

ListAluno insereAluno(ListAluno l, Aluno a)
{

}

void listAluno(ListAluno l)
{

}

ListAluno removeAluno(ListAluno l, char *nome)
{

}

int main()
{
    Aluno a1 = {"Carlos", 17, -1},
	a2 = {"Ana", 19, -1},
	a3 = {"Zulmira", 18, -1},
	a4 = {"Paulo", 18, -1},
	a5 = {"David", 19, -1};
    ListAluno l1;
    int i;
	
    l1 = initLista(l1);
    l1 = insereAluno(l1, a1);
    l1 = insereAluno(l1, a2);
    l1 = insereAluno(l1, a3);
    l1 = insereAluno(l1, a4);
    l1 = insereAluno(l1, a5);
	
    listAluno(l1);
    i = procuraAluno(l1, "Ana");
    consultAluno(l1, i);
	
	return 1;
}