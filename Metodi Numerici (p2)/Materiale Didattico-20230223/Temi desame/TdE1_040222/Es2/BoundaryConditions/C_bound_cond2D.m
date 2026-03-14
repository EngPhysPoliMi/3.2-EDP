%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Imposizione delle condizioni al contorno per il problema di
% Poisson non omogeneo.
% INPUT: A matrice di stiffness
%        b vettore termine noto
%        femregion struttura contenente la matrice metrica 
% OUTPUT: A,b modificate secondo le condizioni al bordo       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [A,b,u_g] = C_bound_cond2D(A,b,femregion,Dati)
%% [A,b,u_g] = C_bound_cond2D(A,b,femregion,Dati)
%==========================================================================
% Assign Dirchlet boundary conditions
%==========================================================================
%    called in C_main2D.m
%
%    INPUT:
%          A           : (sparse(ndof,ndof) real) stiffness matrix
%          b           : (sparse(ndof,1) real) rhs vector
%          femregion   : (struct)  see C_create_femregion.m
%          Dati        : (struct)  see C_dati.m

%
%    OUTPUT:
%          A           : (sparse(ndof,ndof) real) stiffness matrix
%          b           : (sparse(ndof,1) real) rhs vector
%          u_g         : (sparse(ndof,1) real) evaluation of Dirichlet conditions 
%

fprintf('============================================================\n')
fprintf('Assign Dirichlet boundary conditions ... \n');
fprintf('============================================================\n')

ndof = length(b);
u_g = sparse(ndof,1);

boundary_points = femregion.boundary_points;
x = femregion.dof(boundary_points,1);
y = femregion.dof(boundary_points,2);
u_g(boundary_points) = eval(Dati.exact_sol);

A_0 = A;
b_0 = b - A*u_g; % rilevamento

for k = 1:length(boundary_points)
    A_0(boundary_points(k),:) = 0;
    A_0(:,boundary_points(k)) = 0;
    A_0(boundary_points(k),boundary_points(k)) = 1;
    b_0(boundary_points(k)) = 0;
end

b = b_0;
A = A_0;