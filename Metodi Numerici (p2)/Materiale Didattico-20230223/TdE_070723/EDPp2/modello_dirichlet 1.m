function [x,u]=modello_dirichlet(L,N,u0,uL,f)

h = L/N;
x = linspace(0,L,N+1)';

e = ones(N-1,1);
A = h^(-2) * spdiags([-e 2*e -e], [-1 0 1], N-1, N-1);

F = f(x(2:end-1));
F(1) = F(1)+u0/h^2; %Dirichlet
F(end) = F(end)+uL/h^2; %Dirichlet

u=A\F;
u=[u0;u;uL];
