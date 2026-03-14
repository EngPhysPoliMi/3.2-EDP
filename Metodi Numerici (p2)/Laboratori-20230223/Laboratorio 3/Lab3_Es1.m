% Esempio di utilizzo della function per la risoluzione del problema
% conservazione con condizioni di inflow e condizione iniziale

clear;
close all;
clc;

disp('Es 1')
disp('Esempio di utilizzo della function per la risoluzione del problema')
disp('conservazione con condizioni di inflow e condizione iniziale')

% Dati del problema

x0 = -3; 
xf = 3; 
T = 2;
N = 60;
CFL = 0.5;
c = 1;

h = (xf-x0)/N;
dt = CFL*h/c;
K = T/dt; %K = 10 con CFL = 2; K = 40 con CFL = 0.5

u0 = @(x) cos(pi*x).^4 .* (abs(x) <= 0.5);
f = @(x,t) 0*x.*t;
inflow = @(t) 0*t;

% Soluzione esatta
uex = @(x,t) u0(x-c*t);

% Calcolo della soluzione numerica
% [x,t,u] = conservazione_EA(x0,xf,N,T,K,c,inflow,f,u0);
% [x,t,u] = conservazione_UW(x0,xf,N,T,K,c,inflow,f,u0);
 [x,t,u] = conservazione_EI(x0,xf,N,T,K,c,inflow,f,u0);

% Rappresentazione della soluzione numerica confrontata con quella esatta
 for k=1:K+1
     plot(x,u(:,k),'-o',x,uex(x,t(k)));
     title(sprintf('CFL = %.2f', CFL))
     xlabel('x')
     ylabel(sprintf('u(x,t = %.1f)', t(k)))
     axis([-3,3,-3,3])
     pause(0.1);
     legend('u_h','u_{ex}');
 end