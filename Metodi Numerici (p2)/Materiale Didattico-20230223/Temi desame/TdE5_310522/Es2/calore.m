function [x,t,u] = calore(N,T,K,fun,u0)

x0=0;
xf=1;
L=xf-x0;

h = L/N;
dt = T/K;

t = linspace(0,T,K+1)';
x = linspace(0,L,N+1)';

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

    F1 = fun(x(2:end-1),t(k));
    F2 = fun(x(2:end-1),t(k+1));

    F1(1) = F1(1)+c1(t(k))/h^2;
    F1(end) = F1(end)+c2(t(k))/h^2;
    F2(1) = F2(1)+c1(t(k+1))/h^2;
    F2(end) = F2(end)+c2(t(k+1))/h^2;

    u(2:end-1,k+1) = (I + dt/2*A) \ ((I - dt/2*A)*u(2:end-1,k) + dt/2*(F1+F2));
end
