#include <stdio.h>

int hotpo (int n) {
    int r = 0;
    while (n != 1) {
        r++;
        if (n%2 == 0) n = n/2;
        else n = 3*n + 1;
    }
    return r;
}

/*
hotpo | n = 10, r = 1
      | n =  5, r = 2
      | n = 16, r = 3
      | n =  8, r = 4
      | n =  4, r = 5 
      | n =  2, r = 6 
      | n =  1 -> Retorna 6
*/

int hotpo2(int n)
{
    int max = n;
    while (n != 1) {
        if (n % 2 == 0)
            n = n / 2;
        else
            n = 3*n + 1;

        if (n > max)
            max = n;
    }
    
    return max;
}

int digitos(char s[])
{
    int i, c = 0;

    for(i = 0; s[i] != '\0'; i++)
        if (s[i] >= '0' && s[i] <= '9')
            c++;

    return c;
}

int acumulado(int altitude[], int n)
{
    int i, total;
    for(i = 1; i < n; i++)  
        if (altitude[i] > altitude[i - 1])
            total += altitude[i] - altitude[i - 1];

    return total;
}
            
char *substr(char s1[], char s2[])
{
    int i, j = 0;
    
    for(i = 0; s1[i] != '\0'; i++){
        if (s2[j] == '\0')
            return s1 + i;

        if (s1[i] == s2[j])
            j++;
    }
    return NULL;
}


