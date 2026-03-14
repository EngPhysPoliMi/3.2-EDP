function C_plot_mesh(femregion)
%% C_plot_mesh(femregion)
%==========================================================================
% PLOT of THE MESH
%==========================================================================
%    called in C_postprocessing.m
%
%    INPUT:
%          femregion   : (struct)  see C_create_femregion.m

figure

ne = femregion.ne;
connectivity = femregion.connectivity;
coord = femregion.coord;
dof = femregion.dof;

for i=1:ne
  if length(connectivity(:,i)) == 4 
    fill([coord(connectivity(1,i),1) coord(connectivity(2,i),1) ...
        coord(connectivity(3,i),1) coord(connectivity(1,i),1)], ...
       [coord(connectivity(1,i),2) coord(connectivity(2,i),2) ...
        coord(connectivity(3,i),2) coord(connectivity(1,i),2)],'w')
    hold on
    tria_vertex = coord(connectivity(1:3,i),:);
    xb = sum(tria_vertex(:,1))/3;
    yb = sum(tria_vertex(:,2))/3;    
    text(xb,yb,sprintf('%d',i),'fontsize',14,'color','red');
  else

    fill([coord(connectivity(1,i),1) coord(connectivity(2,i),1) ...
        coord(connectivity(3,i),1) coord(connectivity(4,i),1) ...
        coord(connectivity(1,i),1)], ...
       [coord(connectivity(1,i),2) coord(connectivity(2,i),2) ...
        coord(connectivity(3,i),2) coord(connectivity(4,i),2) ...
        coord(connectivity(1,i),2)],'w')
  end
  hold on
end

hold on
for t=1:size(dof,1)
    text(dof(t,1),dof(t,2),sprintf('%d',t),'fontsize',14,'color','blue');
end

axis equal
axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel','')
set(gca,'YTick',[])
set(gca,'YTickLabel','')