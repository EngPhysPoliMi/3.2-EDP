clear
clc

N=8;
alpha=1;
beta=0;

fun=@(x,t) pi*pi.*cos(pi.*x);

[x, uh] = diffusione(N, alpha, beta, fun);

uex=@(x,t) x+cos(pi.*x);

x0=0;
xf=1;
L=xf-x0;
ascisse = 0:0.01:L;

hold on
plot(x,uh,'*:', ascisse, uex(ascisse),'linewidth',2);
title('Soluzione del problema')
xlabel('x')
ylabel('u_h(x)')
legend('u_h','u_{ex}')
