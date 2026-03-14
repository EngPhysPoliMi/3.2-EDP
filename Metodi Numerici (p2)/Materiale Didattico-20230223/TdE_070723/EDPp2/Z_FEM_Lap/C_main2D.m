function [femregion,Matrices,Dati] = C_main2D(TestName, nRef)

warning off;
addpath MeshGeneration
addpath FESpace
addpath BoundaryConditions
addpath Assembly

%==========================================================================
% LOAD DATA FOR TEST CASE
%==========================================================================

Dati = C_dati(TestName);
Dati.nRefinement = nRef;

%==========================================================================
% MESH GENERATION
%==========================================================================

Region = C_create_mesh(Dati);

%==========================================================================
% FINITE ELEMENT REGION
%==========================================================================

femregion = C_create_femregion(Dati, Region); 

%==========================================================================
% BUILD FINITE ELEMENT MATRICES (H^1 SPACE) and RIGHT-HAND SIDE
%==========================================================================

[A,f] = C_matrix2D(Dati,femregion);

%==========================================================================
% IMPOSE BOUNDARY CONDITIONS - H_0^1 SPACE
%==========================================================================

[A,f] = C_bound_cond2D(A,f,femregion);

%==========================================================================
% SAVE DATA in THE STRUCT Matrices
%==========================================================================

[Matrices] = C_build_out_matrices(A, f);
