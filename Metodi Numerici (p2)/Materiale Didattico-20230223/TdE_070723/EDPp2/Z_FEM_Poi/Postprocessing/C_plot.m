function C_plot(femregion, vh)
%% C_plot(femregion, vh)
%==========================================================================
% PLOT AN FUNCTION IN THE FE SPACE GIVEN ITS VALUES ON THE VERTICES
%==========================================================================
%
%    INPUT:
%          femregion   : (struct)  see C_create_femregion.m
%          vh          : (sparse(ndof,1) real) vector containing the
%                                              function values

trisurf(femregion.connectivity(1:3,:)',femregion.coord(:,1),femregion.coord(:,2),full(vh));
xlabel('x-axis');
ylabel('y-axis'); 
colorbar;