#include <stdio.h>
#include <math.h>

int vogal(char i)
{
	if(i=='a'||i=='e'||i=='i'||i=='o'||i=='u'||i=='A'||i=='E'||i=='I'||i=='O'||i=='U') return 1;
	else return 0;
}

int modulo(int k)
{
	if(k>=0) return k;
	else return (-k);	
}

int expit(int a, int b)
{
	int res=1;
	while(b>0)
	{
		res=res*a;
		b=b-1;
	}
	return res;
}

int exprec(int a, int b)
{
	if(b==0) return 1;
	else return (a*(exprec(a,b-1)));
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

int factrec(int n)
{
	if(n==1) return n;
	else return (n*factrec(n-1));	
}

int dist(int a, int b, int c, int d)
{
	return (sqrt((a-c)*(a-c)+(b-d)*(b-d)));
}

int mmcit(int a, int b)
{
	int res=0;
	if(a<b)
	{
		res=a;
		while(res%b != 0)
		{
			res+=a;
		}		
	}
	else
	{
		res=b;
		while(res%a != 0)
		{
			res+=b;
		}	
	}
	return res;
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

int simpnum(int a, int b)
{
	return (a/mdc(a,b));
}

int simpden(int a, int b)
{
	return (b/mdc(a,b));
}

int mdc(int a, int b)
{
	int res;
	while(a%b != 0)
	{
		res=a;
		a=b;
		b=res%b;
	}	
	return b;
}

int somanum(int a, int b, int c, int d)
{
	return ((a*d+c*b));
}

int somaden(int a, int b, int c, int d)
{
	return (b*d);
}

int main()
{

	int a,b,c,d;
	printf("Dá fracs: ");
	scanf("%d %d %d %d",&a,&b,&c,&d);
	printf("A soma das fracções %d/%d e %d/%d é: %d/%d \n",a,b,c,d,somanum(a,b,c,d)/mdc(somanum(a,b,c,d),somaden(a,b,c,d)),somaden(a,b,c,d)/mdc(somanum(a,b,c,d),somaden(a,b,c,d)));
	
/*	
	int a,b;
	printf("Dá fraçcão: ");
	scanf("%d %d",&a,&b);
	printf("A fracção irredutível correspondente é %d/%d\n",a/mdc(a,b),b/mdc(a,b));
	
	int a,b;
	printf("Dá nums: ");
	scanf("%d %d",&a,&b);
	printf("O mmc de %d e %d é %d\n",a,b,mmcrec(a,b));
	
	int a,b;
	printf("Dá nums: ");
	scanf("%d %d",&a,&b);
	printf("O mmc de %d e %d é %d\n",a,b,mmcit(a,b));
		
	int a,b,c,d;
	printf("Dá coords: ");
	scanf("%d %d %d %d",&a,&b,&c,&d);
	printf("A distância entre (%d,%d) e (%d,%d) é: %d \n",a,b,c,d,dist(a,b,c,d));
	
	int u;
	printf("Dá num: ");
	scanf("%d",&u);
	printf("Factorial de %d é: %d \n",u,factrec(u));
	
	int u;
	printf("Dá num: ");
	scanf("%d",&u);
	printf("Factorial de %d é: %d \n",u,factit(u));
	
	int a,b;
	printf("Dá base e exp: ");
	scanf("%d %d",&a,&b);
	printf("%d elevado a %d é %d \n",a,b,exprec(a,b));
	
	int a,b;
	printf("Dá base e exp: ");
	scanf("%d %d",&a,&b);
	printf("%d elevado a %d é %d \n",a,b,expit(a,b));
	
	int k;
	printf("Dá num: ");
	scanf("%d",&k);
	printf("O módulo é: %d\n",modulo(k));
 
	char i;
	printf("Dá letra: ");
	scanf("%c",&i);
	if(vogal(i)) printf("Vogal \n");
	else printf("Consoante \n");
*/	
	
	return 1;
}
