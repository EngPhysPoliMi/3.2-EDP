
%% Soluzione numerica agli elementi finiti
clc; clear all; close all;
[errors,solutions,femregion,Matrices,Dati] = C_main2D('Test1',5);

%% Soluzione numerica agli elementi finiti stabilizzata con upwind
clc; clear all; close all;
[errors,solutions,femregion,Matrices,Dati] = C_main2D('Test2',3);

%% Test di convergenza
clc; clear all; close all;
[errors_table,rates] = C_convergence_test('Test3');