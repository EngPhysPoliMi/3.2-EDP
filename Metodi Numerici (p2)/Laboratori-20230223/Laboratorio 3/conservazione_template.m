function [x,t,u] = conservazione_template(x0,xf,N,T,K,c,inflow,f,u0)
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

% Inizializzazione dei vettori t ed x

% Inizializzazione della matrice soluzione u

% Condizione iniziale

% Ciclo iterativo

for ...

    % Assemblaggio termine noto
    
    % Assegnamento della condizione di inflow
    
    % Risoluzione del problema
    
end