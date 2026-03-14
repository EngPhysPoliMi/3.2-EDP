function [A_loc]=C_lap_loc(Grad,w_2D,nln,BJ)
%% [A_loc]=C_lap_loc(Grad,w_2D,nln,BJ)
%==========================================================================
% Build the local stiffness matrix for the term grad(u)grad(v)
%==========================================================================
%    called in C_matrix2D.m
%
%    INPUT:
%          Grad        : (array real) evaluation of the gradient on
%                        quadrature nodes
%          w_2D        : (array real) quadrature weights
%          nln         : (integer) number of local unknowns
%          BJ          : (array real) Jacobian of the map 
%
%    OUTPUT:
%          A_loc       :  (array real) Local stiffness matrix


A_loc=zeros(nln,nln);

for i=1:nln
    for j=1:nln
        for k=1:length(w_2D)
            Binv = inv(BJ(:,:,k));   % inverse
            Jdet = det(BJ(:,:,k));   % determinant 
            A_loc(i,j) = A_loc(i,j) + (Jdet.*w_2D(k)) .* ( (Grad(k,:,i) * Binv) * (Grad(k,:,j) * Binv )');
        end
    end
end



                                              
                                              

