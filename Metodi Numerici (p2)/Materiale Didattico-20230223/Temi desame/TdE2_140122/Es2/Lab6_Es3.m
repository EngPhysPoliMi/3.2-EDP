
%% Soluzione numerica agli elementi finiti
[errors,solutions,femregion,Matrices,Dati] = C_main2D('Test1',4);

%% Test di convergenza
[errors_table,rates] = C_convergence_test('Test1');
%Nota: 'Test2' è una copia di 'Test1' dove visual_graph = 'N'.