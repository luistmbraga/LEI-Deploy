///////////////////////////////////////
//
//     Problema de corte de stock
//
///////////////////////////////////////

/* Função objectivo 1: minimizar o número de rolos a usar */

 min:  1 x1 + 1 x2 + 1 x3 + 1 x4 + 1 x5 + 1 x6 + 1x7;

/* Função objectivo 2: minimizar o desperdício existente nos rolos        */
/*                     satisfazendo a procura                             */

// min:         2 x2               + 4 x5 + 2 x6 ;



/* Há situações em que as duas funções objectivo conduzem à mesma solução */
/* Noutras situações, as soluções podem ser diferentes                    */


 2 x1 + x2 +   x3                    >= 200;
        x2        + 3 x4 + 2 x5 + x6 >= 300;
   x1 + x2 + 3 x3        + 1 x5 + 3 x6 + 5 x7 >= 100;
   
