clear;
clc;

x0=0;
xf=1;
L=xf-x0;

T=1;
N=20;
K=20;
M=4;

u0=@(x) sin(2*pi*x);
fun=@(x,t) (4*pi*pi-2)*exp(-2*t).*sin(2*pi*x);

[x,t,uh] = calore(N,T,K,fun,u0); % EI
%[x,t,uh] = calore_EA(N,T,K,fun,u0);

[space, time] = meshgrid(x,t);
uex=@(x,t) exp(-2*t).*sin(2*pi*x);
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
    % Calcolo della soluzione numerica.
    [x,t,uh] = calore(N,T,K,fun,u0);
    
    [space,time] = meshgrid(x,t);
    u = uex(space,time)';
    
    % Calcolo dell'errore    
    e_max(i) = max(max(abs(u-uh))); % max in spazio e tempo
    
    e_h(i) = max(sqrt(h*sum((u-uh).^2))); % norma h in spazio, max in tempo
    
    N = 2*N;
    K = 2*K; %E se K = 4*K?
end

% Stima dell'ordine di convergenza
p_max = log2(e_max(1:end-1)./e_max(2:end));
p_h = log2(e_h(1:end-1)./e_h(2:end));
