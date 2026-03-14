function [x,t,u] = calore_EI(L,N,T,K,c1,c2,f,u0)
% ----  Risoluzione dell'equazione del calore ----
%   u_t - u_xx = f nell'intervallo [-L,L] 
%   con condizioni al bordo di Dirichlet
%   e condizioni iniziali con il metodo 
%   di Eulero all'indietro
% -----------------------------------------------
% Sintassi:
%   [x,t,u]=calore_EI(L,N,T,K,c1,c2,fun,u0)
%
% Input:
%   L semiampiezza intervallo spaziale (-L,L) 
%	N numero di sottointervalli in (-L,L)
%   T estremo finale intervallo temporale (0,T)
%	K numero di sottointervalli in (0,T)
%   c1 funzione che descrive la condizione di Dirichlet in x=-L
%   c2 funzione che descrive la condizione di Dirichlet in x=L
%   f funzione che descrive il termine noto dell'equazione
%   u0 funzione che descrive la condizione iniziale in t=0
%
% Output:
%   x vettore dei nodi spaziali
%   t vettore dei nodi temporali
%   u soluzione numerica 
%     del problema

% Calcolo passo di discretizzazione in spazio e tempo
h = 2*L/N;
dt = T/K;

% Inizializzazione dei vettori t
t = linspace(0,T,K+1)';
% Inizializzazione del vettore x
x = linspace(-L,L,N+1)';

% Inizializzazione della matrice soluzione u
u = zeros(N+1,K+1);
% Condizione iniziale
u(:,1) = u0(x); 
% Condizioni al bordo
u(1,:) = c1(t);
u(end,:) = c2(t); 

% Costruzione in formato sparso della matrice A
e = ones(N-1,1); 
A = (1/h^2) * spdiags([-e 2*e -e], [-1 0 1], N-1, N-1);
I = speye(N-1);

% Ciclo iterativo
for k=1:K
    % Assemblaggio termine noto
    F = f(x(2:end-1),t(k+1));
    % Correzione del termine noto con le condizioni al bordo
    F(1) = F(1)+c1(t(k+1))/h^2;
    F(end) = F(end)+c2(t(k+1))/h^2;
    % Risoluzione del problema
    u(2:end-1,k+1) = (I + dt*A)\( u(2:end-1,k) + dt*F);
end
