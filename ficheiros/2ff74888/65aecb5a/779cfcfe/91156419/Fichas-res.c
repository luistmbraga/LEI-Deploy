
//Ficha 1:

//2)
//c)

#include <stdio.h>

int main()

{

	int x,d,h,m,s;

	printf("--------------------------------------\nIntroduz o tempo em segundos...\n");

	scanf("%d",&x);

	d = x/86400;

	h = (x%86400)/3600;

	m = ((x%86400)%3600)/60;

	s = ((x%86400)%3600)%60;

	printf("\nTempo: %d dia(s), %02d hora(s), %02d minuto(s) e %02d segundo(s).\n\n",d,h,m,s);

	return 1;

}


3)
h)

#include <stdio.h>

int main ()

{
	int x, y, res=1;
	printf ("Quest�o 3 h):\n");

	printf("\nIntroduza o n�mero que pretende elevar a outro n�mero.\n");

	scanf("%d",&x);

	printf("\nIntroduza o exponencial.\n");
	scanf("%d",&y);

	while(y != 0)

	{   y = y - 1;

	    res = res * x;

	}

	printf("O n�mero resultante � %d.\n",res);

	return 1;

	
}	


3)
j)

#include <stdio.h>

/*

F = 1.8
*C+32
C = (F-32)/1.8

*/

int main ()

{
	
float f=0;

	printf("\nTabela de convers�o entre Farenheit e Celsius:\n");

	while (f <= 300)

	{

		printf("   %3.0f �F | %6.2f �C\n",f,(f-32)/1.8);

		f = f + 5;

	}

	return 1;

}	


Ficha 2:

a)

#include <stdio.h>



char toLower (char a)

{

	if ((a < 65)||(a > 96)) return a;

	else return (a + 32);

}



/*

As minusculas v�m depois das mai�sculas:

'A' = 65

'a' = 97

*/




char evogal(char a)

{
	a = toLower (a);

	if ((a=='a')||(a=='e')||(a=='i')||(a=='o')||(a=='u'))

	{

		return 'S';

	}

	else

	{

		return 'N';

	}

}


	
int main()

{

	char x;

	printf("\nIntroduza uma letra: ");

	scanf("%c",&x);

	printf("\"%c\" � vogal? %c\n\n",x,evogal (x));

	return 1;

}





b)


#include <stdio.h>



int abss(int a)

{

	if (a>0)

	{

		return a;

	}

	else

	{

		return (-a);

	}

}



int main()

{
	
int a;

	printf("\nIntroduz o valor: ");

	scanf("%d",&a);

	printf("O m�dulo de %d � %d.\n\n",a,abss(a));

	return 1;

}


	

c)

#include <stdio.h>



int abss(int a)

{

	if (a>0)

	{

		return a;

	}

	else

	{

		return (-a);

	}

}



int main()

{
	
int a;

	printf("\nIntroduz o valor: ");

	scanf("%d",&a);

	printf("O m�dulo de %d � %d.\n\n",a,abss(a));

	return 1;

}


------ Interativo ----

#include <stdio.h>



int main()

{
	
int a,b,b2,t;

	printf("\nIntroduz os valores separados por v�rgula: ");

	scanf("%d,%d",&a,&b);

	b2 = b;
	t = 1;

	if(b>0)

	{

		while (b>0)

		{

			t = a*t;

			b = b-1;

		}

		printf("%d elevado � pot�ncia de %d � %d.\n\n",a,b2,t);

	}

	else

	{

		b = -b;

		while (b>0)

		{

			t = a*t;

			b = b-1;

		}

		printf("%d elevado � pot�ncia de %d � 1/%d.\n\n",a,b2,t);

	}

	return 1;

}



----- Recursivo ----

#include <stdio.h>



int expx(int a,int b)

{

	if (b >0)

	{

		return (a*expx(a,(b-1)));

	}

	else

	{
	
		return 1;

	}

}



int main()

{
	
int a,b;

	printf("\nIntroduz os valores separados por v�rgula: ");

	scanf("%d,%d",&a,&b);

	if(b>0)

	{

		printf("%d elevado � pot�ncia de %d � %d.\n\n",a,b,expx(a,b));

	}

	else

	{

		printf("%d elevado � pot�ncia de %d � 1/%d.\n\n",a,b,expx(a,-b));

	}

	return 1;

}
			


