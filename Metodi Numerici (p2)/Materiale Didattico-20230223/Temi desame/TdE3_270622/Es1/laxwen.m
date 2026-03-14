function [x,t,u] = laxwen(N,K,u0)

x0=-2;
xf=2;
T=2;
c=1;

inflow =@(t) 0.*t;
f =@(x,t) 0.*x.*t;
dfdx =@(x,t) 0.*x.*t;
dfdt =@(x,t) 0.*x.*t;

h = (xf-x0)/N;
dt = T/K;

t = linspace(0,T,K+1)';
x = linspace(x0,xf,N+1)';

u = zeros(N+1, K+1);
u(:,1) = u0(x);
u(1,:) = inflow(t);

e = ones(N,1);
A_transp = spdiags([e, -e], [1, -1], N, N)/(2*h);
A_transp(end, end) = 1/h;
A_transp(end,end-1) = -1/h;
A_diff = spdiags([-e, 2*e, -e], [-1,0,1], N, N)/(h^2);
A_diff(end,end) = 0;
A_diff(end,end-1) = 0;
I = speye(N,N);

for k = 1:K

    F = f(x(2:end), t(k));
    dFdt = zeros(N,1); 
    dFdt(1:end-1) = dfdt(x(2:end-1), t(k));
    dFdx = zeros(N,1);
    dFdx(1:end-1) = dfdx(x(2:end-1), t(k));
    F(1) = F(1) + (c/(2*h) + 0.5*(c^2)*dt/(h^2))*u(1,k);

    u(2:end,k+1) = (I-c*dt*A_transp-0.5*(c*dt)^2*A_diff)*u(2:end,k) + dt*F + 0.5*dt^2*(dFdt-c*dFdx);
end