function [g, p, be, t]=C_create_mesh_tria(Dati)
%% [g, p, be, t] = C_create_mesh_tria(Dati)
%==========================================================================
% Creates triangular mesh
%==========================================================================
%    called in C_create_mesh.m
%
%    INPUT:
%          Dati        : (struct)  see C_dati.m
%
%    OUTPUT:
%          g           : (array real) geometry of the grid
%          p           : (array real  [2 x ...] list of the grid points
%          be          : (array int)  [2 x ...] the first and second rows 
%                                     contain indices of the starting and 
%                                     ending point of the boundary edges
%          t           : (array int)  [4 x Nel] t(1:3,:) indices to
%                                     the corner points, given in counter 
%                                     clockwise order, t(4,:)contains the 
%                                     subdomain number.




switch Dati.MeshType
    %================================================
    % INITILIALIZE STRUCTURED MESH
    %================================================
    case 'TS' %
        [g,p,be,t] = C_structured_mesh(Dati.domain);
        disp('============================================================')
        disp('Triangular STRUCTURED mesh ')
        disp('============================================================')

    %================================================
    % INITILIALIZE UNSTRUCTURED MESH
    %================================================
    case 'TU' %
        [g,p,be,t] = C_unstructured_mesh(Dati.domain);
        disp('============================================================')
        disp('Triangular UNSTRUCTURED mesh ')
        disp('============================================================')
        
end
p=C_jigglemesh(p,be,t);


% %================================================
% % refinement of the mesh
% %================================================
for i= 1:Dati.nRefinement
    [p,be,t]=C_refine_mesh(g,p,be,t,'regular');
    p=C_jigglemesh(p,be,t);
end
% %================================================
%
% %================================================
% % p(1,:) --> x- coordinates of the points in the mesh
% % p(2,:) --> y- coordinates of the points in the mesh
% %================================================
%
% %================================================
% % be  -> the first and second rows contain indices
% %        of the starting and ending point of the boundary
% %        edges
% %================================================
% %================================================
% %In the triangle matrix T, the first three rows contain indices to
% %        the corner points, given in counter clockwise order, and the fourth
% %        row contains the subdomain number.
% %================================================
%
