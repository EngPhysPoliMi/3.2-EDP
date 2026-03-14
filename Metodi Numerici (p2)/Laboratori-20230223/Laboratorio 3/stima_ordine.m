function [p_max,p_h] = stima_ordine(N,K,uex,M,scheme)
%   Stima dell'ordine di convergenza p di uno schema assegnato
%   per la risoluzione dell'equazione del calore
%   u_t-u_xx=f nell'intervallo [-L,L] 
%   con condizioni al bordo di Dirichlet e condizioni iniziali.
% -----------------------------------------------
% Sintassi:
%   [p_max,p_h] = stima_ordine(N,K,scheme,uex,M)
%
% Input:
%	N numero di sottointervalli in (-L,L) per la discretizzazione iniziale
%	K numero di sottointervalli in (0,T) per la discretizzazione iniziale
%   scheme metodo numerico da utilizzare, passato come funzione di N e K
%   uex funzione che descrive la soluzione esatta
%   M numero di discretizzazioni successive in spazio-tempo
%
%   Output:
%       p_max ordine di convergenza stimato con
%             norma del massimo in spazio-tempo
%       p_h ordine di convergenza stimato con
%             norma h in spazio e del massimo in tempo

e_max = zeros(M,1);
e_h = zeros(M,1);

for i=1:M
     
    % Calcolo della soluzione numerica.
    [x,t,uh] = scheme(N,K);
    
    [space,time] = meshgrid(x,t);
    u = uex(space,time)';
    
    % Calcolo dell'errore    
    e_max(i) = max(max(abs(u-uh))); % max in spazio e tempo
    
    h = x(2)-x(1);
    e_h(i) = max(sqrt(h*sum((u-uh).^2))); % norma h in spazio, max in tempo
    
    N = 2*N;
    K = 2*K;
end

% Stima dell'ordine di convergenza
p_max = log2(e_max(1:end-1)./e_max(2:end));
p_h = log2(e_h(1:end-1)./e_h(2:end));
