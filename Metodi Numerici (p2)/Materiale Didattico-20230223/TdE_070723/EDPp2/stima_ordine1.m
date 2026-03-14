clear;
clc;



e_h=zeros(M,1);
e_max=zeros(M,1);

for i=1:M
    h = L/N;
    [x, uh] = scheme(L,N,alpha,beta,f);

    e_max(i) = max(abs(uh-uex(x)));
    e_h(i) = sqrt(h*sum((uh-uex(x)).^2));
    
    N = 2*N; 
end

p_max = log2(e_max(1:end-1)./e_max(2:end));
p_h = log2(e_h(1:end-1)./e_h(2:end));


%{

ascisse = 0:0.01:L;

figure
hold on
plot(x,uh,'*:', ascisse,uex(ascisse),'linewidth',2);
title('Soluzione del problema')
xlabel('x')
ylabel('u_h(x)')
legend('u_h','u_{ex}')

%}
