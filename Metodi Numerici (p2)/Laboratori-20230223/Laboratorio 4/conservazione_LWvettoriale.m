function [x,t,u] = conservazione_LWvettoriale(x0,xf,N,T,K,c,inflow,f,dfdx,dfdt,u0)
% ----  Risoluzione dell'equazione di conservazione scalare ----
%   u_t+ c u_x = f nell'intervallo [x0,xf] 
%   con condizioni di inflow e condizioni iniziali.
% -----------------------------------------------
% Sintassi:
%   [x,t,u] = conservazione_template(x0,xf,N,T,K,c,inflow,f,u0)
%
% Input:
%   x0 estremo iniziale dell'intervallo spaziale
%   xf estremo finale dell'intervallo spaziale
%	N numero di sottointervalli in (x0,xf)
%   T estremo finale intervallo temporale
%	K numero di sottointervalli in (0,T)
%   c coefficiente di trasporto
%   inflow funzione che descrive la condizione di inflow in x=x0
%   f funzione che descrive il termine noto (sorgente) dell'equazione
%   dfdx, dfdt funzioni descriventi le derivate parziali di f (risp. in tempo e
%   spazio)
%   u0 funzione che descrive la condizione iniziale in t=0
%
% Output:
%   x vettore dei nodi spaziali
%   t vettore dei nodi temporali
%   u soluzione numerica 
%     del problema

% Calcolo passo di discretizzazione in spazio e tempo
h = (xf-x0)/N;
dt = T/K;

% Inizializzazione dei vettori t ed x
t = linspace(0,T,K+1)';
x = linspace(x0,xf,N+1)';

% Inizializzazione della matrice soluzione u
u = zeros(N+1, K+1);

% Condizione iniziale
u(:,1) = u0(x);
u(1,:) = inflow(t);

% Ciclo iterativo
lambda = c*dt/h; 

for k = 1:K

    % Assemblaggio termine noto e derivate per i nodi 2:end-1
    F    = f(x(2:end-1), t(k));
    dFdt = dfdt(x(2:end-1), t(k));
    dFdx = dfdx(x(2:end-1), t(k));
    
    % Risoluzione del problema per i nodi 2:end-1
    u(2:end-1,k+1) = u(2:end-1, k) ...
                     - 0.5*lambda*(u(3:end, k) - u(1:end-2, k)) ...
                     + 0.5*(lambda^2)*(u(3:end, k) -2*u(2:end-1, k) + u(1:end-2, k)) ...
                     + dt*F + 0.5*(dt^2)*(dFdt - c*dFdx);
    
    % Risoluzione del problema per l'ultimo nodo
    u(end, k+1) = u(end, k) - lambda*(u(end, k) - u(end-1, k)) + dt*f(x(end), t(k));
    
end