function [A,f,T,P]=C_matrix2D(Dati,femregion)

warning off;
addpath FESpace
addpath Assembly

fprintf('============================================================\n')
fprintf('Assembling matrices and right hand side ... \n');
fprintf('============================================================\n')

ndof         = femregion.ndof;
nln          = femregion.nln;
ne           = femregion.ne;
connectivity = femregion.connectivity;

[basis] = C_shape_basis(Dati);

[nodes_2D, w_2D] = C_quadrature(Dati);

[dphiq,Grad] = C_evalshape(basis,nodes_2D);

A = sparse(ndof,ndof);
T = sparse(ndof,ndof);
f = sparse(ndof,1);

for ie = 1 : ne
     
    iglo = connectivity(1:nln,ie);

    [BJ, pphys_2D] = C_get_Jacobian(femregion.coord(iglo,:), nodes_2D, Dati.MeshType);

    [A_loc] = C_lap_loc(Grad,w_2D,nln,BJ);
    A(iglo,iglo) = A(iglo,iglo) + A_loc;

    [T_loc] = C_transp_loc(dphiq,Grad,w_2D,nln,BJ,Dati.beta);
    T(iglo,iglo) = T(iglo,iglo) + T_loc;

    [load] = C_loc_rhs2D(Dati.force,dphiq,BJ,w_2D,pphys_2D,nln);    
    f(iglo) = f(iglo) + load;
end

P = Dati.alpha * A + T;

if Dati.stabilization == "Y"
    P = P + (norm(Dati.beta)*femregion.h/2)*A;
end


