function C_pointwise_sol(femregion, uh, u_ex, Dati)
%% C_pointwise_sol(femregion, uh, u_ex, Dati)
%==========================================================================
% PLOT THE EXACT SOLUTION ON THE DOFS
%==========================================================================
%    called in C_postprocessing.m
%
%    INPUT:
%          femregion   : (struct)  see C_create_femregion.m
%          uh          : (sparse(ndof,1) real) solution vector
%          u_ex        : (sparse(ndof,1) real) exact solution vector
%          Dati        : (struct) see C_Dati.m
%



% Plot soluzione numerica
figure;
C_plot(femregion, uh);
title('u_h(x,y)'); xlabel('x-axis'); ylabel('y-axis');

% Confronto sol. numerica ed esatta nei nodi
figure;
dof = femregion.dof;
stem3(dof(:,1),dof(:,2),u_ex,'-r*');
hold on
stem3(dof(:,1),dof(:,2),uh,'-ko');
title(Dati.name);
xlabel('x-axis'); ylabel('y-axis');
legend('exact', 'computed')

