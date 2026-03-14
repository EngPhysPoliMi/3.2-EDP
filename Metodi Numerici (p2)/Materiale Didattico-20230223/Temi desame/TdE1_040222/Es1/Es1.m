
clear;
close all;
clc;

N = 60;
K=40;
MM = 4;
c=1;

u0 = @(x) exp(-(x.^2))-exp(-9);
uex = @(x,t) u0(x-c*t);

[x,t,u] = laxfriedPlot(N,K,u0);

e_max = zeros(MM,1);
e_h = zeros(MM,1);

for i=1:MM

    [x,t,uh] = laxfrie(N,K,u0);
    [space,time] = meshgrid(x,t);
    uex_D = uex(space,time)';
    
    e_max(i) = max(max(abs(uex_D-uh))); 
    
    h = x(2)-x(1);
    e_h(i) = max(sqrt(h*sum((uex_D-uh).^2)));
   
    N = 2*N;
    K = 2*K;

end

p_max = log2(e_max(1:end-1)./e_max(2:end));
p_h = log2(e_h(1:end-1)./e_h(2:end));
