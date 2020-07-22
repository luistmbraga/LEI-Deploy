#ifndef recurso_2014_1025_h
#define recurso_2014_1025_h

#include <stdio.h>
#include <string.h>
#include <stdlib.h>




//PARTE A ------------------------------------------------------------------------------------------

typedef struct slist{
    
    int valor ;
    struct slist *prox;

} *LInt;



//EXE 1) -------------------------------------------------------
int bitsUm (unsigned int n){ 
    
    int r, count = 1;
    
    while (n != 1){
        
        r = n % 2; 
        if (r == 1) count++;
        n /= 2;
    }
    
    return count;
}





//EXE 2) -------------------------------------------------------
int limpaEspacos(char t[]){
    
    int i, k, w;
    
    for (i = 0; t[i]; i++)
        if (t[i] == ' ')
            for(k = i + 1; t[k] == t[i]; )
                for (w = k; t[w]; w++)
                    t[w] = t[w + 1];
    return i;
}



//EXE 3) -------------------------------------------------------
int aux_dumpL (LInt l, int v[], int N, int i){ //FUNÇÃO RECURSIVA
    
    if (!N || !l) return 0;
    
    v[i] = l->valor;
    
    i++; N--;
    
    return 1 + aux_dumpL(l->prox, v, N, i);
}

int dumpL (LInt l, int v[], int N){

    return aux_dumpL(l, v, N, 0);
}




//EXE 4) -------------------------------------------------------
LInt parte (LInt l){
    
    /* 
       deve haver melhor resolução, esta pode não ser a mais eficiente,
       mas, na minha cabeça, é a mais legivel:
     
       o algoritmo é simples cria-se dois pontos de partida para cada lista, 
       a lista par e a lista impar, e depois é só acrescentar cada elemento
       a lista certa.
     */
    
    LInt temp, impar, par, inicio_par, inicio_impar;
    int i = 1;
    
    impar = malloc(sizeof(struct slist)); //aqui são criados os dois pontos de partida
    par = malloc(sizeof(struct slist));
    
    inicio_par = par; //guarda-se o inicio de cada lista
    inicio_impar = impar;
    
    while (l){
        if (i % 2 == 0){ //par
            par->prox = l;
            par = par->prox;
        }
        else{ //impar
            impar->prox = l;
            impar = impar->prox;
        }
        i++;
        l = l->prox;
    }
    
    par->prox = impar->prox = NULL; //termina-se as duas listas
    
    temp = inicio_impar; //faz-se o free de cada ponto de partida
    free(inicio_impar);
    l = temp->prox; //a lista l aponta para a lista dos impares
    
    temp = inicio_par;
    free(inicio_par);
    
    return temp->prox;
    
    /* nota: eu faço temp->prox, pq o incio_par e o inicio_impar apenas serve para ponto
             de partida de cada lista, mas na realidade os elementos são acrescentados 
             sempre a frente desse ponto de partida
    */
}


/* ALTERNATIVA:

LInt parte (LInt l){
	LInt next=NULL,start =NULL;
	while (l && l->prox){
		next=l->prox;
		if (start==NULL)
			start=next;
			l->prox=next->prox;
			l=next;
	}
	return start;
}

*/







//PARTE B ------------------------------------------------------------------------------------------

typedef struct nodo{
    
    char nome[50];
    int numero;
    int nota;
    struct nodo *esq, *dir;

} *Alunos;


typedef struct strlist{
    
    char *string;
    struct strlist *prox;

} *StrList;




//EXE 1) -------------------------------------------------------
int fnotas(Alunos a, int notas[21]){
    
    if (!a) return 0;
    
    notas[a->nota]++;
    
    return 1 + fnotas(a->esq, notas) + fnotas(a->dir, notas);
}






//EXE 2) -------------------------------------------------------
int rankNota(int nota, int fnotas[21]){
    
    int freqs = 1, i, v = 1;
    
    for (i = 0; i < 21; i++) //determina o número de notas (nao conta repetidas)
        if (fnotas[i]) freqs++;
    
    for (i = 0; i < 21 && i != nota; i++)
        if (fnotas[i]) v++;
    
    return freqs - v;
}


int rankAluno(Alunos a, int numero, int fnotas[21]){
    
    while (a){
        
        if (numero < a->numero) a = a->esq;
        else if (numero == a->numero) return rankNota(a->nota, fnotas);
        else a = a->dir;
    }
    
    return -1; //erro: pq o numero nao existe na turma
}






//EXE 3) -------------------------------------------------------
int aux_comNota(Alunos a, int nota, StrList l){
    
    if (!a) return 0;
    
    if (a->nota != nota) return aux_comNota(a->esq, nota, l) + aux_comNota(a->dir, nota, l);
    
    StrList r = malloc(sizeof(struct strlist));
    r->string = a->nome;
    r->prox = NULL;
    l->prox = r;
    
    return 1 + aux_comNota(a->esq, nota, r) + aux_comNota(a->dir, nota, r);
}


int comNota(Alunos a, int nota, StrList *l){

    
    int r = aux_comNota(a, nota, *l);
    
    (*l) = (*l)->prox;
    
    return r;
}





