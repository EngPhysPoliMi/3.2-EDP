
[femregion, Matrices, Dati] = C_main2D('Test1', 4);
A = Matrices.A;
f = Matrices.b;
u = A\f;
C_plot(femregion, u);