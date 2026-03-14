% Valutazione dell'ordine di convergenza quando si risolve 
% il problema conservazione discretizzato con i metodi di upwind
% e Lax-Wendroff

clear;
close all;
clc;

disp('Es 2')
disp('Valutazione dell''ordine di convergenza quando si risolve')
disp('il problema conservazione discretizzato con i metodi di upwind')
disp('e Lax-Wendroff')

% Dati del problema

x0 = -3; 
xf = 3; 
T = 2;
c = 1;
N = 300;
M = 5;

h = (xf-x0)/N;
K=200;


u0 = @(x) cos(pi*x).^4 .* (abs(x) < 0.5);

%Esempio interessante: funzione C0 e non C1, come deteriorano LW e LF
%rispetto agli errori con le norme inf e h
%u0 = @(x) 2*(1-abs(x)) .* (abs(x) <= 1);

f = @(x,t) 0*x*t;
inflow = @(t) 0.*t;
dfdx = @(x,t) 0*x*t;
dfdt = @(x,t) 0*x*t;

% Soluzione esatta
uex = @(x,t) u0(x-c*t);

% Valutazione dell'ordine di convergenza p
% Upwind
schema = @(n,k) conservazione_UW(x0,xf,n,T,k,c,inflow,f,u0);
[p_max_UW,p_h_UW] = stima_ordine(N,K,uex,M,schema);

% Lax-Wendroff
schema = @(n,k) conservazione_LW(x0,xf,n,T,k,c,inflow,f,dfdx,dfdt,u0);
[p_max_LW,p_h_LW] = stima_ordine(N,K,uex,M,schema);

% Lax-Friedrichs
schema = @(n,k) conservazione_LF(x0,xf,n,T,k,c,inflow,f,u0);
[p_max_LF,p_h_LF] = stima_ordine(N,K,uex,M,schema);

%NB: durante la lezione avete visualizzato ordini leggermente diversi
% poiché è rimasto salvato su stima_ordine un'implementazione basata
% non su dimezzamenti, considerando 0.5*h e 0.5*tau, ma 0.75*h e 0.75*tau (scusate).
% Le considerazioni fatte a lezione valgono allo stesso modo, ma gli
% ordini associati ai dimezzamenti sono quelli riportati in questo codice 
% e nelle soluzioni. Quelli visti a lezione sono corretti ma convergono più 
% lentamente