//EXE 4) -------------------------------------------------------
void update_array(Alunos a, Alunos t[], int v, int nota){ //função recursiva
    
    int i;
    
    if (a == NULL) return;
        
    if (a->nota == nota){
        
        for(i = 0; i < v; i++) //este ciclo serve para o caso de haver notas iguais não imprimir o mesmo aluno
            if (strcmp(t[i]->nome, a->nome) == 0) return;
        
        t[v] = a;
    }
        
    update_array(a->dir, t, v, nota);
    update_array(a->esq, t, v, nota);
}



void preenche(Alunos a, Alunos t[], int freq[21]){
    
    int i;
    int no; //numero de ocorrencias daquela nota
    int v = 0; //usado no array t[]
    
    for (i = 20; i >= 0; i--){ //percorre o array freq de forma decrescente
        no = freq[i];
        while (no){
            update_array(a, t, v, i);
            no--;
            v++;
        }
    }
}


void imprime (Alunos a){
    
    int i;
    int notas[21] = {0};
    int quantos = fnotas(a, notas);
    Alunos todos[quantos];
    
    preenche(a, todos, notas);
    
    for (i = 0; i < quantos; i++){
        printf("%d %s %d\n", todos[i]->numero, todos[i]->nome, todos[i]->nota);
    }
}



/* VERSAO ALTERNATIVA DO ULTIMO EXERCICIO:

void somasAcumuladasRev(int freq[]){
	int acum=0, i;
	for(i=20; i>=0; --i){
		freq[i]+=acum;
		acum = freq[i];
	}
}

void prencheAux(Alunos a,Alunos t[],int freq[21]){
	int l;
	if(a){
		l=freq[(a->nota)];
		t[l-1]=a;
		--freq[a->nota];
		prencheAux(a->esq,t,freq);
		prencheAux(a->dir,t,freq);
		} 
}

void preenche(Alunos a, Alunos t[], int freq[21]){
	somasAcumuladasRev(freq);
	prencheAux(a,t,freq);
}

*/


//FUNÇÕES USADAS PARA TESTES:
void print_array(int array[], int n){
    
    int i;
    
    for (i = 0; i < n; i++)
        printf("%d ", array[i]);
    
    putchar('\n');
    
}


void print_StrLit(StrList l){ 
    
    while (l){
        printf("%s\n", l->string);
        l = l->prox;
    }
    
    putchar ('\n');
}







void main_void(void){
    
    
    //PARTE A ------------------------------------------------------------------------------------------
    
    //TESTE DO EXE 1)
    //link codeboard ----> https://codeboard.io/projects/13548
    
    //TESTE DO EXE 2)
    //link codeboard ----> https://codeboard.io/projects/13733
    
    //TESTE DO EXE 3)
    //link codeboard ----> https://codeboard.io/projects/16261
    
    //TESTE DO EXE 4)
    //link codeboard ----> https://codeboard.io/projects/16266
    

    
    //PARTE B ------------------------------------------------------------------------------------------
    
    //ARVORE BINARIA DE TESTE:
    Alunos x = (Alunos) malloc(sizeof(struct nodo));
    Alunos y = (Alunos) malloc(sizeof(struct nodo));
    Alunos z = (Alunos) malloc(sizeof(struct nodo));
    Alunos w = (Alunos) malloc(sizeof(struct nodo));
    Alunos v = (Alunos) malloc(sizeof(struct nodo));
    Alunos j = (Alunos) malloc(sizeof(struct nodo));
    
    
    /*
                         _______ x(11) _______
                        /                     \
                       /                       \
                    y(3)                       z(12)
                   /    \                     /     \
                  /      \                   /       \
              NULL        j(6)           NULL         w(14)
                         /    \                      /     \
                        /      \                    /       \
                    NULL        NULL            v(13)        NULL
                                               /     \
                                              /       \
                                          NULL         NULL
    */
    
    strcpy(x->nome, "x");
    x->numero = 11;
    x->nota = 3;
    x->esq = y;
    x->dir = z;
    
    strcpy(y->nome, "y");
    y->numero = 3;
    y->nota = 12;
    y->esq = NULL;
    y->dir = j;
    
    strcpy(z->nome, "z");
    z->numero = 12;
    z->nota = 6;
    z->esq = NULL;
    z->dir = w;
    
    strcpy(w->nome, "w");
    w->numero = 14;
    w->nota = 3;
    w->esq = v;
    w->dir = NULL;
    
    strcpy(v->nome, "v");
    v->numero = 13;
    v->nota = 16;
    v->esq = NULL;
    v->dir = NULL;
    
    strcpy(j->nome, "j");
    j->numero = 6;
    j->nota = 18;
    j->esq = NULL;
    j->dir = NULL;
    
    Alunos *turma = &x;
    
    //TESTE DO EXE 1)
    
    int notas[21] = {0};
    printf("O número de alunos é: %d\n", fnotas(*turma, notas));
    print_array(notas, 21);
    puts("\n");
    
    
    
    //TESTE DO EXE 2)
    
    printf("rank -> %d\n", rankAluno(*turma, 12, notas));
    puts("\n");
    
    
    
    //TESTE DO EXE 3)
    StrList a = malloc(sizeof(struct strlist)); //isto serve so para criar um apontador
    StrList *lista = &a;
    
    printf("%d\n", comNota(*turma, 3, lista));
    print_StrLit((*lista));
    
    
    //TESTE DO EXE 4)
    
    imprime(*turma);
    puts("\n");
    
}

#endif /* recurso_2014_1025_h */
