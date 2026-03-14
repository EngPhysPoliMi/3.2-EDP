function [x,u] = modello_misto_decentrato(L,N,alpha,beta,f)
% ----  Risoluzione dell'equazione modello ----
%   -u''=f con condizione al bordo di Neumann
%   in x = 0 e di Dirichlet in x = L
% -----------------------------------------------
% Sintassi:
%   [x,u] = modello_misto_decentrato(L,N,alpha,beta,f)
%
% Input:
%   L estremo finale intervallo
%	N numero di sottointervalli in (0,L)
%   alpha condizione di Neumann in x=0
%   beta condizione di Dirichlet in x=L
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
e = ones(N,1);
A = h^(-2) * spdiags([-e 2*e -e], [-1 0 1], N, N);
A(1,1) = -3/(2*h);
A(1,2) = 2/h;
A(1,3) = -1/(2*h);

% Costruzione del termine noto f
% Valutazione della forzante nei nodi incogniti
F = f(x(1:end-1));

% Correzione del termine noto con le condizioni al bordo
F(1) = alpha; %Neumann
F(end) = F(end)+beta/h^2; %Dirichlet

% Risoluzione del sistema lineare
u = A\F;
u = [u; beta];