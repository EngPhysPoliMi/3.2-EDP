function [x,t,u] = calore(N,T,K,f,u0)
% ----  Risoluzione dell'equazione del calore ----
%   u_t-u_xx=f nell'intervallo (0,1)x(0,T) 
%   con condizioni al bordo di Dirichlet
%   omogenee e condizioni iniziali con il 
%   metodo di Crank-Nicolson
% -----------------------------------------------
% Sintassi:
%   [x,t,u] = calore(N,T,K,fun,u0)
%
% Input:
%	N numero di sottointervalli in (0,1)
%   T estremo finale intervallo temporale (0,T)
%	K numero di sottointervalli in (0,T)
%   f  funzione che descrive il termine f dell'equazione
%   u0 funzione che descrive la condizione iniziale in t=0
%
% Output:
%   x vettore dei nodi spaziali
%   t vettore dei nodi temporali
%   u soluzione numerica 
%     del problema

% Calcolo passo di discretizzazione in spazio e tempo
h = 1/N;
dt = T/K;

% Inizializzazione del vettore t
t = linspace(0, T, K+1)';
% Inizializzazione del vettore x
x = linspace(0, 1, N+1)';

% Inizializzazione della matrice soluzione u
u = zeros(N+1,K+1);
% Riga mancante 1: Condizione iniziale

% Riga mancante 2: Condizioni al bordo

% Riga mancante 3: Costruzione in formato sparso delle matrici A ed I

% Ciclo iterativo
for k=1:K
    % Calcolo della forzante nei nodi interni per t=t(k)
    f1 = f(x(2:end-1),t(k));
    
    % Calcolo della forzante nei nodi interni per t=t(k+1)
    f2 = f(x(2:end-1),t(k+1));
    
    % Riga mancante 4: Risoluzione del problema
    
end
