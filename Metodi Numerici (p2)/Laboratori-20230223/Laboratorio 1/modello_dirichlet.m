function [x,u]=modello_dirichlet(L,N,u0,uL,f)
% ----  Risoluzione dell'equazione modello ----
%   -u''=f con condizioni al bordo di Dirichlet
%   nell'intervallo [0,L]
% -----------------------------------------------
% Sintassi:
%   [x,u]=modello_dirichlet(L,N,u0,uL,fun)
%
% Input:
%   L estremo finale intervallo
%	N numero di sottointervalli in (0,L)
%   u0 condizione di Dirichlet in x=0
%   uL condizione di Dirichlet in x=L
%   f funzione che descrive il termine f dell'equazione
%
% Output:
%   x vettore dei valori della 
%     variabile indipendente
%   u soluzione numerica 
%     del problema modello

h = L/N;

% Definizione della griglia
x = linspace(0,L,N+1)';

% Costruzione in formato sparso della matrice A
e = ones(N-1,1);
A = h^(-2) * spdiags([-e 2*e -e], [-1 0 1], N-1, N-1);

% Costruzione del termine noto F
% Valutazione della forzante nei nodi interni
F = f(x(2:end-1));

% Correzione del termine noto con le condizioni al bordo
F(1) = F(1)+u0/h^2; %Dirichlet
F(end) = F(end)+uL/h^2; %Dirichlet

% Risoluzione del sistema lineare
u=A\F;
u=[u0;u;uL];
