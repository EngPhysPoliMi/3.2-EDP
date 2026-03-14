function [f_loc]=C_loc_rhs2D(force,dphiq,BJ,w_2D,pphys_2D,nln)
%% [f_loc]=C_loc_rhs2D(force,dphiq,BJ,w_2D,pphys_2D,nln)
%==========================================================================
% Build the right hand side vector (fv)
%==========================================================================
%    called in C_matrix2D.m
%
%    INPUT:
%          force       : (string) expression if the forcing term
%          dphiq       : (array real) basis functions evaluated at q.p.
%          BJ          : (array real) Jacobian of the map 
%          w_2D        : (array real) quadrature weights
%          pphys_2D    : (array real) quadrature nodes in the physical
%                                     space
%          nln         : (integer) number of local unknowns
%
%    OUTPUT:
%          f_loc           : (array real) Local right hand side


f_loc = zeros(nln,1);
% evaluation of the right hand side on the physical nodes
x = pphys_2D(:,1);
y = pphys_2D(:,2);
F = eval(force);

% Evaluation of the local r.h.s.
for s = 1:nln
    for k = 1:length(w_2D)
        Jdet = det(BJ(:,:,k));  % determinant 
        f_loc(s) = f_loc(s) + w_2D(k)*Jdet*F(k)*dphiq(1,k,s);
    end    
end
