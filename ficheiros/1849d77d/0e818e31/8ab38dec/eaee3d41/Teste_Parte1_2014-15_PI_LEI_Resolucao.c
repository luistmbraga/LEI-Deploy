#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include <string.h>

/* Tomé Azevedo*/

/*Exercicio 1

int main(){
    int n=1,soma=0;
    while (n!=0){
        printf("Introduza um numero (0 para parar): ");
        scanf ("%d",&n);
        soma+=n;
    }
    printf ("Soma: %d\n",soma);
    return 0;
}
*/

/* Exercicio 2

int main(){
    int n=1, maior=INT_MIN;
    while (n!=0){
        printf ("Introduza um numero (0 para parar): ");
        scanf ("%d",&n);
        if (n>maior)
            maior=n;
    }
    printf ("Maior: %d\n",maior);
    return 0;
}
*/

/* Exercicio 3

int main(){
    int n=1;
    float media, soma=0, c=0;
    while (n!=0){
        printf("Introduza um numero (0 para parar): ");
        scanf ("%d",&n);
        soma+=n;
        c++;
    }
    media = soma / (c-1); 
    printf ("Media: %0.2f\n",media);
    return 0;
}
*/

/* Exercicio 4

int main(){
    int maior=INT_MIN, smaior=INT_MIN, n=1;
    while (n!=0){
        printf("Introduza um numero (0 para parar): ");
        scanf("%d",&n);
        if (n>maior){
            smaior = maior;
            maior = n;
        }
        else if (n>smaior)
            smaior = n;
    }
    printf ("Maior: %d\n", maior);
    printf ("Segundo maior: %d\n", smaior);
    return 0;
}
*/

/* Exercicio 5
int bitsUm (unsigned int n){
    int c=0;
    while (n>0){
        if (n%2 !=0){
            n=n/2;
            c++;
        }
        else
            n=n/2; 
    }
    return c;
}

int main (){
    int n;
    printf("Introduza um numero: ");
    scanf("%d",&n);
    printf ("Numero iguais a 1: %d",bitsUm (n));
}
*/

/*Exercicio 6
int trailingZ (unsigned int n){
    int res=0;
    while(n!=0 && (n%2)==0){
        res++;
        n/=2;
    }
    return res;
}

int main (){
    int n;
    printf("Introduza um numero: ");
    scanf("%d",&n);
    printf ("Zeros no final: %d",trailingZ (n));
}
*/


/*
int qDig (unsigned int n) {
    int c=1, absn=abs(n);
    while (absn>0){
        if ((absn/10) > 0){
            absn/=10;
            c++;
        }
        else
            break;
    }
    return c;
}

int main(){
    int n;
    printf("Indroduza um numero: ");
    scanf("%d",&n);
    printf("Sao precisos %d digitos para escrever o numero %d\n",qDig(n),n);
    return 0;
}
*/

/* Exercicio 8

int factorial (int n){
    int c, resultado=1;
    for (c=1; c<=n; c++){
        resultado *= c;
    }
    return resultado;
}

int fact2 (int n){
    int f;
    f = factorial (n);
    printf("Factorial: %d\n", f);
    return (f%100);
}

int main(){
    int n;
    printf("Introduza um numero: ");
    scanf("%d",&n);
    printf("Os ultimos 2 digitos do factorial de %d sao %d\n",n,fact2(n));
    return 0;
}
*/

/* Exercicio 9

int strlen2 (char str[]){
    int c=0;
    while (str[c]!='\0'){
        c++;
    }
    return c;
}

int main(){
    char n[50];
    printf("Indroduza a String: ");
    gets(n);
    printf("Tamanho da String: %d\n",strlen2(n));
    return 0;
}
*/

/* Exercicio 10

char *strcat2 (char s1[], char s2[]){
    int i=0,j=0;
    while (s1[i]!= '\0')
        i++;
    while (s2[j]!='\0'){
        s1[i]=s2[j];
        j++;
        i++;
    }
    s1[i]='\0';
    return s1;
}

int main(){
    char s1[50]; 
    char s2[50];
    printf("Introduza a primeira string: ");
    gets(s1);
    printf("Introduza a primeira string: ");
    gets(s2);
    printf("Strings concatenadas: %s\n", strcat2(s1,s2));
    return 0;
}
*/

