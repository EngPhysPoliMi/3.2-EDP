% Esempio di utilizzo della function per la risoluzione del problema
% modello con condizioni miste per diversi valori di Nh

clear;
close all;
clc;

disp('Es 2.1')
disp('Esempio di utilizzo della function per la risoluzione del problema')
disp('modello con condizioni miste per diversi valori di Nh')

N = 100;
L = 1;
alpha = 0;
beta = 0;
f = @(x) 4*pi^2*cos(2*pi*x);

% Calcolo della soluzione numerica con i discretizzazioni 
% della derivata prima in x=0 con approssimazione upwind,
% centrata e decentrata.
% Commentare/decommentare per la scelta dello schema.

% [x, uh] = modello_misto_upwind(L,N,alpha,beta,f);
% [x, uh]=modello_misto_centrato(L,N,alpha,beta,f);
% [x, uh]=modello_misto_decentrato(L,N,alpha,beta,f);

% Soluzione esatta
uex = @(x) cos(2*pi*x)-1;

% Rappresentazione della soluzione numerica confrontata con quella esatta
figure
hold on
plot(x,uh,'*:', x,uex(x),'linewidth',2);
title('Soluzione del problema')
xlabel('x')
ylabel('u_h(x)')
legend('u_h','u_{ex}','location','southeast')