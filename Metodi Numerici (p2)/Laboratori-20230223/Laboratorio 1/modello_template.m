function [x,u]=modello_template(L,N,c0,cL,f)
% ----  Risoluzione dell'equazione modello ----
%   -u''=f con condizioni al bordo di Dirichlet/
%   Neumann nell'intervallo [0,L]
% -----------------------------------------------
% Sintassi:
%   [x,u]=modello_template(L,N,c0,cL,f)
%
% Input:
%   L estremo finale intervallo
%	N numero di sottointervalli in (0,L)
%   c0 condizione di Dirichlet/Neumann in x=0
%   cL condizione di Dirichlet/Neumann in x=L
%   f funzione che descrive il termine f dell'equazione
%   u0 condizione iniziale
%
% Output:
%   x vettore dei valori della 
%     variabile indipendente
%   u soluzione numerica 
%     del problema modello




% Costruzione della matrice A

% Costruzione del termine noto f

% Correzione termine noto con termine condizione al bordo

% Risoluzione del sistema lineare



