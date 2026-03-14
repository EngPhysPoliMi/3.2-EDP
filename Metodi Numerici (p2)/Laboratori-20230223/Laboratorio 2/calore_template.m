function [x,t,u] = calore_template(L,N,T,K,c1,c2,f,u0)
% ----  Risoluzione dell'equazione del calore ----
%   u_t - u_xx = f nell'intervallo [-L,L] 
%   con condizioni al bordo di Dirichlet
%   e condizioni iniziali
% -----------------------------------------------
% Sintassi:
%   [x,t,u]=calore_template(L,N,T,K,c1,c2,f,u0)
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


% Inizializzazione dei vettori t


% Inizializzazione del vettore x


% Inizializzazione della matrice soluzione u


% Condizione iniziale


% Condizioni al bordo


% Costruzione in formato sparso della matrice A


% Ciclo iterativo
for k = 1:K
    
    % Assemblaggio termine noto
    
    
    % Correzione del termine noto con le condizioni al bordo
    
    
    % Risoluzione del problema
    
end