/* Exercicio 11

char *strcpy2 (char *dest, char source[]){
    int i=0;
    while (source[i]!='\0'){
        dest[i]=source[i];
        i++;
    }
    dest[i]='\0';
    return dest;
}

int main(){
    char dest[50];
    char source[50];
    printf("Introduza a string: ");
    gets(source);
    printf("Dest: %s\n", strcpy2(dest,source));
    return 0;
}
*/

/* Exercicio 12

int strcmp2 (char s1[], char s2[]){
    int i=0;
    while (s1[i]!='\0' || s2[i]!='\0'){
        if (s1[i]<s2[i])
            return -1;
        if (s1[i]>s2[i])
            return 1;
    }
    return 0;
}

int main(){
    char s1[50]; 
    char s2[50];
    printf("Introduza a primeira string: ");
    gets(s1);
    printf("Introduza a primeira string: ");
    gets(s2);
    printf("Iguais: 0 \ns1 menor: -1 \ns2 menor=1 \nResposta: %d\n", strcmp(s1,s2));
    return 0;
}
*/

/* Exercicio 13 - Feito por Duarte Freitas

char *strstr2 (char s1[], char s2[]){
    int t1= strlen(s1);
    int t2= strlen(s2);
    int i,j;
    if(t2>t1) 
        return NULL;
    for(i=0;i<=t1-t2;i++){
        for(j=0;s2[j]!='\0' && s1[i+j]==s2[j];j++);
        if(s2[j]=='\0')
            return s1+i;    
    }
    return NULL;
}

int main(){
    char s1[50]; 
    char s2[50];
    printf("Introduza a primeira string: ");
    gets(s1);
    printf("Introduza a segunda string: ");
    gets(s2);
    printf("Ocorre na posicao: %s\n", strstr2(s1,s2));
    return 0;
}
*/

/* Exercicio 14

void strrev2 (char s[]){
    int i=0,j;
    char aux [50];
    j = strlen(s);
    for (i=0; s[i]!='\0'; i++,j--){
        aux[i] = s[j-1];
    }
    aux[i]='\0';
    printf("String convertida: %s\n", aux);

}

int main(){
    char s[50]; 
    printf("Introduza a string: ");
    gets(s);
    strrev2(s);
    return 0;
}
*/

/* Exercicio 15

void strnoV (char s[]){
    int i,j=0;
    char aux [50];
    for (i=0; s[i]!='\0'; i++){
        if (s[i] != 'a' && s[i] != 'e' && s[i] != 'i' && s[i] != 'o' && s[i] != 'u' &&
        s[i] != 'A' && s[i] !='E' && s[i] != 'I' && s[i] != 'O' && s[i] != 'U'){
            aux[j]=s[i];
            j++;
        }
    }
    aux[j]='\0';
    printf("String sem vogais: %s\n", aux);
}

int main(){
    char s[50]; 
    printf("Introduza a string: ");
    gets(s);
    strnoV(s);
    return 0;
}
*/

/* Exercicio 16

void truncW (char t[], int n){
    int i,j=0, n2=n;
    for (i=0; t[i]!='\0';i++){
        if ((i<n) && (t[i]!=' ')){
            t[j]=t[i];
            j++;
        }
        else if (t[i]==' '){
            t[j]=t[i];
            j++;
            n=(i+1)+n2;
        }
    }
    t[j]='\0';
    printf ("Texto truncado: %s", t);    
}

int main(){
    char t[50];
    int n;
    printf("Introduza o texto: ");
    gets(t);
    printf("Introduza o limite de caracteres: ");
    scanf("%d",&n);
    truncW(t,n);
    return 0;
}
*/


/* Exercicio 17

int contida (char a[], char b[]){
    int i,j,resultado;
    for (i=0; a[i]!='\0'; i++){
        resultado=-1;
        for (j=0; b[j]!='\0'; j++){
            if (a[i]==b[j]){
                resultado=0;
                break;
            }
        }
        if (resultado == -1)
            break;
    }
    return resultado;
}

int main(){
    char s1[50]; 
    char s2[50];
    printf("Introduza a primeira string: ");
    gets(s1);
    printf("Introduza a segunda string: ");
    gets(s2);
    printf("Contida: 0 \nNao contida: -1 \nResposta: %d\n", contida(s1,s2));
    return 0;
}
*/

