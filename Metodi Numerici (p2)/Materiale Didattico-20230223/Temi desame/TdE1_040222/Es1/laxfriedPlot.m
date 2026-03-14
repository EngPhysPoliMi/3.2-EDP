function [x,t,u] = laxfriedPlot(N,K,u0)
x0 = -3; 
xf = 3; 
T = 2;
c = 1;
uex = @(x,t) u0(x-c*t);

h = (xf-x0)/N;
dt = T/K;

t = linspace(0,T,K+1)';
x = linspace(x0,xf,N+1)';

f = @(x,t) 0*x*t;
inflow = @(t) 0.*t;

u = zeros(N+1, K+1);
u(:,1) = u0(x);
u(1,:) = inflow(t);

e = ones(N,1);
A = spdiags([e, -e], [1, -1], N, N)/(2*h);
A(end,end) = 1/h;
A(end,end-1) = -1/h;
M = 0.5*spdiags([e, e], [1, -1], N, N);
M(end, end) = 1;
M(end, end-1) = 2;

for k = 1:K

    F = f(x(2:end), t(k));
    F(1) = F(1) + c*u(1,k)/(2*h) + 0.5*u(1,k)/dt;
    
    u(2:end,k+1) = (M-c*dt*A)*u(2:end,k) + dt*F;
end

for k=1:K+1
     plot(x,u(:,k),'-o',x,uex(x,t(k)));
     xlabel('x')
     ylabel(sprintf('u(x,t = %.1f)', t(k)))
     axis([-3,3,-3,3])
     legend('u_h','u_{ex}');
     pause(0.1);
end