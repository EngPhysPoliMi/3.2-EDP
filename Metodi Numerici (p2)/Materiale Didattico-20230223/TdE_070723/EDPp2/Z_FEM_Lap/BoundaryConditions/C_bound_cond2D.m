%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Imposizione delle condizioni al contorno per il problema di
% Poisson omogeneo.
% INPUT: A matrice di stiffness
%        b vettore termine noto
%        femregion struttura contenente la matrice metrica 
% OUTPUT: A,b modificate secondo le condizioni al bordo       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [A,b]=C_bound_cond2D(A,b,femregion)
%% [A,b]=C_bound_cond2D(A,b,femregion)
%==========================================================================
% Assign Dirchlet boundary conditions
%==========================================================================
%    called in C_main2D.m
%
%    INPUT:
%          A           : (sparse(ndof,ndof) real) stiffness matrix
%          b           : (sparse(ndof,1) real) rhs vector
%          femregion   : (struct)  see C_create_femregion.m

%
%    OUTPUT:
%          A           : (sparse(ndof,ndof) real) stiffness matrix
%          b           : (sparse(ndof,1) real) rhs vector
%

fprintf('============================================================\n')
fprintf('Assign null Dirichlet boundary conditions (H_0^1 space) ... \n');
fprintf('============================================================\n')

boundary_points = femregion.boundary_points;

A_0 = A;
b_0 = b;

for k = 1:length(boundary_points)
    A_0(boundary_points(k),:) = 0;
    A_0(:,boundary_points(k)) = 0;
    A_0(boundary_points(k),boundary_points(k)) = 1;
    b_0(boundary_points(k)) = 0;
end

b = b_0;
A = A_0;
