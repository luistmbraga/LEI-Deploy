/* Objective function */
min: 6 x15 + 4 x13 + 4 x24 + 4 x35 + 3 x12 + 3 x23 + 3 x34 + 2 x22;

/* Variable bounds */

x15 + x13 + x12 >= 6;
x15 + x13 + x24 + x12 + x23 + x22 >= 10;
x15 + x13 + x24 + x35 + x23 + x34 >= 14;
x15 + x24 + x35 + x34 >= 9;
x15 + x35 >= 8;
