function [T_loc]=C_transp_loc(dphiq,Grad, w_2D,nln,BJ,beta)
%% [M_loc]=C_mass_loc(dphiq,w_2D,nln,BJ)
%==========================================================================
% Build the local mass matrix for the term (uv)
%==========================================================================
%    called in C_matrix2D.m
%
%    INPUT:
%          dphiq       : (array real) evaluation of the basis function on
%                        quadrature nodes
%          w_2D        : (array real) quadrature weights
%          nln         : (integer) number of local unknowns
%          BJ          : (array real) Jacobian of the map 
%
%    OUTPUT:
%          M_loc       :  (array real) Local mass matrix

T1_loc=zeros(nln,nln);
T2_loc=zeros(nln,nln);
T_loc=zeros(nln,nln);

for i=1:nln
    for j=1:nln
        for k=1:length(w_2D)
            Binv = inv(BJ(:,:,k));      % inverse
            Jdet = det(BJ(:,:,k));      % determinant 
            grad = Grad(k,:,j) * Binv;  % gradient base function
            T1_loc(i,j) = T1_loc(i,j) + (Jdet.*w_2D(k)) .* dphiq(1,k,i) .* grad(1);
            T2_loc(i,j) = T2_loc(i,j) + (Jdet.*w_2D(k)) .* dphiq(1,k,i) .* grad(2);
        end
    end
end
T_loc = beta(1)*T1_loc + beta(2)*T2_loc;



                                              
                                           