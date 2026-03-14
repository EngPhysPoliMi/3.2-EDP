clear;
clc;



e_max = zeros(M,1);
e_h = zeros(M,1);

for i=1:M

    [x,t,uh] = scheme(N,K);
    
    [space,time] = meshgrid(x,t);
    u = uex(space,time)';
 
    e_max(i) = max(max(abs(u-uh))); 
    
    h = x(2)-x(1);
    e_h(i) = max(sqrt(h*sum((u-uh).^2)));

    N = 2*N;
    K = 2*K;
end

p_max = log2(e_max(1:end-1)./e_max(2:end));
p_h = log2(e_h(1:end-1)./e_h(2:end));

%{

 for k=1:K+1
     plot(x,u(:,k),'-o',x,uex(x,t(k)));
     title(sprintf('CFL = %.2f', CFL))
     xlabel('x')
     ylabel(sprintf('u(x,t = %.1f)', t(k)))
     axis([-3,3,-3,3])
     pause(0.1);
     legend('u_h','u_{ex}');
 end

%}
