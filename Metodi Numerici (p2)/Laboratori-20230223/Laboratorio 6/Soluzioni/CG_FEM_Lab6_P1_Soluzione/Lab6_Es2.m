
%% Soluzione numerica agli elementi finiti
[errors,solutions,femregion,Matrices,Dati] = C_main2D('Test1', 3);

%% Test di convergenza
[errors_table,rates] = C_convergence_test('Test2'); 
% Nota: Test2 è una copia di Test1 dove visual_graph = 'N'.