/* Exercicio 18

char maisfreq (char s[]){
    int i,j, contador=0, aux[50];
    char resultado;

    if (s[0]=='\0')
        return '0';

    for (i=0; s[i]!='\0'; i++){
        aux[i]=0;
    }

    for (i=0; s[i]!='\0'; i++){
        contador=0;
        for (j=i; s[j]!='\0'; j++){
            if (s[i]==s[j]){
                contador++;
                aux[i]=contador;
            }
        }
    }
    aux[i]='\0';
    contador=0;
    for (i=0; aux[i]!='\0'; i++){
        if (aux[i]>contador){
            resultado = s[i];
            contador = aux[i];
        }
    }
    return resultado;
}

int main(){
    char s[50]; 
    printf("Introduza string: ");
    gets(s);
    printf("Caracter mais frequente: %c\n", maisfreq(s));
    return 0;
}
*/

/* Exercicio 19

int iguaisConsecutivos (char s[]){
    int i, aux[50], contador=1;

    for (i=0; s[i]!='\0'; i++){
        aux[i]=0;
    }

    for (i=0; s[i]!='\0'; i++){
        if (s[i]==s[i+1]){
                contador++;
                aux[i]=contador;
        }
        else{
            aux[i]=0;
            contador=1;
        }
    }
    aux[i]='\0';
    contador=0;
    i=0;
    for (i=0; s[i]!='\0'; i++){
        if (aux[i]>contador)
            contador = aux[i];
    }
    return contador;
}


int main(){
    char s[50]; 
    printf("Introduza string: ");
    gets(s);
    printf("Caracter iguais consecutivo: %d\n", iguaisConsecutivos(s));
    return 0;
}
*/

/* Exercicio 20

int difConsecutivos (char s[]){
    int i, aux[50], contador=1;

    for (i=0; s[i]!='\0'; i++){
        aux[i]=0;
    }

    for (i=0; s[i]!='\0'; i++){
        if ((s[i+1]!='\0') && (s[i]!=s[i+1])){
                contador++;
                aux[i]=contador;
        }
        else{
            aux[i]=0;
            contador=1;
        }
    }
    aux[i]='\0';
    contador=0;
    i=0;
    for (i=0; s[i]!='\0'; i++){
        if (aux[i]>contador)
            contador = aux[i];            
    }
    return contador;
}

int main(){
    char s[50]; 
    printf("Introduza string: ");
    gets(s);
    printf("Caracteres diferentes consecutivo: %d\n", difConsecutivos(s));
    return 0;
}
*/

/* Exercício 21

int maiorPrefixo (char s1 [], char s2 []){
    int i, contador=0;

    for (i=0; s1[i]!='\0' || s2[i]!='\0'; i++){
        if (s1[i]== s2[i])
            contador ++;
        else 
            break;
    }
    return contador;
}

int main(){
    char s1[50]; 
    char s2[50];
    printf("Introduza a primeira string: ");
    gets(s1);
    printf("Introduza a segunda string: ");
    gets(s2);
    printf("Maior prefixo: %d\n", maiorPrefixo(s1,s2));
    return 0;
}
*/

/* Exercicio 22

int maiorSufixo (char s1 [], char s2 []){
    int i, j, contador=0;

    for (i=strlen(s1)-1,j=strlen(s2)-1; i>=0 && j>=0; i--,j--){
         if (s1[i] == s2[j])
            contador ++;
        else 
            break;
    }
    return contador;
}

int main(){
    char s1[50]; 
    char s2[50];
    printf("Introduza a primeira string: ");
    gets(s1);
    printf("Introduza a segunda string: ");
    gets(s2);
    printf("Maior sufixo: %d\n", maiorSufixo(s1,s2));
    return 0;
}
*/

