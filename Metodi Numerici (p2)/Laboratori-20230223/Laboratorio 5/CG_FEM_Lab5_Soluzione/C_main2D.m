function [femregion,Matrices,Dati] = C_main2D(TestName, nRef)
%% [errors,solutions,femregion,Matrices,Dati]=C_main2D(TestName,nRef)
%==========================================================================
% Assembling of the system matrices and right-hand side vector
%==========================================================================
%
%    INPUT:
%          Dati        : (struct)  see C_dati.m
%          nRef        : (int)     refinement level
%
%    OUTPUT:
%          femregion   : (struct) infos about finite elements
%                        discretization
%          Matrices    : (struct) fe stiffness, mass matrices and
%                        right-hand side vector
%          Dati        : (struc)  see C_dati.m
%          

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
