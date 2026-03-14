%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Imposizione delle condizioni al contorno per il problema di
% Poisson non omogeneo.
% INPUT: A matrice di stiffness
%        b vettore termine noto
%        M matrice di massa
%        P matrice del problema
%        femregion struttura contenente la matrice metrica 
% OUTPUT: A,b,M,P modificate secondo le condizioni al bordo       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [A,b,M,P,u_g]=C_bound_cond2D(A,b,M,P,femregion,Dati)
%% [A,b,M,P,u_g]=C_bound_cond2D(A,b,M,P,femregion,Dati)
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
%          M           : (sparse(ndof,ndof) real) mass matrix
%          P           : (sparse(ndof,ndof) real) problem matrix
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
M_0 = M;
P_0 = P;
b_0 = b; %rilevamento


for k = 1:length(boundary_points)
    A_0(boundary_points(k),:) = 0;
    A_0(:,boundary_points(k)) = 0;
    A_0(boundary_points(k),boundary_points(k)) = 1;
    M_0(boundary_points(k),:) = 0;
    M_0(:,boundary_points(k)) = 0;
    M_0(boundary_points(k),boundary_points(k)) = 1;
    P_0(boundary_points(k),:) = 0;
    P_0(:,boundary_points(k)) = 0;
    P_0(boundary_points(k),boundary_points(k)) = 1;    
    b_0(boundary_points(k)) = 0;
end

b = b_0;
A = A_0;
M = M_0;
P = P_0;