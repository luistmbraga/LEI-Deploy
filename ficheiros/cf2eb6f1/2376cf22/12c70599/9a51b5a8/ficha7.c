#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ficha7.h"

ListaInt insereCabeca(ListaInt l, int n)
{
	ListaInt aux = malloc (sizeof(NListaInt)); 
	aux->valor = n;
	aux->seg = l;
	return aux;
}

void listar(ListaInt l)
{
	while(l)
	{
		printf("%d ",l->valor);
		l = l->seg;
	}
}

void listarInv(ListaInt l)
{
	if(l)
	{
		listarInv(l->seg);
		printf("%d ",l->valor);
	}
}

int *procura(ListaInt l, int n)
{	
	int found = 0;
	while(l && !found)
	{
		if(l->valor == n) found = 1;
		if(!found) l = l->seg;	
	}
	
	if(found) return &(l->valor);
	else return NULL;
}

int nelems(ListaInt l)
{
	if(l) return 1+(nelems(l->seg));
	else return 0;
}

int max(ListaInt l)
{
	int max = l->valor;
	l = l->seg;
	while(l)
	{
		if(l->valor > max) max = l->valor;
		l = l->seg;
	}	
	return max;
}

void mult3()
{
	ListaInt l = malloc (sizeof(NListaInt)); 
	int mult=99;
	while(mult >= 0)
	{
		l = insereCabeca(l,3);
	}
	listar(l);
	listarInv(l);	
}

int main()
{

	return 1;
}