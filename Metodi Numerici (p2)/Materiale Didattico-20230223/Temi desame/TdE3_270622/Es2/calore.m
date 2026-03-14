function [x,t,u] = calore(N,T,K,f,u0)

x0=0;
xf=1;
L=xf-x0;

h = 2*L/N;
dt = T/K;

t = linspace(0,T,K+1)';
x = linspace(-L,L,N+1)';

c1=@(t) 0.*t;
c2=@(t) 0.*t;

u = zeros(N+1,K+1);
u(:,1) = u0(x); 
u(1,:) = c1(t);
u(end,:) = c2(t); 

e = ones(N-1,1); 
A = (1/h^2) * spdiags([-e 2*e -e], [-1 0 1], N-1, N-1);
I = speye(N-1);

for k=1:K

    F = f(x(2:end-1),t(k+1));
    F(1) = F(1)+c1(t(k+1))/h^2;
    F(end) = F(end)+c2(t(k+1))/h^2;

    u(2:end-1,k+1) = (I + dt*A)\( u(2:end-1,k) + dt*F);
end
