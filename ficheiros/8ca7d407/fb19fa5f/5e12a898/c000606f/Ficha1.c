
#include <stdio.h>

//Ficha 1
//2-Estruturas de controlo

/*2-Escrever um programa que liste no ecran as letras do alfabeto (maiúsculas e minúsculas) e
o respectivo código ASCII, usando a função printf.
*/

int main ()
{
 char c='A';
 while (c<='Z' || c<='z')
  {
  printf ("%c - %d \n", c,c);
  if (c=='Z') c='a';
  else c++;
  }
 return 0;
}


/*3-Escrever um programa que desenhe no ecran (usando o caracter #) um quadrado de dimensão 5, definindo
para isso uma função que desenha um quadrado de dimensão n, usando a função putchar.
O resultado da invocação dessa função com um argumento 5 deverá ser:
#####
#####
#####
#####
#####
*/

void linhas (int n)
{
 while (n>0)
  {
  putchar('#');
  n=n-1;
  }
 putchar('\n');
}

void quadrados (int n)
{
 int i;
 for (i=0; i<n; i++)
  linhas (n);
}

int main ()
{
 int c;
 printf ("Introduza um numero: ");
 scanf ("%d", &c);
 quadrados(c);
 return 0;
}


/*4-Escrever um programa que desenhe no ecran (usando os caracteres # e _) um tabuleiro de xadrez,
definindo para isso uma função que desenha um tabuleiro de xadrez de dimensão n, usando a função
putchar. O resultado da invocação dessa função com um argumento 5 deverá ser:
#_#_#
_#_#_
#_#_#
_#_#_
#_#_#
*/

void par (int n)
{
 int i;
 for (i=0; i<n; i++)
  {
   if (i%2==0) putchar('#');
   else putchar ('_');
  }
 putchar ('\n');
}

void impar (int n)
{
 int i;
 for (i=0; i<n; i++)
  {
   if (i%2==0) putchar ('_');
   else putchar ('#');
  }
  putchar ('\n');
}

void linhas (int n)
{
 while (n>0)
  {
   putchar ('#');
   n=n-1;
  }
 putchar('\n');
}

void xadrez (int n)
{
 int i;
 for (i=0; i<n; i++)
  {
   if (i%2==0) par(n);
   else impar(n);
  }
 }
 
int main ()
{
 int c;
 printf("Introduza um numero: ");
 scanf("%d", &c);
 xadrez(c);
 return 0;
}


/*
int main ()
{
 int n, i=0;
 //printf("Insira um numero: ");
 scanf("%d", &n);
 while (n!=0)
  {
  i=n+i;
  scanf("%d", &n);
  }
 printf("%d \n",i);
 return 0;
}
*/
