%=======================================================================================================
% This contain all the information for running main
% TEMPLATE OF THE STRUCT DATI
%=======================================================================================================
%
%  DATI= struct( 'name',              % set the name of the test
%                'Domain',            % set the domain [x1,x2;y1,y2]
%                'exact_sol',         % set the exact solution
%                'force',             % set the spatial load
%                'grad_exact_1',      % set the first componenet of the gradient of the exact solution
%                'grad_exact_2',      % set the second componenet of the gradient of the exact solution
%                'alpha',             % coefficient of -laplacianU in the problem -alpha*laplacianU + beta* U = f
%                'beta',              % coefficient of U in the problem -alpha*laplacianU + beta* U = f
%                'fem',               % set kind of finite elements
%                'nqn_1D',            % number of quadrature nodes for integrals over lines
%                'nqn_2D',            % number of quadrature nodes for integrals over elements
%                'MeshType',          % set the elements of the mesh  'TS'
%                'refinement_vector', % set the level of refinement for the grid
%                'visual_graph',      % if you want to display the graphical results ['Y','N']
%                'print_out',         % if you want to print out the results ['Y','N']
%                'plot_errors'        % you want to plot the computed errors ['Y','N']
%
%========================================================================================================

function [DATI]=C_dati(test)

if test=='Test1'
    DATI= struct(  'name',  test,...
        'domain',           [],...
        'exact_sol',        '',...
        'force',            '',...
        'grad_exact_1',     '',...
        'grad_exact_2',     '',...
        'alpha',             0,...
        'beta',              0,...        
        'fem',              'P1',...         % Q1 - P1
        'nqn_1D',            4,...           % (1,2,3,4,5,6,.....)
        'nqn_2D',            3,...          % (1,3,4,7,10,16,64)
        'MeshType',         '', ...        % ['TS' 'TU' 'QS' 'QU']
        'refinement_vector', [3,4,5,6],...   % [0,1,2,3,4,5,6,7,....]
        'visual_graph',      'Y',...
        'print_out',         'Y',...
        'plot_errors',       'Y');
end

 

