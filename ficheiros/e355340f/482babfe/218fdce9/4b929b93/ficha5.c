#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <math.h>
#include "ficha5.h"


float perimetro(Rectangulo r)
{
	float absx,absy;
	absx=r.p1.x-r.p2.x;
	absy=r.p1.y-r.p2.y;	
	if(absx<0) absx=-absx;
	if(absy<0) absy=-absy;
	return (2*(absx+absy));
}

float area(Rectangulo r)
{
	float absx,absy;
	absx=r.p1.x-r.p2.x;
	absy=r.p1.y-r.p2.y;	
	if(absx<0) absx=-absx;
	if(absy<0) absy=-absy;
	return (absx*absy);
}

int igualj(Jornada j)
{
	int i=0,res=0;
	while(i<20 && !res)
	{
		if(strcmp(j[i].i1.e,j[i].i2.e)==0) res=1;
		i++;	
	}	
	return res;
}

int semrepet(Jornada j)
{
	int i=0,k=0,res=1;
	Equipa e;
	if(igualj(j)) res=0; 
	while(i<20 && res)
	{
		strcpy(e,j[i].i1.e);
		while(k<20 && res)
		{	
			if(strcmp(e,j[k].i2.e)==0) res=0;
			k++;
		}
		i++;
	}	
	return res;
}

Jogo *empates(Jornada j) 
{
	static Jogo res[20];
	int i=0,k=0;
	while(i<20)
	{
		if(j[i].i1.g==j[i].i2.g)
		{
			res[k]=j[i];
			k++;
		}
		i++;
	}	
	return res;
}

Equipa *equipas(Jornada j)
{
	static Equipa res[40];
	int i=0,k=0;
	while(i<20)
	{
		strcpy(res[k],j[i].i1.e);
		strcpy(res[k+1],j[i].i2.e);
		k=k+2;
		i++;
	}	
	return res;
}

float expit(float a, int b)
{
	float res=1;
	while(b>0)
	{
		res=res*a;
		b=b-1;
	}
	return res;
}

float valor(Polinomio p, int x)
{
	int i=0,res=0;
	while(i<50)
	{
		res=res+(expit((p.pol[i].coef*x),p.pol[i].exp));
		i++;
	}
	return res;
}

int grau(Polinomio p)
{
	int i=1,max;
	max=p.pol[0].exp;
	while(i<50)
	{
		if(p.pol[i].exp>=max) max=p.pol[i].exp;
		i++;
	}
	return max;
}

Polinomio derivada(Polinomio p)
{
	int i=0,k=0;
	static Polinomio res;
	if(grau(p)>0)
	{
		while(i<50)
		{
			if(p.pol[i].exp>=0)
			{
				res.pol[k].coef=p.pol[i].coef*p.pol[i].exp;
				if(p.pol[i].exp>0) res.pol[k].exp--;
				k++;
			}
			i++;
		}	
	}
	return res;
}

Polinomio ordena(Polinomio p)
{
	int i=0;
	Termo aux;
	static Polinomio res;
	res=p;
	
	while(i<50)
	{
		if(res.pol[i].exp>res.pol[i+1].exp)
		{
			aux=res.pol[i+1];
			res.pol[i+1]=res.pol[i];
			res.pol[i]=aux;
		}
		i++;
	}
	return res;
}

Polinomio simplifica(Polinomio p)
{	
	int i=0,k=0,j=0;
	static Polinomio res;
	Termo aux;
	while(k<=grau(p))
	{	
		aux.coef=0;
		while(i<50)
		{
			if(p.pol[i].exp==k) aux.coef=aux.coef+p.pol[i].coef;
			i++;
		}
		res.pol[j].coef=aux.coef;
		res.pol[j].exp=k;
		j++;
		k++;		
	}	
	return res;
}

Polinomio soma(Polinomio p1, Polinomio p2)
{
	int i=0,j=0,k=0,found=0;
	static Polinomio res;
	p1=simplifica(p1);
	p2=simplifica(p2);	
	while(i<50)
	{	
		while(j<50 && !found)
		{
			if(p1.pol[i].exp==p2.pol[j].exp)
			{
				found=1;
				res.pol[k].coef=p1.pol[i].coef+p2.pol[j].coef;
				res.pol[k].exp=p1.pol[i].exp;				
				k++;
			}			
			j++;
		}
		if(!found)
		{
			res.pol[k].coef=p1.pol[i].coef;
			res.pol[k].exp=p1.pol[i].exp;
			k++;
		}	
		i++;
	}	
	j=0,i=0;
	while(j<50)
	{	
		while(i<50 && !found)
		{
			if(p1.pol[i].exp==p2.pol[j].exp && !found) found=1;
			i++;
		}
		if(!found)
		{
			res.pol[k].coef=p2.pol[j].coef;
			res.pol[k].exp=p2.pol[j].exp;
			k++;
		}	
		j++;
	}
	return simplifica(res);
}

Polinomio produto(Polinomio p1, Polinomio p2)
{
	int i=0,j=0,k=0;
	static Polinomio res;
	p1=simplifica(p1);
	p2=simplifica(p2);	
	while(i<50)
	{	
		while(j<50)
		{
			res.pol[k].coef=p1.pol[i].coef*p2.pol[j].coef;
			res.pol[k].exp=p1.pol[i].exp+p2.pol[j].exp;
			k++;
			j++;
		}	
		i++;
	}	
	return simplifica(res);
}

int main()
{

	
	
/*	
	float a,b;
	Rectangulo r;	
	printf("Dá coord: ");
	scanf("%f %f",&a,&b);
	r.p1.x=a;
	r.p1.y=b;
	printf("Dá coord: ");
	scanf("%f %f",&a,&b);
	r.p2.x=a;
	r.p2.y=b;
	printf("Coordenadas inseridas: (%.2f,%.2f) (%.2f,%.2f)\n",r.p1.x,r.p1.y,r.p2.x,r.p2.y);
	printf("A área deste rectângulo é %.2f \n",area(r));
	printf("O perímetro deste rectângulo é %.2f \n",perimetro(r));
*/
	
	return 1;
}