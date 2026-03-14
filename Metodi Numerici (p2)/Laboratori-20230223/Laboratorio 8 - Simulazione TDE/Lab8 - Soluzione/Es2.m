% Valutazione dell'ordine di convergenza quando si risolve 
% il problema del calore discretizzato con il metodo di
% Crank-Nicolson

clear;
close all;
clc;

disp('Valutazione dell''ordine di convergenza quando si risolve')
disp('il problema del calore discretizzato con il metodo di')
disp('Crank-Nicolson')

u0 = @(x) sin(pi*x);
f = @(x,t) exp(-t).*sin(pi*x)*(pi^2-1);
N = 10;
T = 1;
K = 10;
M = 4;

% Soluzione esatta
u_ex = @(x,t) exp(-t).*sin(pi*x);

% Valutazione dell'ordine di convergenza p con norma del massimo in spazio e tempo per CN
e = zeros(M,1); %vettore degli errori
h = zeros(M,1);
dt = zeros(M,1);

% Calcolare in modo opportuno l'errore commesso nel ricavare la soluzione numerica al variare delle discretizzazioni numeriche proposte 
for i=1:M
    [x,t,uh] = calore(N,T,K,f,u0);
    [space, time] = meshgrid(x,t);
    u = u_ex(space,time)';
    
    h(i) = 1/N;
    dt(i) = 1/K;
    e(i) = max(max(abs(u-uh)));
    K = 2*K;
    N = 2*N;
end

% Stima dell'ordine di convergenza
p = log2(e(1:end-1)./e(2:end));
