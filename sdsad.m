Close all
clear all
clc

M =[    1 0 0 0 0; 
        1 1 1 0 0; 
        1 0 1 0 1; 
        0 0 1 1 1; 
        0 0 0 0 1];

[rows cols] = size(M);

y = 1:rows;
x = 1:cols;

[X Y] = meshgrid(x,y);

cY = mean(Y(M==1))
cX = mean(X(M==1))

figure
imshow(M);
hold on
plot(cX,cY, 'r*')
hold off