/* Exercicio  23

int supre (char s1[], char s2[]){
    int i, j, contador=0;

for (i=0,j=0; s1[i]!='\0' && s2[j]!='\0'; i++){
        if (s1[i] == s2[j]){
            contador ++;
            j++;
        }
        else if (contador>0){
            contador=0;
            j=0;
            i--;
        }
    }   
    return contador;
}

int main(){
    char s1[50]; 
    char s2[50];
    printf("Introduza a primeira string: ");
    gets(s1);
    printf("Introduza a segunda string: ");
    gets(s2);
    printf("Supre: %d\n", supre(s1,s2));
    return 0;
}
*/

/* Exercicio 24

int contaPal (char s[]){
    int i, j, resultado=1;

    for (i=0; s[i]!='\0'; i++){
        if (s[i]!=' ')
            break;
    }
    for (j=i; s[j]!='\0'; j++){
        if ((s[j]==' ') && (s[j+1]!=' ') && (s[j+1]!='\0'))
            resultado ++;
    }
    return resultado;
}

int main(){
    char s[50]; 
    printf("Introduza string: ");
    gets(s);
    printf("Numero de palavras: %d\n", contaPal(s));
    return 0;
}
*/

/* Exercicio 25

int contaVogais (char s[]){
    int i, resultado=0;

    for (i=0; s[i]!='\0'; i++){
        if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o'|| s[i] == 'u' ||
        s[i] == 'A' || s[i] == 'E' || s[i] == 'I' || s[i] == 'O' || s[i] == 'U')
            resultado++;
    }
    return resultado;
}

int main(){
    char s[50]; 
    printf("Introduza string: ");
    gets(s);
    printf("Numero de vogais: %d\n", contaVogais(s));
    return 0;
}
*/

/* Exercicio 26 = Exercicio 17*/

/* Exercicio 27
int palindorome (char s[]){
    int i,j, metade;
    metade = strlen (s)/2;
   
    for (i=0,j=strlen (s)-1; i<metade && j>=metade; i++, j--){
        if (s[i]!=s[j])
            return -1;
    }
    return 0;
}

int main(){
    char s[50]; 
    printf("Introduza string: ");
    gets(s);
    printf("Palindrome? 0=Sim; -1=Nao\nResultado: %d\n", palindorome(s));
    return 0;
}
*/

/* Exercicio 28

int remRep (char x[]){
    int i,j=0;
    for (i=0; x[i]!='\0'; i++){
        if (x[i]!=x[i+1]){
            x[j]=x[i];
            j++;
        }
    }
    x[j]='\0';
    printf("x: %s\n", x);
    return strlen(x);
}

int main(){
    char s[50]; 
    printf("Introduza string: ");
    gets(s);
    printf("Tamanho da funcao: %d\n", remRep(s));
    return 0;
}
*/

/*
int limpaEspacos (char t[]){
    int i,j=0;
    for (i=0; t[i]!='\0'; i++){
        if ((t[i]== ' ') && (t[i+1]== ' ')){
        }
        else {
            t[j]=t[i];
            j++;
        }
           
    }
    t[j]='\0';
    printf("String: %s\n", t);
    return strlen(t);
}

int main(){
    char s[50]; 
    printf("Introduza string: ");
    gets(s);
    printf("Tamanho da funcao: %d\n", limpaEspacos(s));
    return 0;
}
*/



/*void insere (int v[], int N, int x){
    int i, j=0, aux[50];
    for (i=0; i<N; i++,j++){
        if (x<v[i]){
            aux[j]=x;
            x=INT_MAX;
            i--;
        }
        else
            aux[j]=v[i];
    }
    if (x<INT_MAX){
        aux[j]=x;
        j++;
    }
    aux[j]='\0';
    for(i=0; i<N+1; i++)
        printf("Aux[%d]: %d\n",i,aux[i]);
}
*/

