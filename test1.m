close all
clear all
clc


[X,Y] = meshgrid(-2:.2:2);
Z = X.*exp(-X.^2 - Y.^2);
[DX,DY] = gradient(Z,.2,.2);

% Plot
subplot(2,1,1)
quiver(X,Y,DX,DY)
set(gca,'Xlim', [-2.5 2.5], 'Ylim',[-2.5 2.5])
% Index just some vectors
idx = 1:10;
subplot(2,1,2)
quiver(X(:,idx),Y(:,idx),DX(:,idx),DY(:,idx))
set(gca,'Xlim', [-2.5 2.5], 'Ylim',[-2.5 2.5])
