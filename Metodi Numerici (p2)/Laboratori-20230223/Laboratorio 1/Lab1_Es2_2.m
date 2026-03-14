% Valutazione dell'ordine di convergenza quando si risolve 
% il problema modello discretizzato con la condizione di Neumann

clear;
close all;
clc;

disp('Es 2.2')
disp('Valutazione dell''ordine di convergenza quando si risolve')
disp('il problema modello discretizzato con la condizione di Neumann')

N = 100;
L = 1;
alpha = 0;
beta = 0;
f = @(x) 4*pi^2*cos(2*pi*x);
M = 4;

% Soluzione esatta
uex = @(x) cos(2*pi*x)-1;

% Valutazione dell'ordine di convergenza p (risp. in norma del massimo e
% norma h)

% Upwind
schema = @(L,N,alpha,beta,f) modello_misto_upwind(L,N,alpha,beta,f);
[pmax_u, ph_u] = stima_ordine_modello_misto(L,N,alpha,beta,f,uex,M,schema);

% Approssimazione centrata
schema = @(L,N,alpha,beta,f) modello_misto_centrato(L,N,alpha,beta,f);
[pmax_c, ph_c] = stima_ordine_modello_misto(L,N,alpha,beta,f,uex,M,schema);

% Approssimazione decentrata
schema = @(L,N,alpha,beta,f) modello_misto_decentrato(L,N,alpha,beta,f);
[pmax_d, ph_d] = stima_ordine_modello_misto(L,N,alpha,beta,f,uex,M,schema);