/* Exercicio 30
void insere (int v[], int N, int x){
    int i, j=0;
    for (i=0; i<N; i++,j++){
        if (x<v[i]){
            for (j=N;j>i;j--)
                v[j]=v[j-1];
            v[j]=x;
            x=INT_MAX;
            break; 
        }
        else
            v[j]=v[i];
    }
    if (x<INT_MAX){
        v[j]=x;
        j++;
    }
    v[N+1]='\0';
    for(i=0; i<N+1; i++)
        printf("v[%d]: %d\n",i,v[i]);
}

int main(){
    int v[50], N, x, i; 
    printf("Introduza N: ");
    scanf("%d",&N);
    for (i=0; i<N; i++){
        printf("Introduza string: ");
        scanf("%d",&v[i]);
    }
    printf("Introduza o elemento: ");
    scanf("%d",&x);
    insere (v,N,x);
    return 0;
}
*/

/* Exercicio 31

void merge (int r [], int a[], int b[], int na, int nb){
    int i=0,j=0,c;
    for(c=0; c<na+nb; c++){
        if (i>=na){
            r[c]=b[j];
            j++;
        }
        else if (j>=nb){
            r[c]=a[i];
            i++;
        }
        else if (a[i]<b[j]){
            r[c]=a[i];
            i++;            
        }
        else if (a[i]>=b[j]){
            r[c]=b[j];
            j++;            
        }
    }
    r[c]='\0';
    for(c=0; c<na+nb; c++)
        printf("r[%d]: %d\n",c,r[c]);
}

int main(){
    int r[100], a[50], b[50], na, nb, i; 
    printf("Introduza tamanho de A: ");
    scanf("%d",&na);
    printf("Introduza tamanho de B: ");
    scanf("%d",&nb);
    for (i=0; i<na; i++){
        printf("Introduza A: ");
        scanf("%d",&a[i]);
    }
    for (i=0; i<nb; i++){
        printf("Introduza B: ");
        scanf("%d",&b[i]);
    }
    merge (r,a,b,na,nb);
    return 0;
}
*/

/* Exercicio 32
int crescente (int a[], int i, int j){
    int c, resultado=0;
    if (i>j)
        resultado=1;

    for (c=i; c<j; c++){
        if (a[c]<=a[c+1])
            i++;
        else
            resultado=1; 
    }
    return resultado;
}

int main(){
    int a[50], i, j, c; 
    printf("Introduza i: ");
    scanf("%d",&i);
    printf("Introduza j: ");
    scanf("%d",&j);
    for (c=i; c<=j; c++){
        printf("Introduza A: ");
        scanf("%d",&a[c]);
    }
    printf("Ordenado? 0=Sim; 1=Nao\nResultado: %d\n", crescente (a,i,j));
    return 0;
}
*/

/* Exercicio 33

int retiraNeg (int v[], int N){
    int i, resultado=0;
    for (i=0; i<N; i++){
        if (v[i]<0){
            v[i]=v[i+1];
        }
        else
            resultado++;
    }
    v[resultado]='\0';
    for (i=0; i<resultado; i++){
        printf("v[%d]: %d\n",i,v[i]);
    }
    return resultado;
}

int main(){
    int v[50], N, c; 
    printf("Introduza N: ");
    scanf("%d",&N);
    for (c=0; c<N; c++){
        printf("Introduza V: ");
        scanf("%d",&v[c]);
    }
    printf("Numeros positivos: %d\n", retiraNeg (v,N));
    return 0;
}
*/

/* Exercicio 34

int menosFreq (int v[], int N){
    int i, aux[50], contador=1, resultado;
    for (i=0; i<N; i++)
        aux[i]=INT_MAX;

    for (i=0; i<N-1; i++){
        if (v[i]==v[i+1]){
            contador++;
            aux[i]-=contador;
            aux[i+1]-=contador;
        }
        else
            contador=1;
    }
    contador=0;
    for (i=0; i<N; i++){
        if (aux[i]>contador){
            contador=aux[i];
            resultado=v[i];
        }
    }
    return resultado;
}


int main(){
    int v[50], N, c; 
    printf("Introduza N: ");
    scanf("%d",&N);
    for (c=0; c<N; c++){
        printf("Introduza V: ");
        scanf("%d",&v[c]);
    }
    printf("Numero menos frequente: %d\n", menosFreq (v,N));
    return 0;
}
*/

