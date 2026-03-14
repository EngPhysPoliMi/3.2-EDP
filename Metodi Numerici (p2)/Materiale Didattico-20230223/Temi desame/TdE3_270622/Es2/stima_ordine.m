
clear;
clc;

T=1;
K=20;
N=20;
M=4;
x0=0;
xf=1;
L=xf-x0;

u0 =@(x) sin(2*pi.*x);
f =@(x,t) (4*pi*pi-2)*exp(-2.*t).*sin(2*pi.*x);

uex =@(x,t) exp(-2.*t).*sin(2*pi.*x);

[x,t,uh] = calore(N,T,K,f,u0);

for k=1:K+1
     plot(x,uh(:,k),'-o',x,uex(x,t(k)));
     xlabel('x')
     ylabel(sprintf('u(x,t = %.1f)', t(k)))
     axis([0,1,-1,1])
     pause(0.1);
     legend('u_h','u_{ex}');
 end

e_max = zeros(M,1);
e_h = zeros(M,1);

for i=1:M
    h = 2*L/N;
    [x,t,uh] = calore(N,T,K,f,u0);
    
    [space,time] = meshgrid(x,t);
    u = uex(space,time)';
      
    e_max(i) = max(max(abs(u-uh)));
    
    e_h(i) = max(sqrt(h*sum((u-uh).^2))); 
    
    N = 2*N;
    K = 2*K; 
end

p_max = log2(e_max(1:end-1)./e_max(2:end));
p_h = log2(e_h(1:end-1)./e_h(2:end));
