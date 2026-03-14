% Esempio di utilizzo della function per la risoluzione del problema del
% calore con condizioni di Dirichlet e condizione iniziale

clear;
close all;
clc;

disp('Es 1.2')
disp('Esempio di utilizzo della function per la risoluzione del problema del')
disp('calore con condizioni di Dirichlet e condizione iniziale')

L = pi;
c1 = @(t) cos(-L)*exp(t);
c2 = @(t) cos(L)*exp(t);
u0 = @(x) cos(x);
f = @(x,t) 2*cos(x).*exp(t);
uex = @(x,t) cos(x).*exp(t);
N = 25;
T = 1;
K = 10; 
%K = 35;

% Calcolo della soluzione numerica
[x,t,u] = calore_EA(L,N,T,K,c1,c2,f,u0);
%[x,t,u] = calore_EI(L,N,T,K,c1,c2,f,u0);
%[x,t,u] = calore_CN(L,N,T,K,c1,c2,f,u0);

% Soluzione esatta
[space, time] = meshgrid(x,t);
%Oppure con griglie raffinate:
% xx = linspace(-L, L, 100);
% tt = linspace(0, 1, 200);
% [space, time] = meshgrid(xx,tt);

ues = uex(space, time);

% Rappresentazione della soluzione numerica confrontata con quella esatta
subplot(1,2,1);
mesh(t,x,u);
title('Soluzione discretizzata')
subplot(1,2,2);
mesh(time,space,ues);
title('Soluzione esatta')