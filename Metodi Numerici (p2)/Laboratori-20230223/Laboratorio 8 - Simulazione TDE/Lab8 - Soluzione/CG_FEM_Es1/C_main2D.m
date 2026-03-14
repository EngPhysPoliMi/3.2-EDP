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
% ...
%==========================================================================

[femregion] = C_create_femregion(Dati,Region); 

%==========================================================================
% ...
%==========================================================================

[A,b]=C_matrix2D(Dati,femregion);

%==========================================================================
% ... 
%==========================================================================

[A,b,u_g] = C_bound_cond2D(A,b,femregion,Dati);

%==========================================================================
% SAVE DATA in THE STRUCT Matrices
%==========================================================================

[Matrices] = C_build_out_matrices(A,b,u_g);

%==========================================================================
% ...
%==========================================================================

uh = A\b;

%==========================================================================
% ...
%==========================================================================

uh = uh + u_g;

%==========================================================================
% ...
%==========================================================================

[solutions] = C_postprocessing(Dati,femregion,uh);

%==========================================================================
% ERROR ANALYSIS
%==========================================================================

[errors] = C_compute_errors(Dati,femregion,solutions);


