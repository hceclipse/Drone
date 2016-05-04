clear all
close all
clc

%% Other way of making square shape
%
% bigM = ones(600);
% sizeim = size(bigM);
%
% % Adding black border to the bigM
% borderbigM = dL;
% bigM(sizeim(1)+borderbigM,:) = zeros; % :sizeim(1)+300
% bigM(:,sizeim(2)+borderbigM) = zeros; % :sizeim(2)+300
% bigM = imrotate(bigM,180);
% bigM(sizeim(1)+borderbigM*2,:) = zeros; % :sizeim(1)+600
% bigM(:,sizeim(2)+borderbigM*2) = zeros; % :sizeim(2)+600
% bigM = imrotate(bigM,180);
%

%% Adding shape of the field

x = [0 0 400 400];
y = [0 700 700 0];

figure(1);
grid;
axis([min(x)-1, max(x)+1, min(y)-1, max(y)+1]);
patch(x,y,'red');
minx = min(x);
miny = min(y);
x=x-min(x);
y=y-min(y);
maxy = max(y);
manx = max(x);

mask = poly2mask(x,y,maxy,manx);
im = mat2gray(mask);
sizeim = size(im);

im = flipdim(im,1);  % Flips the rows of the im

nmbreof1 = length(find(im==1)); % Gives us the number of pixel land that must be done

% figure
% imshow(im);
% pause
%% Adding Obstical

Ox = [100 100 300];
Oy = [100 200 200];

% figure(1);
% grid;
axis([min(Ox)-1, max(Ox)+1, min(Oy)-1, max(Oy)+1]);
patch(Ox,Oy,'red');
minOx = min(Ox);
minOy = min(Oy);
Ox=Ox-min(Ox);
Oy=Oy-min(Oy);
maxOy = max(Oy);
maxOx = max(Ox);

maskO = poly2mask(Ox,Oy,maxOy,maxOx);
imO = mat2gray(maskO);
sizeimO = size(imO);

%imO = flipdim(imO,1);  % Flips the rows of the im

% figure
% imshow(imO);
% pause

% nmbreof1 = length(find(im==1)); % Gives us the number of pixel land that must be done

%% Adding the obstical to the bigM

% im_borderO = imO;
% imO = imrotate(imO,180);
% im_border(sizeimO(1)+minOx,:) = zeros;
% im_border(:,sizeimO(2)+minOy) = zeros;
% im_border = imrotate(im_border,180);
% imO = im_border;
P0x = minOy;
P0y = minOx;
bigM = im;
[n,m]=size(bigM);
[n1,m1]=size(imO);
z=zeros(n,m);
z(1+P0x:n1+P0x,1+P0y:m1+P0y)=imO;
out=bigM-z;

% figure;
% imshow(out);
% pause

% out = imrotate(out,180);

% figure;
% imshow(out);
% pause

%% Adding black border to the field

bordersize = 30;
im_border = out;
im_border(sizeim(1)+1*bordersize,:) = zeros;
im_border(:,sizeim(2)+1*bordersize) = zeros;
im_border = imrotate(im_border,180);
im_border(sizeim(1)+2*bordersize,:) = zeros;
im_border(:,sizeim(2)+2*bordersize) = zeros;
im_border = imrotate(im_border,180);

bigM = im_border; % I call the field the bigM


%% Drone size
dL = 30;
dF = 20;
tinyM0 = ones(dL,dF);
tinyM = tinyM0;

[rows cols] = size(tinyM);

y = 1:rows;
x = 1:cols;

[X Y] = meshgrid(x,y);

cY = mean(Y(tinyM==1));
cX = mean(X(tinyM==1));

% Gravity center of the drone
s = regionprops(tinyM,'centroid');
centroids = cat(1, s.Centroid);
centroids = int16(centroids);



P0x = 60-cX;
P0y = 60-cY;
P0x = int16(P0x);
P0y = int16(P0y);

centroids = [centroids(1)+P0x,centroids(2)+P0y];

tinyM( tinyM==1 )=0.5;

[n,m]=size(bigM);
[n1,m1]=size(tinyM);
z=zeros(n,m);
z(1+P0x:n1+P0x,1+P0y:m1+P0y)=tinyM;
out=bigM-z;

% figure
% imshow(out)
% hold on
% plot(centroids(1),centroids(2), 'b*')
% hold off

%% Move in skew
%     tinyM = imrotate(tinyM0,135);
%     z=zeros(n,m)+0.1;
%     size(z)
%     size(tinyM)

%     figure (2)
%     hold on
% for x=1:600
%     P0x = P0x+1;
%     P0y = P0y+1;
%     z(1+P0x:n1+P0x,1+P0y:m1+P0y)=tinyM;
%     out=bigM-z;
%     imshow(out);
%     pause(0.0001)
% end
%
% hold off
%
P0x = 40;
P0y = 40;

%% Rotate with always the same gravity center (Works)
for i = 0:5:360
    tinyM = imrotate(tinyM0,i);
    tinyM = tinyM-0.5;
    
    [n,m]=size(bigM);
    [n1,m1]=size(tinyM);
    z=zeros(n,m);
    
    P0x = P0x+1;
    P0y = P0y+1;
    
    z(P0x+1-round(n1/2):P0x+n1-round(n1/2),P0y+1-round(m1/2):P0y+m1-round(m1/2))=tinyM;
    out=bigM-z;
    
    figure(5);
    hold on
    imshow(out);
    hold off
    pause(0.1)
end

%%
%
%     P0x = P0x+1;
%     z(1+P0x:n1+P0x,1+P0y:m1+P0y)=tinyM;
%     out=bigM-z;
%     figure(4)
%     imshow(out);
%     pause(0.0001)
% end


% %% Figure avec rotation
% tinyM = ones(dL,dF);
% tinyN = imrotate(tinyM,87);
% % figure
% % imshow(tinyN)
% s1 = regionprops(tinyN,'centroid');
% centroids = cat(1, s1.Centroid);
% centroids = uint8(centroids);
% [n,m]=size(bigM);
% [n1,m1]=size(tinyN);
% z=zeros(n,m);
% if (centroids(1)<=30 && centroids(2)<=30)
%     posx = centroids(1);
%     posx = 30-posx;
% else
%     posx = centroids(1);
%     posx = posx-30;
% end
%
% if (centroids(2)<=30)
%     posy = centroids(2);
%     posy = 30-posy;
% else
%     posy = centroids(2);
%     posy = posy-30;
% end
%
% z(1+posx:n1+posx,1+posy:m1+posy)=tinyN;
% % s1 = regionprops(tinyN,'centroid');
% % centroids = cat(1, s1.Centroid);
% % centroids = uint8(centroids);
% figure
% imshow(z)
% s1 = regionprops(z,'centroid');
% centroids = cat(1, s1.Centroid);
% centroids = uint8(centroids);
% hold on
% plot(centroids(1),centroids(2), 'b*')
% hold off
% % nposx = centroids(1)-30;
% % nposy = abs(30-centroids(2));
% % z=zeros(n,m);
% % dx = -nposx;
% % dy = +nposy;
% % z(1+dx:n1+dx,1+dy:m1+dy)=tinyN;
% % z( z==1 )=0.5;
% % figure
% % imshow(z)
% % out2=bigM-z;
% %
% % figure
% % imshow(out2)
% % hold on
% % plot(centroids(:,1),centroids(:,2), 'b*')
% % hold off