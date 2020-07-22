#ifndef recurso_2013_2014_h
#define recurso_2013_2014_h

#include <stdio.h>
#include <string.h>
#include <stdlib.h>


//EXE 1) -------------------------------------------------------

//a)
int palindrome(char s[]){
    
    int i, dim = strlen(s);
    
    for (i = 0; i < dim / 2; i++)
        if (s[i] != s[dim -1 -i]) return 0;
    
    return 1;
}

//b)
char *strlchr(char *s, char c){
    
    int i;
    char *pos = NULL;
    
    for (i = 0; s[i]; i++)
        if (s[i] == c) pos = s + i;
    
    return pos;
}


/* ALTERNATIVA AO EXERCICIO 1-b) -------------------------------
 
char *strlchr(char *s, char c){

	int i = strlen(s) -1;
	char *pos = NULL;

	while(i>=0 && s[i] != c){
		i--;
	}

	if(s[i] == c) pos = &s[i];

	return pos;
}

*/


//EXE 2) -------------------------------------------------------

void ordena (int nums[], int notas[], int n){
    
    int i, k, max, temp, pos_max = 0;
    
    for (i = 0; i < n; i++){
        
        max = notas[i];
        
        //neste ciclo encontra-se o maior elemento do array notas e a sua posição no array
        for (k = i; k < n; k++)
            if (notas[k] >= max){
                max = notas[k];
                pos_max = k;
            }
        
        //estas duas linhas ajustam o array notas (colocam o maior elemento no sitio certo)
        notas[pos_max] = notas[i];
        notas[i] = max;
        
        //simultaneamente estas duas linhas ajustam o array nums
        temp = nums[pos_max];
        nums[pos_max] = nums[i];
        nums[i] = temp;
    }
}





//EXE 3) -------------------------------------------------------

typedef struct slist{
    
    int valor;
    struct slist *prox;
    
} *LInt;


//a)
int dumpL(LInt l, int v[], int N){
    
    int count = 0, i = 0;
    
    while (l && N){
        v[i] = l->valor;
        l = l->prox;
        N--;
        count++;
        i++;
    }
    
    return count;
}



//b)
LInt aux_somas(LInt l, int count){ //função recursiva
    
    LInt r;
    
    if (l){
        count += l->valor;
        r = malloc(sizeof(struct slist));
        r->valor = count;
        r->prox = aux_somas(l->prox, count);
    }
    
    else r = NULL;
    
    return r;
}

LInt somas(LInt l){
    
    return aux_somas(l, 0);
}



//c)
void remreps(LInt l){ //nota: a lista passada como argumento esta ordenada
    
    LInt temp, anterior = l;
    
    if (!l) return; //caso a lista seja vazia nao se faz nada
    
    l = l->prox; //esta linha faz com que exista sempre um nodo anterior guardado
    
    while (l){
        
        temp = l; //caso se faça o free necessita-se de guardar o l
        
        if (l->valor == anterior->valor){
            anterior->prox = l->prox;
            free(l);
        }
        
        else anterior = temp;
        
        l = temp->prox;
    }
}




//EXE 4) -------------------------------------------------------

typedef struct sbin{
    
    int valor;
    struct sbin *esq, *dir;
    
} *Abin;


int contaFolhas (Abin a){
    
    if (!a) return 0;
    
    if (!a->esq && !a->dir) return 1;
    else return contaFolhas(a->esq) + contaFolhas(a->dir);
}






//EXE 5) -------------------------------------------------------

#define N       5 //tamanho da matriz quadrada

int validSol(int board[N][N]){
    
    int c, l;
    int ck, lk;
    
    for (l = 0; l < N; l++)
        for (c = 0; c < N; c++)
            if (board[c][l] == 1) //so vai testar caso esteja aqui uma rainha...
                for (lk = 0; lk < N; lk++)
                    for (ck = 0; ck < N; ck++)
                        if (c != ck && l != lk) //nao vai testar na mesma posição que a rainha inicial...
                            if (c == ck || l == lk || c + l == ck + lk || c - l == ck - lk) //casos de teste
                                if (board[ck][lk] == 1) return 0; //caso um dos testes se verifique e está uma rainha nessa posição entao NAO e valida
    
    return 1;
}








//FUNÇÕES USADAS PARA TESTES:
void print_array(int array[], int n){ //para testar o exe 2) e 3)
    
    int i;
    
    for (i = 0; i < n; i++)
        printf("%d ", array[i]);
    
    putchar('\n');
    
}


void print_linked_list(LInt l){ //para testar exe 3)
    
    while (l){
        printf("%d ", l->valor);
        l = l->prox;
    }
    
    putchar ('\n');
}




void main_void(void){
    
    //TESTE DO EXE 1) -----------------------------------------------

    //a) link codeboard ----> https://codeboard.io/projects/14587
    
    //b)
    char pal[] = "sugus";
    printf("%p\n", strlchr(pal, 'u')); //nota: %p serve para imprimir um endereço de memória
    
    puts("\n");
    
    
    
    
    //TESTE DO EXE 2) -----------------------------------------------

    int notas[] = {10, 14, 11, 12};
    int nums[] = {1024, 3096, 5087, 6178};
    
    print_array(notas, 4); //array notas inicial
    print_array(nums, 4); //array nums inicial
    
    ordena(nums, notas, 4);
    
    print_array(notas, 4); //array notas modificado
    print_array(nums, 4); //array nums modificado
    
    puts("\n");
    
    
    
    //TESTE DO EXE 3) -----------------------------------------------
    
    LInt a = (LInt) malloc(sizeof(struct slist));
    LInt b = (LInt) malloc(sizeof(struct slist));
    LInt c = (LInt) malloc(sizeof(struct slist));
    LInt d = (LInt) malloc(sizeof(struct slist));
    LInt e = (LInt) malloc(sizeof(struct slist));
    
    a->valor = 1;
    a->prox = b;
    
    b->valor = 2;
    b->prox = c;
    
    c->valor = 2;
    c->prox = d;
    
    d->valor = 2;
    d->prox = e;
    
    e->valor = 4;
    e->prox = NULL;
    
    LInt *list = &a;
    
    //a)
    int v[3];
    dumpL(*list, v, 3);
    print_array(v, 3);
    
    //b)
    print_linked_list(somas(*list));
    
    //c)
    remreps(*list);
    print_linked_list(*list);
    
    puts("\n");
    
    
    
    
    //TESTE DO EXE 4) -----------------------------------------------
    //link codeboard ----> https://codeboard.io/projects/16281
    

    
    
    //TESTE DO EXE 5) -----------------------------------------------
    
    int board_1[N][N] = {
        { 1, 0, 0, 0, 0},
        { 0, 0, 1, 0, 0},
        { 0, 0, 0, 0, 1},
        { 0, 1, 0, 0, 0},
        { 0, 0, 0, 1, 0},
    };
    
    int board_2[N][N] = {
        { 1, 0, 0, 0, 0},
        { 0, 0, 0, 0, 0},
        { 0, 0, 1, 0, 0},
        { 0, 0, 0, 0, 0},
        { 0, 0, 0, 0, 0},
    };
    
    printf("%d\n", validSol(board_1)); //tem de dar 1 pois é válida
    printf("%d\n", validSol(board_2)); //tem de dar 0 pois NÃO é válida

}




#endif /* recurso_2013_2014_h */
