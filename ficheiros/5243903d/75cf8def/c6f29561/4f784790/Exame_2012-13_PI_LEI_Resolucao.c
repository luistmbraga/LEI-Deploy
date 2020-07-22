#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <ctype.h>

// (1)

int elimRep (int v[], int n){
	int j, i=0;

	while(i < N){
		j = i+1;

		while(j < N){
			if ((j == (N-1)) && (v[j] == v[i])){
				v[j] = '\0';
				n--;
				}
				else if (v[j] == v[i]){
					v[j] = v[j+1];
					n--;
				}
			j++;
		}
		i++;
	}

return n;
}


// (2)


typedef struct llint {
	int valor;
	struct llint *prox;
} NodoL, *LLint;


int maximo (LLint l){
	int i;
	LLint inicio;
	i = l->valor;
	inicio = l;

	while (l->prox){
		l=l->prox;
		if (l->valor > i) i = l->valor;
	}

	l=inicio;
	return i;
}

// (3)

typedef struct abint{
	int valor;
	struct abint *prox;
} NodoA, *ABint;


int iguais (ABint a, ABint b){

	int i;
	if (a == b == NULL) return 0;
	else if ((a != NULL) && (b != NULL) && (a->valor == b->valor)){
		i = iguais (a->esq, b->esq);
		if (i == 0) { i = iguais (a->dir, b->dir);}
		else { return i;} // i = 1 -> DIFERENTES
		}
             else { i = 1;}

	return i; // i = 0 -> IGUAIS
}


// (4)

int cp (char *origem, char *destino){

	char ch;

	if (!origem) return 1;
	else {
		fopen (origem, "r");
		fopen (destino, "w");
		while( ( ch = fgetc(origem) ) != EOF ) {
		
			fputc(ch, destino);
		}

		fclose(destino);
		fclose (origem);
		return 0;
	}
}


// (5)


void capitaliza (char s[]){

	// A -> 65 , a -> 97
	// Z -> 90, z-> 122
	// .:. diferença = 32
	
	int i,j;
	for (i=0; s[i] != '\0'; i++)
		if (s[i] == '.') {
			while (isspace (s[i+1])) i++;
			i++;
			j = s[i];
			
			if ( 96 < j < 123) toupper(s[i]); // <ctype.h>
		}
}


// (6)


typedef struct lllint {
	LLint lista; // Exercício (2)
	struct lllint *prox;
} NodoLL, *LLLint;


LLint concat (LLLint l) {
	
	if (!l) return NULL;
	else {
		LLLint iniciol;
		LLint novo1, prox1, prox_l;

		novo1 = (LLint) malloc (sizeof(NodoL));
		novo1->valor = l->lista->valor;
		novo1->prox = prox1;

		inicio = l;
		prox_l = l->lista->prox;
		
		l = l->prox;

		while (l != NULL){
			while (l->lista != NULL) {
				prox1 = (LLint) malloc (sizeof(NodoL));
				prox1 = l->lista->valor;
				
				l->lista = l->lista->prox;
				prox1->prox = (LLint) malloc (sizeof(NodoL));
				prox1 = prox1->prox;
			}

			l = l->prox;
		}

		prox1 = NULL;

		l = inicio;
		l->lista = prox_l;

		return novo;
	}
}


// (7)


typedef struct abint {
	int valor;
	struct abint *esq, *dir;
} Nodo, *ABint;


static int flag1 = 1;
static LLint aponta, novo, prox1;

LLint nivel (Abint a, int n) {

	if (!a) return NULL;
	else {
		int flag = 0, i = 0;
		prox1 = (LLint) malloc(sizeof(NodoL));

		if (n == 1) {

			novo = malloc(sizeof(NodoL));
			novo->valor = a->valor;
			if(flag1) {aponta = novo; flag1--;}
			return novo;
		}
		else {

		while (n > i) {

			prox1 = nivel (a->esq, n--);
			if (prox1) {prox1->prox = nivel (a->dir, n--);}
			else if (nivel (a->dir, n--))
					{
					prox1 = nivel (a->dir, n--);
					}
				else { free (prox1); flag = 1;}

			if (!flag) { novo->prox = (LLint) malloc(sizeof(NodoL)); novo->prox = prox1; novo = novo->prox;}
				}
			}
		}
return aponta;
}


// (8)


/*
 * Construir int a[(2*n)/3] contendo todos os números primos até 'n'
 * Usar uma variável 'i' à medida que avançamos na lista
 * Dividir esses números primos (começando no fim da lista, ou seja, 'i') sob 'n'
 * A divisão que der resto '0' é com o número primo mais alto
 *
 * Usei 66% pois existem 168 nºs primos até ao número 1000 (redondância)
 */
