% Costruzione delle mesh e dei corrispondenti spazi FE

clc; clear all; close all;

addpath MeshGeneration
addpath FESpace
addpath Postprocessing

dati = struct('name',        'Esempio',...
              'domain',      [-1,1; -1,1],...
              'fem',         'P1',...       
              'nqn_1D',      4,...
              'nqn_2D',      3,...
              'MeshType',    'TS', ... 
              'nRefinement', 2 ...
              );
          
region = C_create_mesh(dati);
femregion = C_create_femregion(dati, region);

figure(1)
C_plot_mesh(femregion);

figure(2)
subplot(1,2,1)
j = 9;
phij = zeros(femregion.ndof, 1);
phij(j) = 1;
C_plot(femregion, phij);
axis([-1,1,-1,1,0,2])
title("\phi_{j}")
subplot(1,2,2)
vh = rand(femregion.ndof,1);
% Oppure paraboloide f(x,y) = x^2 + y^2
% vh = region.coord(:,1).^2 + region.coord(:,2).^2;
C_plot(femregion, vh);
title("Random function in V_{h}")
% title("Paraboloide in V_{h}");
axis([-1,1,-1,1,0,2])