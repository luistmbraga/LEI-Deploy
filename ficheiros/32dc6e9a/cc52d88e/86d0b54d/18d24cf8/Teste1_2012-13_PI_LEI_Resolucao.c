#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//1

//a) r = 6;




int hotpo(int n) {

	int r=0;
	int max = n;
	
	while(n != 1)
	{	
		r++;
		if(n%2==0) n = n/2;
		else n = 3*n+1;
		
		if(n>max) max = n;
	}

	return max;
}

int edigito(char c)
{	
	int i;
	char digito[11] = "0123456789\0";
	
	for(i=0;i<11;i++)
		if (digito[i]==c)
			return 1;
	return 0;
}



int digitos(char s[])
{
	int i;
	int cont=0;
	for(i=0;i<strlen(s);i++)
		if(edigito(s[i]))
		   cont++; 
	
	return cont;
}


int acumulado(int v[],int n)
{
	int i;
	int result=0;

	for(i=0;i<n-1;i++)
		if(v[i+1]>v[i])
		   result += (v[i+1]-v[i]);	

	return result;
}


int  ultimaposicao(char s1[], char c)
{
	int i;
	for(i=strlen(s1);i>=0;i--)
		if(s1[i]==c)
		   return i;
	return 0;

}

int check(char s1[],char s2[],char c,int ind)
{
	int i;
	int j;
	printf("cehck:%d",ind);
	for(i=0;i<=ultimaposicao(s1,c);i++)
		for(j=ind+1;j<strlen(s2);j++)
			if(s1[i] == s2[j])
			{ puts("ENCONTROU");	
			  return 1;
			}
	return 0;
}

char *substr(char s1[],char s2[])
{	int ind = 0;
	int end = strlen(s1)-ultimaposicao(s1,s2[0]);
	printf("end:%d",end);
	if(strlen(s2)>strlen(s1))
		return NULL;

	if(check(s1,s2,*s2,ind)) return NULL;
		
	if(check(s1,s2,*s2,ind)==0)
		{ ++s2;
		  ind++;
		 check(s1,s2,*s2,ind);	
		}

	return s1+end-2;

}
int main()
{
	int v[5] ={100,150,120,90,110};
	printf("%d\n",hotpo(10));
	printf("%d\n",digitos("012abc3"));
	printf("%d\n",acumulado(v,5));

	printf("%s\n",substr("dabbbccdd","bdc"));	
	return 0;
	




}

/*
int main(){
	int x,y,d;
	char c;
	char direc;

	scanf("%d %d %s", &x, &y, &c);
	direc = c;

	while((scanf("%s",&c))==1)
	{
		if(c=='A'){
		   scanf("%d",&d);
		   if(direc=='N')
			 y+=d;
		   if(direc=='E')	
			 x+=d;
		   if(direc=='O')
		         x+=d;//Aqui tenho quase a certeza que se fosse SUL que eu depois tinha de subtrair? Nao sei eu meti smp a somar...
		   if(direc=='S')
			 y+=d;
		}
		else if(c=='D'){
			if(direc=='N')
				direc = 'E';
			if(direc=='E')
		                direc ='S';
			if(direc=='S')
				direc='O';
			if(direc=='O')
			        direc='N';
			}
		else if(c=='E'){
			if(direc=='N')
                                direc = 'O';
                        if(direc=='E')
                                direc ='N';
                        if(direc=='S')
                                direc='E';
                        if(direc=='O')
                                direc='S';
			}
}
	printf("%d %d %c",x,y,direc);

	return 0;
}*/