/* Exercicio 35

int maisFreq (int v[], int N){
    int i, aux[50], contador=1, resultado;
    for (i=0; i<N; i++)
        aux[i]=1;

    for (i=0; i<N-1; i++){
        if (v[i]==v[i+1]){
            contador++;
            aux[i]+=contador;
        }
        else
            contador=1;
    }
    contador=0;
    for (i=0; i<N; i++){
        if (aux[i]>contador){
            contador=aux[i];
            resultado=v[i];
        }
    }
    return resultado;
}


int main(){
    int v[50], N, c; 
    printf("Introduza N: ");
    scanf("%d",&N);
    for (c=0; c<N; c++){
        printf("Introduza V: ");
        scanf("%d",&v[c]);
    }
    printf("Numero mais frequente: %d\n", maisFreq (v,N));
    return 0;
}
*/

/* Exercicio 36

int maxCresc (int v[], int N){
    int i, contador=1, maximo=0;
    for (i=0; i<N-1; i++){
        if (v[i]<v[i+1]){
            contador++;
            if (contador>maximo)
                maximo=contador;
        }
        else
            contador=1;
    }
    return maximo;
}

int main(){
    int v[50], N, c; 
    printf("Introduza N: ");
    scanf("%d",&N);
    for (c=0; c<N; c++){
        printf("Introduza V: ");
        scanf("%d",&v[c]);
    }
    printf("Maior sequencia crescente: %d\n", maxCresc (v,N));
    return 0;
}
*/

/* Exercicio 37

int elimRep (int v[], int n){
    int i, j, k, resultado=0;

    for (i=0; i<n; i++){
        for (j=i+1; j<n; j++){
            if (v[i]==v[j]){
                for(k=j+1; k<n; k++)
                    v[k-1]=v[k];
                n--;
                v[n]='\0';
                j--;             
            }               
        }
        resultado++;
    }
    for (i=0; i<resultado; i++){
        printf("v[%d]: %d\n",i,v[i]);
    }
    return resultado;
}    

int main(){
    int v[50], N, c; 
    printf("Introduza N: ");
    scanf("%d",&N);
    for (c=0; c<N; c++){
        printf("Introduza V: ");
        scanf("%d",&v[c]);
    }
    printf("Total sem repetidos: %d\n", elimRep (v,N));
    return 0;
}
*/

/* Exercicio 38

int elimRep (int v[], int n){
    int i,j,resultado=0;
    for (i=0; i<n; i++){
        if (v[i]==v[i+1]){
            for (j=i; j<n; j++){
                v[j]=v[j+1];
            }
            n--;
            printf("n: %d\n",n);
            v[n]='\0';
            i--;
        }
        else 
            resultado++;
    }
    for (i=0; i<resultado; i++){
        printf("v[%d]: %d\n",i,v[i]);
    }
    return resultado;
}

int main(){
    int v[50], N, c; 
    printf("Introduza N: ");
    scanf("%d",&N);
    for (c=0; c<N; c++){
        printf("Introduza V: ");
        scanf("%d",&v[c]);
    }
    printf("Total sem repetidos: %d\n", elimRep (v,N));
    return 0;
}
*/

/* Exercicio 39

int comuns (int a[], int na, int b[], int nb){
    int i,j,resultado=0;
    for (i=0, j=0; i<na && j<nb; i++, j++){
        if (a[i]==b[j])
            resultado++;
        else if (a[i]>b[j])
            i--;

        else
            j--;
    }
    return resultado;
}

int main(){
    int a[50], b[50], na, nb, i; 
    printf("Introduza tamanho de A: ");
    scanf("%d",&na);
    printf("Introduza tamanho de B: ");
    scanf("%d",&nb);
    for (i=0; i<na; i++){
        printf("Introduza A: ");
        scanf("%d",&a[i]);
    }
    for (i=0; i<nb; i++){
        printf("Introduza B: ");
        scanf("%d",&b[i]);
    }
    printf("Caracteres em comum: %d\n", comuns (a,na,b,nb));
    return 0;
}
*/

