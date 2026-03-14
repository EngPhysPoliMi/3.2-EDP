%=======================================================================================================
% This contain all the information for running main
% TEMPLATE OF THE STRUCT DATI
%=======================================================================================================
%
%  DATI= struct( 'name',              % set the name of the test
%                'Domain',            % set the domain [x1,x2;y1,y2]
%                'force',             % set the spatial load                
%                'fem',               % set kind of finite elements
%                'nqn_1D',            % number of quadrature nodes for integrals over lines
%                'nqn_2D',            % number of quadrature nodes for integrals over elements
%                'MeshType',          % set the elements of the mesh  'TS'
%
%========================================================================================================

function [DATI] = C_dati(test)

if (test == 'Test1')
    DATI = struct(  'name', test,...
        'domain',           [0,1; 0,1],...
        'force',            '???',...
        'sigma',             0,...
        'fem',              'P1',...         % Q1 - P1
        'nqn_1D',            4,...           % (1,2,3,4,5,6,.....)
        'nqn_2D',            3,...           % (1,3,4,7,10,16,64)
        'MeshType',         '???');      % ['TS' 'TU' 'QS' 'QU']
end