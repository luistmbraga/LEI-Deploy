#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include "ficha4.h"


void printSeq(int seq[])
{
	int i=0;
	while(i<10 && seq[i]!=0)
	{
		printf(" %d ",seq[i]);
		i++;
	}
}

float media(int seq[])
{
	int i=0,soma=0;
	while(i<10 && seq[i]!=0)
	{
		soma=soma+seq[i];
		i++;
	}
	return (soma/i);
}

void printAcimaMedia(int seq[])
{
	int i=0;
	float avg=media(seq);
	while(i<10 && seq[i]!=0)
	{
		if(seq[i]>=avg) printf("%d ",seq[i]);
		i++;
	}
	printf("\n");
}

int contido(int s1[],int na, int s2[], int nb)
{
	int i=0,j=0,res=1,flag=0;
	while(i<na && res)
	{
		j=0;
		flag=0;
		while(j<nb && !flag)
		{
			if(s1[i]==s2[j]) flag=1;
			else j++;
		}	
		i++;
		if(!flag) res=0;
	}	
	return res;
}

int calcPos(Turma t, char* nome)
{
	int i=0,found=0;
	while(i<t.numalunos && !found)
	{	
		if(strcmp(t.alunos[i].nome,nome)>=0) found=1;
		else i++;
	}	
	return i;
}

Turma desloca(Turma t, int pos)
{
	int i;
	for(i=t.numalunos; i>pos; i--)
		t.alunos[i]=t.alunos[i-1];	
	return t;
}

Turma insereAluno(Turma t, Aluno a)
{
	int pos;
	if(t.numalunos==0)
	{
		t.alunos[0]=a;
		t.numalunos++;
	}
	else
	{	
		pos=calcPos(t,a.nome);
		t=desloca(t,pos);
		t.alunos[pos]=a;
		t.numalunos++;
	}
	return t;
}

Turma desloca2(Turma t, int pos)
{
	int i;
	for(i=pos; i<t.numalunos-1; i++)
	{
		t.alunos[i]=t.alunos[i+1];
	}
	return t;
}

Turma removeAluno(Turma t, char* nome)
{
	int i=0,found=0;
	if(t.numalunos>0)
	{	
		while(i<t.numalunos && !found)
		{
			if(strcmp(t.alunos[i].nome,nome)==0) found=1;
			i++;
		}	
		t=desloca2(t,i-1);
		t.numalunos--;
	}
	return t;
}

void consulta(Turma t, char* nome)
{
	int i=0,found=0;
	if(t.numalunos>0)
	{	
		while(i<t.numalunos && !found)
		{
			if(strcmp(t.alunos[i].nome,nome)==0) found=1;
			i++;
		}	
		printf("%s %s\n",t.alunos[i-1].nome,t.alunos[i-1].numero);
	}
}

void listarAlunos(Turma t)
{
	int i=0,found=0;	
		while(i<t.numalunos && !found)
		{
			printf("%s %s\n",t.alunos[i].nome,t.alunos[i].numero);
			i++;
		}
}

int nnotas(int a[])
{
	int i=0,res=0;
	while(i<10 && a[i]!=0) i++;
	return res;
}

void mediaAluno(Turma t, char* nome)
{
	int i=0,j=0,soma=0,found=0,numnotas;
	float media;
	if(t.numalunos>0)
	{	
		while(i<t.numalunos && !found)
		{
			if(strcmp(t.alunos[i].nome,nome)==0) found=1;
			i++;
		}
		numnotas=nnotas(t.alunos[i-1].notas);
		while(j<numnotas)
		{
			soma=soma+t.alunos[i-1].notas[j];
			j++;
		}	
		printf("%d\n",soma);
		media=soma/numnotas;
		printf("%f \n",media);
	}

}


int main()
{
	
	
	Aluno a1={"A55171\0","Tiago Ferreira\0",{19,18,18,13,12,15,11,10}};
	Aluno a2={"A55718\0","Hugo Marisco\0",{19,18,18,13,12,15,11,10}};
	Aluno a3={"A50082\0","Ana Silva\0",{19,18,18,13,12,15,11,10}};
	Turma t1;
	t1.numalunos=0;			
	t1=insereAluno(t1,a3);	
	t1=insereAluno(t1,a2);
	t1=removeAluno(t1,a2.nome);
	t1=insereAluno(t1,a1);
	t1=insereAluno(t1,a2);
	listarAlunos(t1);
	mediaAluno(t1,a2.nome);
	
/*
	int a,seq1[100],seq2[100],i=0,na=0,nb=0;
	printf("Introduz inteiros(max 100) para o conjunto A, termina com 0\n");
	scanf("%d",&a);
	seq1[i]=a;
	i++;
	while(a!=0 && i<100)
	{
		scanf("%d",&a);
		seq1[i]=a;
		i++;
	}	
	while(seq1[na]!='\0') na++;	
	i=0;
	printf("Introduz inteiros(max 100) para o conjunto B, termina com 0\n");
	scanf("%d",&a);
	seq2[i]=a;
	i++;
	while(a!=0 && i<100)
	{
		scanf("%d",&a);
		seq2[i]=a;
		i++;
	}
	while(seq2[nb]!='\0') nb++;
	if(contido(seq1,na-2,seq2,nb-2)) printf("A está contido em B\n");
	if(contido(seq2,nb-2,seq1,na-2)) printf("B está contido em A\n");

	int a,seq[10],i=0;
	printf("Introduz dez vendas, termina com 0\n");
	scanf("%d",&a);
	seq[i]=a;
	i++;
	while(a!=0 && i<10)
	{
		scanf("%d",&a);
		seq[i]=a;
		i++;
	}	
	printf("Vendas: ");
	printSeq(seq);
	printf("\n");
	printf("Média de vendas: %.2f\n",media(seq));
	printf("Acima da média: ");
	printAcimaMedia(seq);
*/
 
	return 1;
}