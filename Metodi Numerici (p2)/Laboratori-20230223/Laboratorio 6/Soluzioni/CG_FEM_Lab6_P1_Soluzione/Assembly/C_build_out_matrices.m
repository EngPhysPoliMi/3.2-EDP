function [Matrices]=C_build_out_matrices(A,b,u_g)
%% function [Matrices]=C_build_out_matrices(A,b,u_g)
%============================================================================
% Store matrices and vector in the struct Matrices
%============================================================================

Matrices = struct('A',A,...
                'b',b,...
                'u_g',u_g);