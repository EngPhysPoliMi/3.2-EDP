function [A,f,T,P]=C_matrix2D(Dati,femregion)
%% [A,f,M] = C_matrix2D(Dati,femregion)
%==========================================================================
% Assembly of the stiffness matrix A, rhs f and transport matrix T
%==========================================================================
%    called in C_main2D.m
%
%    INPUT:
%          Dati        : (struct)  see C_dati.m
%          femregion   : (struct)  see C_create_femregion.m
%
%    OUTPUT:
%          A           : (sparse(ndof,ndof) real) stiffness matrix
%          f           : (sparse(ndof,1) real) rhs vector
%          T          : (sparse(ndof,ndof) real) transport matrix
%          P           : (sparse(ndof,ndof) real) problem matrix
%

warning off;
addpath FESpace
addpath Assembly

fprintf('============================================================\n')
fprintf('Assembling matrices and right hand side ... \n');
fprintf('============================================================\n')


% connectivity infos
ndof         = femregion.ndof;
nln          = femregion.nln;
ne           = femregion.ne;
connectivity = femregion.connectivity;


% shape functions
[basis] = C_shape_basis(Dati);

% quadrature nodes and weights for integrals
[nodes_2D, w_2D] = C_quadrature(Dati);

% evaluation of shape bases 
[dphiq,Grad] = C_evalshape(basis,nodes_2D);


% Assembly begin ...
A = sparse(ndof,ndof);
T = sparse(ndof,ndof);
f = sparse(ndof,1);

for ie = 1 : ne
     
    iglo = connectivity(1:nln,ie);
  
    % Determinant of the Jacobian of the map and physical coordinates
    [BJ, pphys_2D] = C_get_Jacobian(femregion.coord(iglo,:), nodes_2D, Dati.MeshType);
   
    %=============================================================%
    % STIFFNESS MATRIX AND TRANSPORT MATRICES
    %=============================================================%
    [A_loc] = C_lap_loc(Grad,w_2D,nln,BJ);
    A(iglo,iglo) = A(iglo,iglo) + A_loc;

   % T = ...
    
    %==============================================
    % FORCING TERM -- RHS
    %==============================================
    [load] = C_loc_rhs2D(Dati.force,dphiq,BJ,w_2D,pphys_2D,nln);    
    f(iglo) = f(iglo) + load;
end

% P = ...

if Dati.stabilization == "Y"
    % P =
end


