% Esempio di utilizzo della function per la risoluzione del problema
% modello con condizioni di Dirichlet per diversi valori di Nh

clear;
close all;
clc;

disp('Es 1')
disp('Esempio di utilizzo della function per la risoluzione del problema')
disp('modello con condizioni di Dirichlet per diversi valori di Nh')

N = 40;
L = 1;
u0 = 0;
uL = 0;
f = @(x) 1+0*x;

% Calcolo della soluzione numerica
[x, uh] = modello_dirichlet(L,N,u0,uL,f);

% Vettore ausiliario per la rappresentazione della soluzione esatta
ascisse = 0:0.01:L;
% Soluzione esatta
uex = @(x) 0.5*x.*(1-x);

% Rappresentazione della soluzione numerica confrontata con quella esatta
figure
hold on
plot(x,uh,'*:', ascisse,uex(ascisse),'linewidth',2);
title('Soluzione del problema')
xlabel('x')
ylabel('u_h(x)')
legend('u_h','u_{ex}')