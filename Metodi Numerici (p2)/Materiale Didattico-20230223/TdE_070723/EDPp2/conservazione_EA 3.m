function [x,t,u] = conservazione_EA(x0,xf,N,T,K,c,inflow,f,u0)

h = (xf-x0)/N;
dt = T/K;

t = linspace(0,T,K+1)';
x = linspace(x0,xf,N+1)';

u = zeros(N+1, K+1);
u(:,1) = u0(x);
u(1,:) = inflow(t);

e = ones(N,1);
A = spdiags([e, -e], [1, -1], N, N)/(2*h);
A(end,end) = 1/h;
A(end,end-1) = -1/h;
I = speye(N);

for k = 1:K

    F = f(x(2:end), t(k));
    F(1) = F(1) + c*u(1,k)/(2*h);

    u(2:end,k+1) = (I-c*dt*A)*u(2:end,k) + dt*F;
end