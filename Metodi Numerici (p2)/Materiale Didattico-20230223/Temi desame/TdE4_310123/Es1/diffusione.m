function [x, u] = diffusione(N, alpha, beta, fun)

x0=0;
xf=1;
L=xf-x0;

h = L/N;
x = linspace(0,L,N+1)';

e = ones(N,1);
A = h^(-2) * spdiags([-e 2*e -e], [-1 0 1], N, N);
A(1,1) = -1/h;
A(1,2) = 1/h;

F = fun(x(1:end-1));
F(1) = alpha; %Neumann
F(end) = F(end)+beta/h^2; %Dirichlet

u = A\F;
u = [u; beta];