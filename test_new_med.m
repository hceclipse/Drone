close all
clear all
clc

% Shape that is square like
Cx = [300 300 0 0];   % X position of the vectors
Cy = [300 0 0 300];    % Y position of the vectors

% Gives us the center (or mean of the fields)
CcentreX = sum(Cx)/length(Cx);
CcentreY = sum(Cy)/length(Cy);

% Printing of the field
figure(1);
hold on;
plot(Cx,Cy,'*');
plot(CcentreX,CcentreY,'o');
nomber_pts = length(Cx);
hold off;


