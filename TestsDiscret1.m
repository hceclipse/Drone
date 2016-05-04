close all
clear all
clc

Cx = [1 2 3 4];   % X position of the vectors
Cy = [1 2 3 4];    % Y position of the vectors

for x=1:4

Cx = circshift(Cx',1)
Cx = Cx';
Cy = circshift(Cy',1);
Cy = Cy';
end