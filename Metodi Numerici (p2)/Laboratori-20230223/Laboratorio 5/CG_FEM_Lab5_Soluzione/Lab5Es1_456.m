
M = 4;
raffinamenti = 2:(2+M); % 5 livelli di raffinamento
A_cond = zeros(M,1);
normf = zeros(M,1);
h = zeros(M,1);

for k = 1:M
    [femregion,Matrices,Dati] = C_main2D('Test1', raffinamenti(k));
    A_cond(k) = cond(Matrices.A);
    normf(k) = norm(Matrices.b);
    h(k) = femregion.h;
end


figure(1)
loglog(h, A_cond, 'linewidth', 2);
hold on
loglog(h, h.^(-2), 'linewidth', 2);
legend('cond(A)', 'h');

figure(2)
loglog(h, normf, 'linewidth', 2);
hold on
loglog(h, h, 'linewidth', 2);
legend('||f||', 'h');
