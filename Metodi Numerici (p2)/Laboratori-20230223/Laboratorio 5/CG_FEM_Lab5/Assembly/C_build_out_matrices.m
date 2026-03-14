function [Matrices]=C_build_out_matrices(A,b)
%% function [Matrices]=C_build_out_matrices(A,M,b)
%============================================================================
% Store matrices and vector in the struct Matrices
%============================================================================

Matrices = struct('A',A,...
                'b',b);