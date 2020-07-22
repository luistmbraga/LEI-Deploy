#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <ctype.h>



int sp (int x, int y){
	if (((x%2)==0) && (x<=y)) {return x + sp(x+2,y);}
	else if (((x%2)!=0) && (x<=y)) {return sp(x+1,y);}
	     else {return 0;}
}

int sp_int(int x, int y){
	int soma=0;
	while (x<=y){
		if ((x%2)==0){
			soma+=x;
			x+=2;
		} else {
			x++;
		  }
	}

return soma;
}

int crescente (int a[], int i, int j){

	while (i<j){
		if(a[i] > a[i+1]) return 0;
		i++;
	}
	return 1;
}

int menosFreq(int v[], int N){
	int aux[N],i,j,k,z;
	for (i = 0; i < N; i++){
		aux[i]=0;
	}
	for (i = 0; i < N; i++) {
		for (j = 0; j < N; j++)
			if (v[j]==v[i])	aux[i]++;
	}

	k=aux[0];
	z=i=0;
	
	while(i<N){
		if (aux[i]<k){
			k=aux[i];
			z=i;
		}
	i++;
	}
		return v[z];
}

void palavra (int N, char sopa[N][N], char f[N]){
		int i=0,j=0,k=0;
		char letra;

		letra = sopa[i][j];

		if (f[k]=='\0') return;
		else {
			while(f[k]!='\0') // Assumindo que o caminho é válido
			{
				if(f[k]=='D'){
					f[k]=letra; i++; letra = sopa[i][i]; k++;
				}else if (f[i]=='E'){
					f[k]=letra; i--; letra = sopa[i][i]; k++;	
				}
				else if (f[i]=='C'){
					f[k]=letra; j--; letra = sopa[i][i]; k++;
					}
				else  if (f[i]=='B'){
					 f[k]=letra; j++; letra = sopa[i][i]; k++;
					}
			}

			f[k] = letra;
			f[k++] = '\0';
		}
}

int mediana (int v[], int N) {
	int maior_i, menor_i, i, j;

	maior_i = menor_i = i = 0;

	while (i<N){
		for(j=0;j<N;j++) {
			if (v[j] < v[i]) menor_i++;
			else if (v[j] > v[i]) maior_i++;
		}

		if ((menor_i <= (N/2)) && (maior_i <= (N/2))) {
			return v[i];
		}else {
			i++;
			menor_i = maior_i = 0;
		}
	}
}
