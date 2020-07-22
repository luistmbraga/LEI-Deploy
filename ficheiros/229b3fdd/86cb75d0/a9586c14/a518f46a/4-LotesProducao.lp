///////////////////////////////////////
//
//     Lotes de produção
//
///////////////////////////////////////
/*

Procura:

período    1   2   3   4
           2   3   4   2  artigos

Custos de produção:

período    1   2   3   4
          12  10  14  10  U.M. / artigo
          
Custos de posse de inventário:

período    1   2   3   4
           1   1   1   1  U.M. / artigo
*/

min: 12 x1 + 10 x2 + 14 x3 + 10 x4 + 1 s1 + 1 s2 + 1 s3 + 1 s4;

/* Restrições */

s0 = 0;
x1 + s0 - s1 = 2;
x2 + s1 - s2 = 3;
x3 + s2 - s3 = 4;
x4 + s3 - s4 = 2;
s4 = 0;

// Capacidade máxima de produção: 4 unidades / período

x1 <= 4;
x2 <= 4;
x3 <= 4;
x4 <= 4;

// Inventário máximo:  2 unidades

s1 <= 2;
s2 <= 2;
s3 <= 2;
s4 <= 2;