/* Exercicio 40

int verString (int aux[], int x){
    int i=0, resultado=0;
    for (i=0; aux[i]!='\0'; i++){
        if (x==aux[i])
            resultado=1;        
    }
    return resultado;
}

int comuns (int a[], int na, int b[], int nb){
    int i,j,k=0,aux[50],resultado=0;

    for (i=0; i<na; i++){
        for (j=0; j<nb; j++){
            if ((a[i]==b[j]) && (verString(aux,a[i])==0)){
                aux[k]=a[i];
                k++;
                resultado++;
                break;
            }
        }
    }
    return resultado;
}


int main(){
    int a[50], b[50], na, nb, i; 
    printf("Introduza tamanho de A: ");
    scanf("%d",&na);
    printf("Introduza tamanho de B: ");
    scanf("%d",&nb);
    for (i=0; i<na; i++){
        printf("Introduza A: ");
        scanf("%d",&a[i]);
    }
    for (i=0; i<nb; i++){
        printf("Introduza B: ");
        scanf("%d",&b[i]);
    }
    printf("Caracteres em comum: %d\n", comuns (a,na,b,nb));
    return 0;
}
*/

/* Exercicio 41

int maxInd (int v[], int n){
    int i, nmaior=INT_MIN, imaior;
    for (i=0; i<n; i++){
        if (v[i]>nmaior){
            nmaior=v[i];
            imaior=i;
        }
    }
    return imaior;
}

int main(){
    int v[50], N, c; 
    printf("Introduza N: ");
    scanf("%d",&N);
    for (c=0; c<N; c++){
        printf("Introduza V: ");
        scanf("%d",&v[c]);
    }
    printf("Indice com numero maior: %d\n", maxInd (v,N));
    return 0;
}
*/

/* Exercicio 42
int minInd (int v[], int n){
    int i, nmenor=INT_MAX, imenor;
    for (i=0; i<n; i++){
        if (v[i]<nmenor){
            nmenor=v[i];
            imenor=i;
        }
    }
    return imenor;
}

int main(){
    int v[50], N, c; 
    printf("Introduza N: ");
    scanf("%d",&N);
    for (c=0; c<N; c++){
        printf("Introduza V: ");
        scanf("%d",&v[c]);
    }
    printf("Indice com numero menor: %d\n", minInd (v,N));
    return 0;
}
*/

/* Exercicio 44

void somasAc (int v[], int Ac [], int N){
    int i,somatorio=0;
    for (i=0; i<N; i++){
        somatorio+=v[i];
        Ac[i]=somatorio;
    }
    for (i=0; i<N; i++){
        printf("Ac[%d]: %d\n",i,Ac[i]);
    }
}

int main(){
    int v[50], Ac[50], N, c; 
    printf("Introduza N: ");
    scanf("%d",&N);
    for (c=0; c<N; c++){
        printf("Introduza V[%d]: ",c);
        scanf("%d",&v[c]);
    }
    somasAc (v,Ac,N);
    return 0;
}
*/

/* Exercicio 44

#define N 3

int triSup (float m [N][N]){
    int i, j, resultado=0;
    for (i=0; i<N; i++){
        for (j=0; j<N; j++){
            if ((i>j) && (m[i][j]!=0)){
                resultado=-1;
                break;
            }
        }
    }
    return resultado;
}

int main(){
    float m[N][N];
    int i,j;
    for (i=0; i<N; i++){
        for (j=0; j<N; j++){
            printf("Introduza o elemento M[%d][%d]: ",i,j);
            scanf("%f",&m[i][j]);
        }
    }
    printf("Triangular superior? 0=Sim; -1=Nao;\nResultado: %d\n", triSup (m));
    return 0;
}
*/

/* Exercicio 45
#define N 3

void transposta (float m [N][N]){
    int i, j;
    float aux[N][N];
    for (i=0; i<N; i++){
        for (j=0; j<N; j++){
            aux[j][i]=m[i][j];
        }
    }
    for (i=0; i<N; i++){
        for (j=0; j<N; j++){
            printf("%0.0f ",aux[i][j]);
        }
        printf("\n");
    }
}

int main(){
    float m[N][N];
    int i,j;
    for (i=0; i<N; i++){
        for (j=0; j<N; j++){
            printf("Introduza o elemento M[%d][%d]: ",i,j);
            scanf("%f",&m[i][j]);
        }
    }
    transposta (m);
    return 0;
}
*/