d)

---- Iterativo ----

#include <stdio.h>



int main()

{
	
int a,a2,t;

	printf("\nIntroduz o valor: ");

	scanf("%d",&a);

	t = 1;

	a2 = a;

	while (a>1)

	{

		t = a*t;

		a = a-1;

	}

	printf("O factorial de %d � %d.\n\n",a2,t);

	return 1;

}


---- Recursivo ----

#include <stdio.h>



int factx(int a)

{

	if (a >1)

	{

		return (a*factx(a-1));

	}

	else

	{
	
		return 1;

	}

}



int main()

{
	int a,a2;

	printf("\nIntroduz o valor: ");

	scanf("%d",&a);

	printf("O factorial de %d � %d.\n\n",a,factx(a));

	return 1;

}
	


e)

---- Iterativo ----

#include <stdio.h>

#include <math.h>



int absx(int a)

{

	if (a>0)

	{

		return a;

	}

	else

	{

		return (-a);

	}

}




int main()

{
	int x1,y1,x2,y2,f,g;

	printf("\nIntroduz as coordenadas de cada ponto separadas por virgula (por exemplo: (1,2),(3,4)): ");

	scanf("(%d,%d),(%d,%d)",&x1,&y1,&x2,&y2);

	f = x2-x1;

	g = y2-y1;

	

	printf("A dist�ncia entre os pontos (%d,%d) e (%d,%d) � %d.\n\n",x1,y1,x2,y2,
	sqrt(f^2+g^2));

	return 1;

}



/*
 double result, mudar tipo de 5� %d
*/


f)

#include <stdio.h>



int mmc(int a, int b)

{

	int maior,t;

	maior=max(a,b);

	while (!(t%a==0 && t%b==0))

	{

	t=t+maior;

	}

	return t;

}



int main()

{
	int a,b;

	printf("\nIndique os dois n�meros dos quais pretende encontrar o m�nimo divisor comum. (separados por uma v�rgula)\n");

	scanf("%d,%d",&a,&b);

	printf("\nO m�nimo divisor comum de %d e %d � %d.\n",a,b,mmc (a,b));

	return 1;

}



int max(int a,int b)

{

	if (a > b) return a;

	else return b;

}



h)

#include <stdio.h>



int mdc (int a, int b)

{

	int res, aux;

	while (a%b!=0)

	{

		aux = b;

		b = a%b;

		a = aux;

	}

	return b;

}



int main()

{

	int x1,x2,y1,y2,mdcomum,resx,resy;

	printf("\nIntroduza os numeradores e os denominadores da seguinte forma:\n(numerador,denominador),(numerador2,denominador2)\n");

	scanf("(%d,%d),(%d,%d)",&x1,&y1,&x2,&y2);

	resx = (x1*y2)+(x2*y1);
	resy = y1*y2;

	mdcomum = mdc(resx,resy);

	printf("\nA soma das frac��es � a seguinte: %d/%d\n",(resx/mdcomum),(resy/mdcomum));

	return 1;

}





Ficha 3:


1)


#include <stdio.h>


int main ()

{

	int A[10] = {0};

	char val = 'Z';

	printf("\n   Sequ�ncias de Inteiros: lista de opera��es\n");

	while (val != 'I')

	{
	
	printf("---------------------------------------------------\nA - Ler a sequ�ncia do teclado\nB - Escrever a sequ�ncia para o ecr�\nC - Calcular o m�ximo da sequ�ncia\nD - Calcular o m�nimo da sequ�ncia\nE - Determinar a subsequ�ncia de n�meros acima da m�dia\nF - Determinar a subsequ�ncia de n�meros abaixo da m�dia\nG - Calcular o m�nimo m�ltiplo comum da sequ�ncia\nH - Determinar a subsequ�ncia dos n�meros que s�o primos\nI - Sair do Programa\n");

		printf("\n   Op��o: ");

		scanf(" %c",&val);

		if (val == 'A')

		{ 

			fA(A);

			fB(A);

		}

		else if (val == 'B') fB(A);

		else if (val == 'C') fC(A);

		else if (val == 'D') fD(A);

		else if (val == 'E') fE(A,10);

		else if (val == 'F') fF(A,10);

		else if (val == 'G') fG(A,10);

		else if (val == 'H') fH(A,10);

		else if (val == 'I') break;

	}

	return 1;

}






