#ifndef recurso_2015_2016_h
#define recurso_2015_2016_h

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

//PARTE A ------------------------------------------------------------------------------------------

typedef struct nodo {
    
    int valor;
    struct nodo *esq, *dir;
    
} *ABin;



//EXE 1)------------------------------------------------------------
char *mystrcpy(char *dest, char source[]){
    
    int i;
    
    for (i = 0; source[i]; i++)
        dest[i] = source[i];
    
    dest[i] = '\0';
    
    return dest;
}




//EXE 2)------------------------------------------------------------
void strnoV (char s[]){
    
    int i, k;
    
    for(i = 0; s[i]; i++)
        if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u' || s[i] == 'A' || s[i] == 'E' || s[i] == 'I' || s[i] == 'O' || s[i] == 'U'){
            for (k = i; s[k]; k++)
                s[k] = s[k + 1];
            i--; //a dimensão da string é decrementada
        }
}




//EXE 3)------------------------------------------------------------
int dumpAbin (ABin a, int v[], int N) {
    
    int t = 0;
    
    if (a && t < N){
        
        t = dumpAbin(a->dir, v, N);
        
        if(t < N){
            v[t] = a->valor;
            t++;
        }
        
        t += dumpAbin(a->esq, v + t, N - t);
    }
    
    return t;
}



//EXE 4)------------------------------------------------------------
int max(int a, int b){
    
    if (a >= b) return a;
    else return b;
    
}

//versao recursiva, NÃO É A VERSAO PEDIDA pq percorre a árvore TODA desnecessariamente!
int lookupAB_R(ABin a, int x){
    
    if (a == NULL) return 0;
    
    if (a->valor == x) return 1;
    
    return max(lookupAB_R(a->dir, x), lookupAB_R(a->esq, x));
}


//versao imperativa, melhor neste caso!
int lookupAB(ABin a, int x){

    while (a){
        if (x < a->valor) a = a->esq;
        else if (x == a->valor) return 1; //foi encontrado o elemento
        else a = a->dir;
    }
    
    return 0; //se chegar aqui é pq nao encontrou o elemento
}









//PARTE B ------------------------------------------------------------------------------------------

typedef struct listaP{
    
    char *pal;
    int cont;
    struct listaP *prox;
    
} Nodo, *Hist;


//EXE 1)------------------------------------------------------------
int inc(Hist *h, char *pal){
    
    Hist anterior = NULL, l = *h;
    
    while (l && strcmp(l->pal, pal) < 0){
        anterior = l;
        l = l->prox;
    }
    
    if (l && strcmp(l->pal, pal) == 0){ //significa que a palavra já existia no dicionário (basta incrementar o nº de ocorrências
        l->cont++;
        return l->cont;
    }
    
    Hist nova = malloc(sizeof(Nodo));
    nova->pal = pal;
    nova->cont = 1;
    nova->prox = l;
    
    if (!anterior) *h = nova; //este caso serve para quando a lista é vazia ou é para colocar o elemento á cabeça da lista
    
    else anterior->prox = nova;
    
    return nova->cont;
}






//EXE 2)------------------------------------------------------------
char *remMaisFreq(Hist *h, int *count){
    
    /* o algoritmo é simples: guarda-se o anterior ao maior elemento, guarda-se o proximo ao maior
     elemento, e no fim basta conectar o anterior ao proximo */
    
    char *temp;
    Hist l = *h;
    Hist anterior = NULL, max_ant, max = l, max_prox;
    
    while (l){
        
        if (l->cont >= max->cont){
            
            max_ant = anterior;
            max = l; //o maior elemento passa a ser o atual
            max_prox = l->prox;
        }
        
        anterior = l; //o anterior passa a ser o atual
        l = l->prox;
    }
    
    *count = max->cont;

    if (!max_ant) *h = (*h)->prox; //significa que o maior elemento está á cabeça da lista
    else max_ant->prox = max_prox;
    
    temp = max->pal;
    free(max);
    
    return temp;
}


//EXE 3) NÃO SAI...




//FUNÇÕES USADAS PARA TESTES:
void print_histograma(Hist h){ 
    
    while(h){
        printf("%s -> %d\n", h->pal, h->cont);
        h = h->prox;
    }
    
    putchar('\n');
}





void main_void(void){
    
    
    //PARTE A ------------------------------------------------------------------------------------------
    
    //TESTE DO EXE 1)
    //link codeboard ----> https://codeboard.io/projects/14491
    
    //TESTE DO EXE 2)
    //link codeboard ----> https://codeboard.io/projects/13661
    
    //TESTE DO EXE 3)
    //link codeboard ----> https://codeboard.io/projects/16279
    
    //TESTE DO EXE 4)
    //link codeboard ----> https://codeboard.io/projects/16284
    
    
    
    //PARTE B ------------------------------------------------------------------------------------------
    
    //DICIONARIO DE TESTE
    
    Hist A = malloc(sizeof(Nodo));
    Hist B = malloc(sizeof(Nodo));
    Hist C = malloc(sizeof(Nodo));
    
    char pal_A[] = "head";
    char pal_B[] = "house";
    char pal_C[] = "programming";
    
    A->pal = pal_A;
    A->cont = 2;
    A->prox = B;
    
    B->pal = pal_B;
    B->cont = 5;
    B->prox = C;
    
    C->pal = pal_C;
    C->cont = 3;
    C->prox = NULL;
    
    Hist *hist = &A;
    
    
    //TESTE DO EXE 1)
    
    print_histograma(*hist); //histograma inicial
    
    char nova[] = "pointer";
    printf("new word appears: %d time(s)!\n\n", inc(hist, nova));
    
    print_histograma(*hist); //histograma modificado
    
    
    
    
    //TESTE DO EXE 2)
    
    int count;
    printf("most common word is: %s appears %d time(s)!\n\n", remMaisFreq(hist, &count), count);
    
    print_histograma(*hist);  //histograma modificado

}




#endif /* recurso_2015_2016_h */
