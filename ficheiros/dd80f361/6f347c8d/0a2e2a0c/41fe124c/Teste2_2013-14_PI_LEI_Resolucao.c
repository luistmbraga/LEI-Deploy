#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <ctype.h>

// (1)

typedef struct slist{
	int valor;
	struct slist *prox;
} *LInt;

LInt fromArray (int v[], int N){
	if (!v || N == 0) return NULL;
	
	int i = 0;
	LInt lista, aponta;
	lista = (LInt) malloc (sizeof(LInt));
	aponta = lista;

	while(i < N){
		lista->valor = v[i];
		lista->prox = (LInt) malloc (sizeof(LInt));
		lista = lista->prox;
		i++;
	}
	
	lista = NULL;

	return aponta;
}


// (2)


#define BSize 100

typedef struct larray{
	int valores[BSize];
	struct larray *prox;
} *LArrays;

typedef struct stack{
	int sp;
	LArrays s;
} Stack;


void push (Stack *st, int x){
	
	if((*st)->sp != BSize){
		(*st)->(s.valores[(*st)->sp]) = x;
		((*st)->sp)++ ;
	}
	else {
		LArrays aux;
		aux = (LArrays) malloc(sizeof(LArrays));
		aux->prox = (*st)->s;
		aux->valores[0] = x;
		(*st)->sp = 1;
	}
}

int pop (Stack *st, int *t){
	LArrays aux;
	int i,j,sucesso;
	sucesso = 1; // Não

	for (i=0; i <= ((*st)->sp);i++){

		if ((*st)->valores[i] == &(*t)){
			j=i;

			while(i < BSize){
				(*st)->(s.valores[i]) = (*st)->(s.valores[i+1]);
				i++;
			}
			sucesso = 0; //Sim
			break; // ciclo for
		}
	}

	if ((j == 0) && ((*st)->sp == 1)) {
		aux = (*st)->s->prox;
		free((*st)->s);
		(*st)->s = aux;
		if (((*st)->s) != NULL) {(*st)->sp = BSize;}
		else {sucesso = 1;} // Stack Vazia
	}
	else {((*st)->sp)-- ;}

	return sucesso; // == 0 -> Sucesso! Stack não vazia
}

// (3)


typedef struct spares{
	int x,y;
	struct spares *prox;
} Par, *LPares;

typedef struct slist{
	int valor;
	struct slist *prox;
} Nodo, *LInt;


// Iterativa

LPares zip (LInt a, LInt b, int *c){ // (LInt, LInt) -> LPares
			   // nº de pares na lista de pares
	if (!a || !b) return NULL;

	int i=0;
	LInt aponta_a, aponta_b;
	LPares lista, aponta;

	aponta_a = a;
	aponta_b = b;

	lista = (LInt) malloc(sizeof(Nodo));
	aponta = lista;

	while(a && b){
		
		lista->x = a->valor;
		a = a->prox;
		lista->y = b->valor;
		b = b->prox;
		lista = lista->prox;
		lista = (LInt) malloc(sizeof(Nodo));
		i++;
	}
	
	a = aponta_a;
	b = aponta_b;

	lista->prox = NULL;
	&(*c)=i;

	return aponta;
}

// (4)


typedef struct no{
	
	int value;
	struct no *esq, *dir, *pai;
} No, *Tree;


// a)


void calculaPais (Tree t){
	if (!t) return;
	if (t->dir) {t->dir->pai = t;}
	if (t->esq) {t->esq->pai = t;}
	calcula (t->esq);
	calcula (t->dir);
}

// Esta função é recursiva, logo o nodo do meio (1º nível) não recebe no parâmetro 'pai' um valor (Nem mesmo NULL)


// b)


static int valor_, flag_ = 1;
static Tree aponta;

Tree next (Tree t){
	if (!t) return NULL;

	if(flag) {
	       valor_ = t->value;
	       flag--;
	       aponta = t;
	}

	while (t->value <= valor_)
	{
		next(t->esq);
		next(t->dir);
		next(t->pai);
	}

	if (t->value > valor_)
	{
		Tree result = t;
		t = aponta;
		return result;
	}
}
