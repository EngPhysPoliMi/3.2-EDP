function [x,t,u] = conservazione_EA(x0,xf,N,T,K,c,inflow,f,u0)
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
A = spdiags([e, -e], [1, -1], N, N)/(2*h);
A(end,end) = 1/h;
A(end,end-1) = -1/h;
I = speye(N);

for k = 1:K

    % Assemblaggio termine noto
    F = f(x(2:end), t(k));
    
    % Assegnamento della condizione di inflow
    F(1) = F(1) + c*u(1,k)/(2*h);
    
    % Risoluzione del problema
    u(2:end,k+1) = (I-c*dt*A)*u(2:end,k) + dt*F;
end