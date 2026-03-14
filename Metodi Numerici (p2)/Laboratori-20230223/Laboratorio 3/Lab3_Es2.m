% Valutazione dell'ordine di convergenza quando si risolve 
% il problema conservazione discretizzato con il metodo di upwind

clear;
close all;
clc;

disp('Es 2')
disp('Valutazione dell''ordine di convergenza quando si risolve')
disp('il problema conservazione discretizzato con il metodo di upwind')

% Dati del problema

x0 = -3; 
xf = 3; 
T = 2;
c = 1;
CFL = 0.5;
N = 300;
M = 4;

h = (xf-x0)/N;
dt = CFL*h/c;
K = T/dt;

u0 = @(x) cos(pi*x).^4.* (abs(x) <= 0.5);
f = @(x,t) 0*x.*t;
inflow = @(t) 0*t;

% Soluzione esatta
uex = @(x,t) u0(x-c*t);

% Valutazione dell'ordine di convergenza p
% Upwind
schema = @(n,k) conservazione_UW(x0,xf,n,T,k,c,inflow,f,u0);
[p_max_UW,p_h_UW] = stima_ordine(N,K,uex,M,schema);