/* Exercicio 46

#define N 3
#define M 4

void addTo (int a [N][M], int b[N][M]){
    int i,j;
    for (i=0; i<N; i++){
        for (j=0; j<M; j++){
            a[i][j]+=b[i][j];
        }
    }
    for (i=0; i<N; i++){
        for (j=0; j<M; j++){
            printf("%d ",a[i][j]);
        }
        printf("\n");
    }
}

int main(){
    int i,j, a[N][M], b[N][M];
    for (i=0; i<N; i++){
        for (j=0; j<M; j++){
            printf("Introduza o elemento a[%d][%d]: ",i,j);
            scanf("%d",&a[i][j]);
        }
    }
    for (i=0; i<N; i++){
        for (j=0; j<M; j++){
            printf("Introduza o elemento b[%d][%d]: ",i,j);
            scanf("%d",&b[i][j]);
        }
    }    
    addTo (a,b);
    return 0;
}
*/

/* Exercicio 47
#define N 4

void sumDiag (int m [N][N]){
    int i,j,k,somatorio=0;
    for (i=0; i<N; i++){
        for (j=0; j<N; j++){
            if (j==i){
                for (k=0; k<N; k++){
                    if (k==j);
                    else
                        somatorio+=m[i][k];
                }
                m[i][j]=somatorio;
                somatorio=0;
            }
        }
    }
    for (i=0; i<N; i++){
        for (j=0; j<N; j++){
            printf("%d ",m[i][j]);
        }
        printf("\n");
    }
}

int main(){
    int m[N][N], i, j;
    for (i=0; i<N; i++){
        for (j=0; j<N; j++){
            printf("Introduza o elemento M[%d][%d]: ",i,j);
            scanf("%d",&m[i][j]);
        }
    }
    sumDiag (m);
    return 0;
}
*/

/* Exercicio 48

#define N 4

void sumDiag (int m [N][N]){
    int i,j,k,somatorio=0;
    for (i=0; i<N; i++){
        for (j=0; j<N; j++){
            if (j==i){
                for (k=0; k<N; k++){
                    if (k==i);
                    else
                        somatorio+=m[k][j];
                }
                m[i][j]=somatorio;
                somatorio=0;
            }
        }
    }
    for (i=0; i<N; i++){
        for (j=0; j<N; j++){
            printf("%d ",m[i][j]);
        }
        printf("\n");
    }
}

int main(){
    int m[N][N], i, j;
    for (i=0; i<N; i++){
        for (j=0; j<N; j++){
            printf("Introduza o elemento M[%d][%d]: ",i,j);
            scanf("%d",&m[i][j]);
        }
    }
    sumDiag (m);
    return 0;
}
*/

/* Exercicio 49

#define N 3

int veLinhas (int m[N][N],int x, int coluna){
    int i,contador=0;
    for (i=0; i<N; i++){
        if (x==m[i][coluna])
            contador++;
    }
    return contador;
}

int veColunas (int m[N][N],int x, int linha){
    int j,contador=0;
    for (j=0; j<N; j++){
        if (x==m[linha][j])
            contador++;           
    }
    return contador;
}

int latinS (int m[N][N]){
    int i,j,resultado=0;
    for (i=0; i<N; i++){
        for (j=0; j<N; j++){
            if ((veLinhas (m, m[i][j], j))>1){
                resultado =-1;
                break;
            }
            if ((veColunas (m, m[i][j],i))>1){
                resultado =-1;
                break;
            }
        }
    }
    return resultado;
}
int main(){
    int m[N][N], i, j;
    for (i=0; i<N; i++){
        for (j=0; j<N; j++){
            printf("Introduza o elemento M[%d][%d]: ",i,j);
            scanf("%d",&m[i][j]);
        }
    }
    printf("Quadrado latino? 0=Sim; -1=Nao;\nResultado: %d\n",latinS (m));
    return 0;
}



/* Exercicio 50

int main(){
    char c;
    for (c='A';c<'Z'+1;c++)
        printf("%c: %d\n",c,c);
    for (c='a';c<'z'+1;c++)
        printf("%c: %d\n",c,c);
    return 0;
}
*/