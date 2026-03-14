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

...

%==========================================================================
% FINITE ELEMENT REGION
%==========================================================================

...

%==========================================================================
% BUILD FINITE ELEMENT MATRICES (H^1 SPACE) and RIGHT-HAND SIDE
%==========================================================================

...

%==========================================================================
% IMPOSE BOUNDARY CONDITIONS - H_0^1 SPACE
%==========================================================================

...

%==========================================================================
% SAVE DATA in THE STRUCT Matrices
%==========================================================================

...