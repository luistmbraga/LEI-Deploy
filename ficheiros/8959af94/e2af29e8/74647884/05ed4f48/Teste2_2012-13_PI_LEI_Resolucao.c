#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>

#define N 3

typedef struct lista {
        int valor;
        struct lista *prox;
} Node, *LInt;

int take(int n, LInt *l)
{
    int i;

    for(i = 0; i < n; i++){
        if (*l == NULL)
            return i;
        *l = (*l) -> prox;
    }

    while (*l){
        LInt temp = *l;
        *l = (*l) -> prox;
        free(temp);
    }
     

}

typedef struct abin {
    int valor;
    struct abin *esq, *dir;
} Nodo, *Abin;

int maiores(Abin a, int x)
{
    if (a)
        if (x < a -> valor)
            return maiores(a -> esq, x);
        else
            return 1 + maiores(a -> dir, x);
    else
        return 0;
}

int wc(char *filename)
{
    FILE* file = fopen(filename, "r");
    char line[1000];

    int nl, w, c;
    nl = w = c = 0;
    int i;
    while (fgets(line, sizeof(line), file)){
        nl++;

        if (!isspace(line[0]))
            w++;
        for(i = 0; line[i] != '\0'; i++){
            if (isspace(line[i]) && !isspace(line[i + 1]))
                w++;
        }
        c++;
    }
                
    printf("%d %d %d\n", nl, w, c);

    fclose(file);

    return 0;
}

typedef struct bloco {
    int quantos;
    int valores[N];
    struct bloco *prox;
} Bloco, *LBloco;

int pertence(LBloco l, int x)
{
    int i;
    if (!l){
        for(i = 0; i < l -> quantos; i++)
            if (l -> valores[i] == x)
                return 1;

        l = l -> prox;
    }
    else
        return 0;
}

main(){;}
