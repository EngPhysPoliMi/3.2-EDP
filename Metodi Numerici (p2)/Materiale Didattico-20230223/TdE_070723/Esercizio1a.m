clear;
clc;
N=60;
K=40;
u0=@(x) exp(-x.^2);
uex=@(x,t) exp(-(x-t).^2);

x0=-3;
xf=3;
T=2;
c=1;
inflow=@(t) 0.*t;
f=@(x,t) 0.*x.*t;

h = (xf-x0)/N;
dt = T/K;
t = linspace(0,T,K+1)';
x = linspace(x0,xf,N+1)';

u = zeros(N+1, K+1);
u(:,1) = u0(x);
u(1,:) = inflow(t);

e = ones(N,1);
A = spdiags([e, -e], [0, -1], N, N)/h;
I = speye(N);

for k = 1:K
    F = f(x(2:end), t(k));
    F(1) = F(1) + c*u(1,k)/h;
    u(2:end,k+1) = (I-c*dt*A)*u(2:end,k) + dt*F;
end 

for k=1:K+1
     plot(x,u(:,k),'-o',x,uex(x,t(k)));
     xlabel('x')
     ylabel(sprintf('u(x,t = %.1f)', t(k)))
     axis([-3,3,-3,3])
     pause(0.1);
     legend('u_h','u_{ex}');
 end