int fA (int A[])

{

	int n=0,input = 1;

	puts("");

	while ((n < 10)&&(input != 0))

	{

		printf("Introduza o %d� n�mero (%d de 10): ",n+1,n+1);

		scanf("%d",&input);

		if (input != 0) A[n] = input;

		n++;

	}

}



int fB (int A[])

{

	int n=0;

	printf("\nA lista actual � a seguinte: ");

	printf("{");

	while (n < 9)

	{

		printf("%d,",A[n]);

		n++;

	}

	printf("%d}\n\n",A[n]);

	return 1;

}



int fC (int A[])

{

	int max=A[0],i=1;

	while(i<10)
 
	{

		if (A[i] == 0) i++;

		else

		{

			if(A[i]>max) max = A[i];

			i++;

		}

	}

	printf("\nO m�ximo da sequ�ncia � %d.\n",max);

}



int fD (int A[])

{

	int min=A[0],i=1;

	while(i<10)
 
	{

		if (A[i] == 0) i++;

		else

		{

			if(A[i]<min) min = A[i];

			i++;

		}

	}

	printf("\nO m�nimo da sequ�ncia � %d.\n",min);

}



int fE(int A[],int i)

{

	int soma=0, nelem=i;

	float media;

	i--;

	while (i >= 0)

	{
	
		if (A[i] != 0)

		{
	
			soma = soma + A[i];

			i--;

		}
	
		else

		{
	
			nelem--;

			i--;

		}

	}

	i = 9;

	media = soma/nelem;

	printf("\nOs n�meros maiores que a m�dia (%f) s�o os seguintes:\n{",media);

	while (i >= 0)

	{

		if (A[i] > media)
 
		{

			printf("%d",A[i]);

			if (i != 0) printf(",");

		}

		i--;

	}

	printf("}\n");


}



int fF(int A[],int i)

{

	int soma=0, nelem=i;

	float media;

	i--;

	while (i >= 0)

	{
	
		if (A[i] != 0)

		{
	
			soma = soma + A[i];

			i--;

		}
	
		else

		{
	
			nelem--;

			i--;

		}

	}

	i = 9;

	media = soma/nelem;

	printf("\nOs n�meros maiores que a m�dia (%f) s�o os seguintes:\n{",media);

	while (i >= 0)

	{

		if (A[i] < media)
 
		{

			printf("%d",A[i]);

			if (i != 0) printf(",");

		}

		i--;

	}

	printf("}\n");


}



int fG (int A[],int nelem)

{

	int i=1,mmcomum=A[0];

	while (i < nelem)

	{

		if(A[i] != 0)

		{

			mmcomum = mmc(mmcomum,A[i]);

			i++;

		}

		else break;

	}

	printf("\nO m�ltiplo m�nimo comum � %d.\n",mmcomum);

}




int mmc(int a, int b)

{

	int maior,t;

	maior = max(a,b);

	t = maior;

	while (!(t%a==0 && t%b==0))

	{

		t = t + maior;

	}

	return t;

}



int max(int a,int b)

{

	if (a > b) return a;

	else return b;

}



int fH(int A[],int nelem)

{

	int primos[10], p = 0, i = 0, x = 2, n=0;
 
	while (i < nelem)

	{

		if (A[i] == 0) i++;

		else

		{

			while ((A[i]%x != 0) && (x < (A[i]/2))) {x++ ;}

			if ((A[i]%x) || (A[i]==2))
 
			{

				primos[p] = A[i];

				p++;

			}

			i++;

			x=2;

		}

	}

	printf("\nOs primos s�o: ");

	printf("{");

	while (n < (p-1))

	{

		printf("%d,",primos[n]);

		n++;

	}

	printf("%d}\n\n",primos[n]);

}

		
		


1_2)

include <stdio.h>


int main ()

