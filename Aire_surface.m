clear all
close all
clc

%% Defining the shape of our field

% Shape that is square like
Cx = [-1 7 4 6 3 -1];   % X position of the vectors
Cy = [2 5 3 -1 1 2];    % Y position of the vectors;
Aire_surf = 0;
for loop = 1:length(Cx)-1
    Aire_surf = Cx(loop)*Cy(loop+1)-Cx(loop+1)*Cy(loop)+ Aire_surf;
end
A = (1/2)*Aire_surf

Gx1 = 0;
for loop = 1:length(Cx)-1
    Gx1 =(Cx(loop)+Cx(loop+1))*(Cx(loop)*Cy(loop+1)-Cx(loop+1)*Cy(loop))+ Gx1
end
Gx = (1/(6*A))*Gx1

Gy1 = 0;
for loop = 1:length(Cx)-1
    Gy1 =((Cy(loop)+Cy(loop+1))*(Cx(loop)*Cy(loop+1)-Cx(loop+1)*Cy(loop)))+ Gy1
end
Gy = (1/(6*A))*Gy1