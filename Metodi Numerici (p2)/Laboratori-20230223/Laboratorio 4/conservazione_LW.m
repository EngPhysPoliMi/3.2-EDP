function [x,t,u] = conservazione_LW(x0,xf,N,T,K,c,inflow,f,dfdx,dfdt,u0)
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
e = ones(N,1);
A_transp = spdiags([e, -e], [1, -1], N, N)/(2*h);
A_transp(end, end) = 1/h;
A_transp(end,end-1) = -1/h;
A_diff = spdiags([-e, 2*e, -e], [-1,0,1], N, N)/(h^2);
A_diff(end,end) = 0;
A_diff(end,end-1) = 0;
I = speye(N,N);

for k = 1:K

    % Assemblaggio termine noto
    F = f(x(2:end), t(k));
    dFdt = zeros(N,1); 
    dFdt(1:end-1) = dfdt(x(2:end-1), t(k));
    dFdx = zeros(N,1);
    dFdx(1:end-1) = dfdx(x(2:end-1), t(k));
    
    % Assegnamento della condizione di inflow
    F(1) = F(1) + (c/(2*h) + 0.5*(c^2)*dt/(h^2))*u(1,k);
    
    % Risoluzione del problema
    u(2:end,k+1) = (I-c*dt*A_transp-0.5*(c*dt)^2*A_diff)*u(2:end,k) + dt*F + 0.5*dt^2*(dFdt-c*dFdx);
end