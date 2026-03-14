

function [A,b,T,P,u_g]=C_bound_cond2D(A,b,T,P,femregion,Dati)

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
T_0 = T;
P_0 = P;
b_0 = b - P*u_g; %rilevamento


for k = 1:length(boundary_points)
    A_0(boundary_points(k),:) = 0;
    A_0(:,boundary_points(k)) = 0;
    A_0(boundary_points(k),boundary_points(k)) = 1;
    T_0(boundary_points(k),:) = 0;
    T_0(:,boundary_points(k)) = 0;
    T_0(boundary_points(k),boundary_points(k)) = 1;
    P_0(boundary_points(k),:) = 0;
    P_0(:,boundary_points(k)) = 0;
    P_0(boundary_points(k),boundary_points(k)) = 1;    
    b_0(boundary_points(k)) = 0;

end

b = b_0;
A = A_0;
P = P_0;
T = T_0;