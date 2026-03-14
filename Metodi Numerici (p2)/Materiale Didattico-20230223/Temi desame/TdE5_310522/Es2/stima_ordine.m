clear;
clc;

x0=0;
xf=1;
L=xf-x0;

N=10;
K=10;
T=1;
M=4;


u0=@(x) sin(pi*x);
fun=@(x,t) (pi*pi-1)*exp(-t).*sin(pi*x);


[x,t,uh] = calore(N,T,K,fun,u0);

[space, time] = meshgrid(x,t);
uex=@(x,t) sin(pi*x).*exp(-1*t);
ues = uex(space, time);

subplot(1,2,1);
mesh(t,x,uh);
title('Soluzione discretizzata')
subplot(1,2,2);
mesh(time,space,ues);
title('Soluzione esatta')


e_max = zeros(M,1);
e_h = zeros(M,1);

for i=1:M
    h = L/N;
    [x,t,uh] = calore(N,T,K,fun,u0);
    
    [space,time] = meshgrid(x,t);
    u = uex(space,time)';
      
    e_max(i) = max(max(abs(u-uh)));
    
    e_h(i) = max(sqrt(h*sum((u-uh).^2))); 
    
    N = 2*N;
    K = 2*K; 
end

p_max = log2(e_max(1:end-1)./e_max(2:end));
p_h = log2(e_h(1:end-1)./e_h(2:end));
