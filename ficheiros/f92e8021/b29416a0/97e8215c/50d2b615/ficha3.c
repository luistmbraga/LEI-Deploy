#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <math.h>


void printSeq(int seq[])
{
	int i=0;
	while(i<100 && seq[i]!=0)
	{
		printf("%d -> %d\n",i+1,seq[i]);
		i++;
	}
}

int maxSeq(int seq[])
{
	int i=1,max=seq[0];
	while(i<100 && seq[i]!=0)
	{
		if(seq[i]>=max) max=seq[i];
		i++;
	}
	return max;
}

int minSeq(int seq[])
{
	int i=1,min=seq[0];
	while(i<100 && seq[i]!=0)
	{
		if(seq[i]<=min) min=seq[i];
		i++;
	}
	return min;
}

float media(int seq[])
{
	int i=0,soma=0;
	while(i<100 && seq[i]!=0)
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
	while(i<100 && seq[i]!=0)
	{
		if(seq[i]>=avg) printf("%d ",seq[i]);
		i++;
	}
	printf("\n");
}

void printAbaixoMedia(int seq[])
{
	int i=0;
	float avg=media(seq);
	while(i<100 && seq[i]!=0)
	{
		if(seq[i]<=avg) printf("%d ",seq[i]);
		i++;
	}	
	printf("\n");
}

int mmcrec(int a, int b)
{
	return mmcrecaux(a,b,a);
}

int mmcrecaux(int r, int s, int t)
{
	int res=t;
	if(res%s != 0) res = mmcrecaux(r,s,t+r);
	return res;
}

int mmcSeq(int seq[])
{
	int i=2,res;
	res=mmcrec(seq[0],seq[1]);
	while(i<100 && seq[i]!=0)
	{
		res=mmcrec(res,seq[i]);
		i++;
	}
	return res;
}

int eprimo(int n)
{
	int i=2,primo=1;
	while((i<=n/2) && (primo==1))
	{
		if(n%i==0) primo=0;
		i++;
	}
	return primo;
}

void printPrimos(int seq[])
{
	int i=0;
	while(i<100 && seq[i]!=0)
	{
		if(eprimo(seq[i])) printf("%d ",seq[i]);
		i++;
	}	
	printf("\n");
}

void printToto(int a,int b,int c,int d,int e,int f)
{
	int i,seq[49];
	for(i=1;i<50;i++) seq[i]=i;
	i=1;
	
	while(i<50)
	{
		if(seq[i]==a || seq[i]==b || seq[i]==c || seq[i]==d || seq[i]==e || seq[i]==f)
		{
			printf("x\t");
			if(i%7==0) printf("\n");
		}
		else 
		{
			printf("%d \t",i);
			if(i%7==0) printf("\n");
		}
		i++;
	}
	printf("\n");	
}

int vogal(char i)
{
	if(i=='a'||i=='e'||i=='i'||i=='o'||i=='u'||i=='A'||i=='E'||i=='I'||i=='O'||i=='U') return 1;
	else return 0;
}

void printStuff(char s[])
{
	int i=0,l,vogs=0,cons=0,maius=0,minus=0,nums=0;
	l=strlen(s);
	while(i<strlen(s))
	{
		if(isalpha(s[i]) && vogal(s[i])) vogs++;
		if(isalpha(s[i]) && !vogal(s[i])) cons++;
		if(isalpha(s[i]) && isupper(s[i])) maius++;
		if(isalpha(s[i]) && islower(s[i])) minus++;
		if(isdigit(s[i])) nums++;
		i++;
	}
	printf("Número de vogais: %d\n",vogs);
	printf("Número de consoantes: %d\n",cons-1);
	printf("Número de maiúsculas: %d\n",maius);
	printf("Número de minúsculas: %d\n",minus);
	printf("Número de números: %d\n",nums);
}

void printCap(char s[])
{
	int i=0,j=0,cap=1,l;
	while(s[j]!='\0') j++;
	j=j-2;
	while(i<=(j/2) && cap)
	{
		if(s[i]==s[j])
		{
			i++;
			j--;
		}	
		else cap=0;
	}	
	if(cap) printf("É capicua");
	else printf("Não é capicua");
	printf("\n");
}

int main()
{
	
/*	
	char str[50];
	printf("Escreve frase com 50 caracteres max: \n");
	fgets(str,50,stdin);
	printCap(str);
	
	char str[60];
	printf("Escreve frase com 60 caracteres max: \n");
	fgets(str,60,stdin);
	printf("Frase de entrada: %s\n",str);
	printStuff(str);
		
	int a,b,c,d,e,f;
	printf("Dá chave totoloto por ordem crescente: \n");
	scanf("%d %d %d %d %d %d",&a,&b,&c,&d,&e,&f);
	printf("\t\tBoletim do Totoloto\n");
	printToto(a,b,c,d,e,f);
		
	int a,seq[100],i=0;
	printf("Introduz nums, termina com 0\n");
	scanf("%d",&a);
	seq[i]=a;
	i++;
	while(a!=0 && i<100)
	{
		scanf("%d",&a);
		seq[i]=a;
		i++;
	}	
	printf("Escrever a sequência\n");
	printSeq(seq);
	printf("Máximo da sequência: %d\n",maxSeq(seq));
	printf("Mínimo da sequência: %d\n",minSeq(seq));
	printf("Média da sequência: %.2f\n",media(seq));
	printf("Acima da média: \n");
	printAcimaMedia(seq);
	printf("Abaixo da média: \n");
	printAbaixoMedia(seq);
	printf("MMC da Sequência: %d\n",mmcSeq(seq));
	printf("Primos da sequência: \n");
	printPrimos(seq);
*/	
 
	return 1;
}