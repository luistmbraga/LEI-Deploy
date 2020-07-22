
/*Defina uma funçãoo int remCons (char *s) que recebe uma string (terminada com o caracter '\0') e apaga todos
os caracteres iguais ao anterior. A função pretendida deverá fazer esta operação sem usar um array auxiliar
e deve retornar o comprimento da string resultante.*/


#include <stdio.h>

int remCons (char *s){

   int i=0,j=0, res=0, fim=strlen(s);
   char c;
   
   while(s[i+1]!='\0' && s[i]!='\0'){
      
      if(s[i]==s[i+1]){
        
        j=i;
        
        while(j<fim-1){
          s[j]=s[j+1];
          j++;
        }
        
        s[fim]='\0';
        fim--;
        res++;                   
      }
    
   i++;   
   }
    
   return i;
}

int main(){
    
    char s[] = "Istto ee umm tesste paara pii na uuminnho";
    
    int x=remCons(s);
    printf("Nova String: %s\nNovo Tamanho: %d\n", s, x);
    
getchar();
return 1;    
}



O programa tem um pequeno problema. Se fizer o remCons de "aaa" o resultado que sai do programa será "aa",
não deveria ser apenas "a"? Se assim for, basta alterar uma coisa. Em vez de "i++" usar
"else {i++;}" isto obrigará o programa a que, sempre que um caracter é alterado, ele testa
essa posição pelo menos 2 vezes. Se a função estiver assim (com a alteração), se se aplicar a função à
string  "ummmmmmmmmmmmm" o resultado será "um" e dirá que o tamanho é 2.



int remCons (char *s)
{
int i=0, j=0, fim=strlen(s);

while(s[i+1]!='\0' && s[i]!='\0')
{
if(s[i]==s[i+1])
{
j=i;
        while(j<fim-1)
{
s[j]=s[j+1];
j++;
}
s[fim]='\0';
fim--;
}
else
{i++;}
}
return i;
}



Para mostrar o tamanho que fica, pode-se simplificar assim:


int remCons (char *s)
{
    int cont=strlen(s);
    while(*s!='\0')
            {
                printf("\n%s",s); 
                if(s[0]==s[1]) cont--; s=s+1;}
    return cont;    
}


