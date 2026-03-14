clear;
clc;



e_max = zeros(M,1);
e_h = zeros(M,1);

for i=1:M
    h = L/N;
    [x,t,uh] = scheme(L,N,T,K,c1,c2,f,u0);
    
    [space,time] = meshgrid(x,t);
    u = uex(space,time)';
      
    e_max(i) = max(max(abs(u-uh)));
    
    e_h(i) = max(sqrt(h*sum((u-uh).^2))); 
    
    N = 2*N;
    K = 2*K; 
end

p_max = log2(e_max(1:end-1)./e_max(2:end));
p_h = log2(e_h(1:end-1)./e_h(2:end));


%{

xx = linspace(..., ..., 100);
tt = linspace(0, ..., 200);
[space, time] = meshgrid(xx,tt);

ues = uex(space, time);

subplot(1,2,1);
mesh(t,x,u);
title('Soluzione discretizzata')
subplot(1,2,2);
mesh(time,space,ues);
title('Soluzione esatta')

%}
