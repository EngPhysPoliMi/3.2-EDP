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
c = 1;

h = (xf - x0)/N;
K = 40;
dt = T/K;

% Esempio: (N=40, K=15) -> Dispersitività LF non trascurabile

u0 = @(x) cos(pi*x).^4 .* (abs(x) <= 0.5);

% Alternativa di sotto utile negli schemi diffusivi per osservare 
% smoothing di punti angolosi causati da viscosità numerica:

%u0 = @(x) 2*(1-abs(x)) .* (abs(x) <= 1);

f = @(x,t) 0*x;
inflow = @(t) 0*t;
dfdx = @(x,t) 0*x.*t;
dfdt = @(x,t) 0*x.*t;

% Soluzione esatta
uex = @(x,t) u0(x-c*t);

% Calcolo della soluzione numerica

%[x,t,uh] = conservazione_UW(x0,xf,N,T,K,c,inflow,f,u0);

%NB: si può scegliere l'approccio preferito solo per metodi espliciti come
%LW
[x,t,u] = conservazione_LW(x0,xf,N,T,K,c,inflow,f,dfdx,dfdt,u0);
% [x,t,u] = conservazione_LWvettoriale(x0,xf,N,T,K,c,inflow,f,dfdx,dfdt,u0);
%[x,t,u] = conservazione_LWibrido(x0,xf,N,T,K,c,inflow,f,dfdx,dfdt,u0);

%[x,t,u] = conservazione_LF(x0,xf,N,T,K,c,inflow,f,u0);

% Rappresentazione della soluzione numerica confrontata con quella esatta 
for k=1:K+1
     plot(x,u(:,k),'-o',x,uex(x,t(k)));%,x,uh(:,k),'-og');
     title(sprintf('CFL = %.2f', c*T*N/(K*(xf-x0))))
     xlabel('x')
     ylabel(sprintf('u(x,t = %.1f)', t(k)))
     axis([-3,3,-3,3])
     legend('u_h','u_{ex}');%, 'u_{h,UW}');
     pause(0.1);
end