{

	int A[10] = {0};

	char val = 'Z';

	printf("\n    Sequ�ncias de Inteiros: lista de opera��es");

	printf("\n---------------------------------------------------\nA - Ler a sequ�ncia\nB - Escrever a sequ�ncia\nC - Calcular o m�ximo da sequ�ncia\nD - Calcular o m�nimo da sequ�ncia\nE - Determinar a subsequ�ncia de n�meros acima da m�dia\nF - Determinar a subsequ�ncia de n�meros abaixo da m�dia\nG - Calcular o m�nimo m�ltiplo comum da sequ�ncia\nH - Determinar a subsequ�ncia dos n�meros que s�o primos\nI - Sair do Programa\n");

	while (val != 'I')

	{
	
	printf("\n    Op��o:");

		scanf("%c",&val);

		if (val == 'A')

		{
 
			fA(A);

			fB(A);

		}

		else if (val == 'B') fB(A);

		else if (val == 'C') fC(A);

		else if (val == 'D') fD(A);

		else if (val == 'I') break;

		else printf("Op��o inv�lida ou por construir");

	}

	return 1;

}

// APARECE "OPCAO:" DUAS VEZES, A PRIMEIRA PASSA LOGO A FRENTE E APARECE O ERRO



int fA (int A[])

{

	int n=0,input = 1;

	while ((n < 10)&&(input != 0))

	{

		printf("Introduza o %d� n�mero (%d de 10): ",n+1,n+1);

		scanf("%d",&input);

		if (input != 0) A[n] = input;

		n++;

	}

}



int fB (int A[])

{

	int n=0;

	printf("\nA lista actual � a seguinte:\n");

	printf("{");

	while (n < 9)

	{

		printf("%d,",A[n]);

		n++;

	}

	printf("%d}\n\n",A[n]);

	return 1;

}



int fC (int A[])

{

	int max=A[0],i=1;

	while(i<=10) 

	{

		if(max>*(A+i)) max = A[i];

		i++;

	}

	printf("\nO m�ximo da sequ�ncia � %d.",max);

}



int fD (int A[])

{

	int min=A[0],i=1;

	while(i<=10)
 
	{

		if(A[i]<min) min = A[i];

		i++;

	}

	printf("\nO m�nimo da sequ�ncia � %d.",min);

}


analise_strings)

#include <stdio.h>

#include <ctype.h>



int main ()

{

	char frase[60];

	printf("Introduza uma frase com no m�ximo 60 caracteres:\n");

	fgets(frase,61,stdin);

	printf("Frase de entrada: %s",frase);

	vogais(frase,60);




	return 1;

}



int vogais (char frase[],int comp)

{

	char A[comp-1];

	int i=0, v=0;

	while(i < comp)

	{
	
		if (isvogal (frase[i]))

		{

			A[v] = frase[i];

			v++;

		}

		i++;

	}

	printf("N�mero de vogais: %s",A);

}



int isvogal (char c)

{

	return ((c == 'A')||(c == 'E')||(c == 'I')||(c == 'O')||(c == 'U'));

}


analise_strings_2)

#include <stdio.h>

#include <ctype.h>

#include <string.h>



int main ()

{

	char c='1';

	printf("Introduza uma frase com no m�ximo 60 caracteres:\n");

	//scanf(" %c",&c);

	c = teste(c);

	printf(c);

	return 1;

}



char teste(char a)

{
	
	if (a=='a')

	{

		return 'S';

	}

	else

	{

		return 'N';

	}

}




romano-arabe)

#include <stdio.h>

#include <string.h>

#include <stdlib.h>



int main ()

{

	char romano[10];

	printf("\nIntroduza um n�mero romano v�lido: ");

	scanf("%s",romano);

	printf("\nO n�mero convertido para numera��o �rabe � %d.\n",convert(romano));

	return 1;

}




int convert(char *s)

{

	int res=0, previous = 0, actual, i = 0;

	while (s[i] != '\0')

	{
	
		switch(s[i])

		{

			case 'I': actual = 1; break;

			case 'V': actual = 5; break;

			case 'X': actual = 10; break;

			case 'L': actual = 50; break;

			case 'C': actual = 100; break;

			case 'D': actual = 500; break;

			case 'M': actual = 1000; break;

		}

		if(previous < actual) res+= actual - 2*(previous);

		else res += actual;

		previous = actual;

		i++;

	}

	return res;

}

