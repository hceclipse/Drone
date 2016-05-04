clear all
close all
clc

x = [1, 4, 4, 1, 1];
y = [1, 1, 4, 4, 1];

figure(1);
plot(x,y);
axis([0, 5, 0, 5]);

%%
figure(2);
plot(1, 1, '.r', 'MarkerSize',69)
%%

% Create a logical image of a circle with specified
% diameter, center, and image size.
% First create the image.
imageSizeX = 640;
imageSizeY = 480;
[columnsInImage rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
% Next create the circle in the image.
centerX = 320;
centerY = 240;
radius = 100;
circlePixels = (rowsInImage - centerY).^2 ...
    + (columnsInImage - centerX).^2 <= radius.^2;
%square = (1, 4, 4, 1) + (1, 1, 4, 4);
% circlePixels is a 2D "logical" array.
% Now, display it.
figure(3);
image(circlePixels) ;
colormap([0 0 0; 1 1 1]);
title('Binary image of a circle');

%%
t = (1/16:1/8:1)'*2*pi;
x = cos(t);
y = sin(t);

figure(4);
h = fill(x,y,'r');
%axis square

saveas(h,'square.jpg') ;

figure(5);
A = imread('square.jpg');
image(A);
im = rgb2gray(A)
figure(6);
imshow(im);

seuil = {0,0,0};
im = im==76;
figure(7);
imshow(im);


%%
x = [0 4 4 0];
y = [0 0 4 4];
figure(10);
patch(x,y,'red')
