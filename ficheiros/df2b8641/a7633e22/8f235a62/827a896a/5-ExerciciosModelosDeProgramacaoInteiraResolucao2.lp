
/* nova situação */
min: 7 x1 + 20 y1
   + 4 x2 + 40 y2
   + 8 x3 + 10 y3
   + 1 x4 + 70 y4;

x1 <= 500 y1;
x2 <= 200 y2;
x3 <= 400 y3;
x4 <= 600 y4;

y1 + y2 + y3 + y4 <= 3;

x1 + x2 + x3 + x4 = 1000;

x4 >= 500 y4;


int x1, x2, x3, x4;
bin y1, y2, y3, y4;



