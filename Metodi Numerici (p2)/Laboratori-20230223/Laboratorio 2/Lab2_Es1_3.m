% Valutazione dell'ordine di convergenza quando si risolve 
% il problema del calore discretizzato con i metodi di Eulero
% all'indietro e Crank-Nicolson

clear;
close all;
clc;

disp('Es 1.3')
disp('Valutazione dell''ordine di convergenza quando si risolve')
disp('il problema del calore discretizzato con i metodi di Eulero')
disp('all''indietro e Crank-Nicolson')

L = pi;
c1 = @(t) cos(-L)*exp(t);
c2 = @(t) cos(L)*exp(t);
u0 = @(x) cos(x);
f = @(x,t) 2*cos(x).*exp(t);
N = 25;
T = 1;
K = 35;
M = 4;

% Soluzione esatta
uex = @(x,t) cos(x).*exp(t);

% Valutazione dell'ordine di convergenza p
% p_max: ordine p con norma del massimo in spazio e tempo
% p_h: ordine p con norma h in spazio e del massimo in tempo
scheme = @(L,N,T,K,c1,c2,f,u0) calore_EI(L,N,T,K,c1,c2,f,u0);
[p_max_EI,p_h_EI] = stima_ordine(L,N,T,K,c1,c2,f,u0,uex,M,scheme); % ordini p per EI

scheme = @(L,N,T,K,c1,c2,f,u0) calore_CN(L,N,T,K,c1,c2,f,u0);
[p_max_CN,p_h_CN] = stima_ordine(L,N,T,K,c1,c2,f,u0,uex,M,scheme); % ordini p per CN
