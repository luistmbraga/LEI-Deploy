#include <stdio.h>
#include <math.h>

int soma(int a, int b)
{
	return (a+b);
}

int segs(int h,int m, int s)
{
	return (h*3600+m*60+s);
}

float temp(float t)
{
	return (1.8*t+32);
}

int horas(int s)
{
	return (s/3600);
}

int minutos(int s)
{
	return ((s%3600)/60);
}

int segundos(int s)
{
	return ((s%3600)%60);
}

int max2(int a,int b)
{	
	if(a>=b) return a;
	else return b;
}

int vogal(char i)
{
	if(i=='a'||i=='e'||i=='i'||i=='o'||i=='u'||i=='A'||i=='E'||i=='I'||i=='O'||i=='U') return 1;
	else return 0;
}

int even(int j)
{
	if(j%2==0) return 1;
	else return 0;
}

int modulo(int k)
{
	if(k>=0) return k;
	else return (-k);	
}

int expo(int a, int b)
{
	int exp=1;
	while(b>0)
	{
		exp=exp*a;
		b--;	
	}
	return exp;
}
	
int factrec(int n)
{
	if(n==1) return n;
	else return (n*factrec(n-1));	
}

int factit(int n)
{
	int q=1;
	while(n>0)
	{
		q=q*n;
		n--;	
	}
	return q;
}


int main()
{
	

	int y=0;
	while(y<=300)
	{
		printf("%d Cº -> %.1f Fº \n",y,1.8*y+32);
		y=y+5;
	}	
	
/*	
	float v,x;
	char w;
	printf("Dá op: ");
	scanf("%f %c %f",&v,&w,&x);
	if (w=='/' && (v==0 || x==0)) printf("Unless you are Chuck Norris you can not divide by 0 \n");
	if(w!='+' && w!='-' && w!='*' && w!='/') printf("Erro operando \n");
	if(w=='+') printf("%1.2f%c%1.2f=%1.2f\n",v,w,x,v+x);
	if(w=='-') printf("%1.2f%c%1.2f=%1.2f\n",v,w,x,v-x);
	if(w=='*') printf("%1.2f%c%1.2f=%1.2f\n",v,w,x,v*x);
	if(w=='/') printf("%1.2f%c%1.2f=%1.2f\n",v,w,x,v/x);
	
	int u;
	printf("Dá num: ");
	scanf("%d",&u);
	printf("Factorial de %d é: %d \n",u,factit(u));
	
	int u;
	printf("Dá num: ");
	scanf("%d",&u);
	printf("Factorial de %d é: %d \n",u,factrec(u));
		
	int a,b;
	printf("Dá base e exp: ");
	scanf("%d %d",&a,&b);
	printf("%d elevado a %d é %d \n",a,b,expo(a,b));
	
	int l,n=0;
	printf("Dá num:");
	scanf("%d",&l);
	printf("Pares ate %d: \n",l);
	while(n<=l)
	{
		printf("%d ",n);
		n+=2;
	}
	printf("\n");
		
	int k;
	printf("Dá num: ");
	scanf("%d",&k);
	printf("O módulo é: %d\n",modulo(k));
	
	int j;
	printf("Dá num: ");
	scanf("%d",&j);
	if(even(j)) printf("PAR \n");
	else printf("IMPAR \n");
	
	char i;
	printf("Dá letra: ");
	scanf("%c",&i);
	if(vogal(i)) printf("Vogal \n");
	else printf("Consoante \n");
	
	int f,g;
	printf("Dá nums, termina com 0: ");
	scanf("%d",&g);
	f=g;
	while(g!=0)
	{
		printf("Dá nums, termina com 0: ");
		scanf("%d",&g);
		if(g>f) f=g;	
	}
	printf("O maior lido foi: %d\n",f);
		
	int a,b;
	printf("Dá nums: ");
	scanf("%d %d",&a,&b);
	printf("O maior é: %d\n",max2(a,b));	
		
	int segs;
	printf("Dá segs: ");
	scanf("%d",&segs);
	printf("%2d:%2d:%2d \n",horas(segs),minutos(segs),segundos(segs));
		
	float t;
	printf("Dá temp em Celsius: ");
	scanf("%f",&t);
	printf("A temp em fahrenheit é %f\n",temp(t));
	
	int h,m,s;
	printf("Dá hora: ");
	scanf("%d %d %d",&h,&m,&s);
	printf("A hora em segundos é %d\n",segs(h,m,s));

	int a,b;
	printf("Dá nums: ");
	scanf("%d %d",&a,&b);
	printf("A soma é: %d\n",soma(a,b));
	
	printf("Hello World !!\n");
*/
	
	return 1;	
}

