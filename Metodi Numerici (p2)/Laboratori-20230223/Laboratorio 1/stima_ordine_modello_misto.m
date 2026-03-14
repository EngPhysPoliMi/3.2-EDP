function [p_max, p_h] = stima_ordine_modello_misto(L,N,alpha,beta,f,uex,M,scheme)
%   Stima dell'ordine di convergenza p
%   per la risoluzione dell'equazione modello
%   -u''=f con condizione al bordo di Neumann
%   in x = 0 e di Dirichlet in x = L
%   con discretizzazione della condizione di Neumann
%   mediante approssimazione upwind.
% -----------------------------------------------
% Sintassi:
%   p = stima_ordine_modello_misto(L,N,alpha,beta,f,uex,M,scheme)
%
% Input:
%   L estremo finale intervallo
%	N numero di sottointervalli in (0,L)
%   alpha condizione di Neumann in x=0
%   beta condizione di Dirichlet in x=L
%   f funzione che descrive il termine f dell'equazione
%   uex funzione che descrive la soluzione esatta
%   M numero di stime del passo di discretizzazione
%   scheme funzione che implementa lo schema numerico in studio.
%          Deve essere della forma, [x,u] = scheme(L,N,alpha,beta,f),
%          ad es. scheme = modello_misto_upwind
%
%   Output:
%       p_max ordine di convergenza stimato con
%             norma del massimo
%       p_h ordine di convergenza stimato con
%             norma h

e_h=zeros(M,1);
e_max=zeros(M,1);

for i=1:M
    h = L/N;
    % Calcolo della soluzione numerica con le discretizzazioni 
    % della derivata prima in x=0 con approssimazione upwind.
    
    [x, uh] = scheme(L,N,alpha,beta,f);
    
    % Calcolo dell'errore
    
    e_max(i) = max(abs(uh-uex(x))); % max
    e_h(i) = sqrt(h*sum((uh-uex(x)).^2));% norma h
    
    N = 2*N; % Dimezzamento di h
end

% Stima dell'ordine di convergenza
p_max = log2(e_max(1:end-1)./e_max(2:end));
p_h = log2(e_h(1:end-1)./e_h(2:end));
