function [x,t,u] = calore_CN(L,N,T,K,c1,c2,f,u0)

h = 2*L/N;
dt = T/K;

t = linspace(0,T,K+1)';
x = linspace(-L,L,N+1)';

u = zeros(N+1,K+1);
u(:,1) = u0(x); 
u(1,:) = c1(t);
u(end,:) = c2(t); 

e = ones(N-1,1); 
A = (1/h^2) * spdiags([-e 2*e -e], [-1 0 1], N-1, N-1);
I = speye(N-1);

for k=1:K

    F1 = f(x(2:end-1),t(k));
    F2 = f(x(2:end-1),t(k+1));

    F1(1) = F1(1)+c1(t(k))/h^2;
    F1(end) = F1(end)+c2(t(k))/h^2;
    F2(1) = F2(1)+c1(t(k+1))/h^2;
    F2(end) = F2(end)+c2(t(k+1))/h^2;

    u(2:end-1,k+1) = (I + dt/2*A) \ ((I - dt/2*A)*u(2:end-1,k) + dt/2*(F1+F2));
end
