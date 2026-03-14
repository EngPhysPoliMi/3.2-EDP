function [errors,solutions,femregion,Matrices,Dati]=C_main2D(TestName,nRef)
%% [errors,solutions,femregion,Matrices,Dati]=C_main2D(TestName,nRef)
%==========================================================================
% Solution of the Poisson's problem with linear finite elements
% (non homogeneous Dirichlet boundary conditions)
%==========================================================================
%
%    INPUT:
%          Dati        : (struct)  see C_dati.m
%          nRef        : (int)     refinement level
%
%    OUTPUT:
%          errors      : (struct) contains the computed errors
%          solutions   : (sparse) nodal values of the computed and exact
%                        solution
%          femregion   : (struct) infos about finite elements
%                        discretization
%          Matrices    : (struct) fe stiffness and mass matrices
%          Dati        : (struc)  see C_dati.m
%          

warning off;
addpath MeshGeneration
addpath FESpace
addpath BoundaryConditions
addpath Assembly
addpath Postprocessing
addpath Errors

%==========================================================================
% LOAD DATA FOR TEST CASE
%==========================================================================

Dati = C_dati(TestName);
Dati.nRefinement = nRef;

%==========================================================================
% MESH GENERATION
%==========================================================================

[Region] = C_create_mesh(Dati);

%==========================================================================
% FINITE ELEMENT REGION
%==========================================================================

[femregion] = C_create_femregion(Dati,Region); 

%==========================================================================
% BUILD FINITE ELEMENT MATRICES and RIGHT-HAND SIDE
%==========================================================================

[A,b,T,P] = C_matrix2D(Dati,femregion);

%==========================================================================
% IMPOSE BOUNDARY CONDITIONS 
%==========================================================================

[A,b,T,P,u_g] = C_bound_cond2D(A,b,T,P,femregion,Dati); 

%==========================================================================
% SAVE DATA in THE STRUCT Matrices
%==========================================================================

[Matrices] = C_build_out_matrices(A,b,T,P,u_g);

%==========================================================================
% SOLVE THE LINEAR SYSTEM
%==========================================================================

%u_0 = ...

%==========================================================================
% ASSIGN DIRICHLET BOUNDARY CONDITIONS
%==========================================================================

% uh = ...

%==========================================================================
% POST-PROCESSING OF THE SOLUTION
%==========================================================================

[solutions] = C_postprocessing(Dati,femregion,uh);

%==========================================================================
% ERROR ANALYSIS
%==========================================================================

[errors] = C_compute_errors(Dati,femregion,solutions);



