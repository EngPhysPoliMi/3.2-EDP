clear;
clc;
[errors,solutions,femregion,Matrices,Dati]=C_main2D('Esame',3);
[errors_table,rates] = C_convergence_test('Esame'); 