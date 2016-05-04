close all;
clear all;
clc;

%% Create the field
% Perfect square (paire)
x = [0 10 10 0 ];
y = [0 0 10 10 ];

% sqaure with specialities
% x = [0 23 22 0 ];
% y = [0 0 20 21 ];

% Perfect square (impaire) %Toujours une petite erreur
% x = [0 21 21 0 ];
% y = [0 0 21 21 ];

% Perfect Tiangle (impaire)
% x = [0 21 11 0 ];
% y = [0 0 10 20 ];

% Perfect Tiangle (paire) %Forme complexe
% x = [0 28 10 0 ];
% y = [0 0 10 28 ];

% Shape of sail
% x = [0 20 40 0 ];
% y = [0 0 30 60 ];

% Shape of pants
% x = [0 10 21 0 ];
% y = [0 0 15 30 ];

% %Figure of the 
% figure(1);
% grid;
% axis([min(x)-1, max(x)+1, min(y)-1, max(y)+1]);
% patch(x,y,'red');
minx = min(x);

miny = min(y);

x=x-min(x);
y=y-min(y);
maxy = max(y);
maxx = max(x);

mask = poly2mask(x,y,maxy,maxx);
% figure(2);
% grid;
% imshow(mask);
im = mat2gray(mask);
sizeim = size(im);
%% Center of mass
s = regionprops(im,'centroid');
centroids = cat(1, s.Centroid);
% figure(99)
% imshow(im)
% hold on
% plot(centroids(:,1),centroids(:,2), 'b*')
% hold off

%% Copter props
length_copt = 6;
depth_copt = 4;

%% Mouvment
im = flipdim(im,1);  % Flips the rows of the im

nmbreof1 = length(find(im==1));
actualposx = 1;
actualposy = 1;
im(actualposx,actualposy) = 0.2;
sizeim = size(im);

im4 = im;

%% Adding Obsicals

% Object shape

Ox = [4 4 8 8 ];
Oy = [4 8 8 4 ];

figure(1);
grid;
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

imO = flipdim(imO,1);  % Flips the rows of the im

% %Figure of the Object (Obstical)
% figure
% imshow(imO);
% pause

nmbreof1 = length(find(im==1)); % Gives us the number of pixel land that must be done
%% Adding the obstical to the bigM


P0x = minOy;
P0y = minOx;
bigM = im;
[n,m]=size(bigM);
[n1,m1]=size(imO);
z=zeros(n,m);
z(1+P0x:n1+P0x,1+P0y:m1+P0y)=imO;
out=bigM-z;

im4 = out;
%% Adding black border
im4(sizeim(1)+1,:) = zeros;
im4(:,sizeim(2)+1) = zeros;
im4 = imrotate(im4,180);
im4(sizeim(1)+2,:) = zeros;
im4(:,sizeim(2)+2) = zeros;
im4 = imrotate(im4,180);
im = im4;
im2 = im4;
im3 = im4;
%% Priorité décendre, puis droite, puis monter, puis gauche
% Puis retour possible pour monter ou gauche

% figure(5);

actualposx = 2;
actualposy = 2;
hold on;

nmbreof1bis = nmbreof1;
for ix=1:nmbreof1bis+20

    if (im(actualposx+1,actualposy) == 1 ) % actualposx~=sizeim(1) &&
        actualposx = actualposx+1;
        im(actualposx,actualposy) = 0.5;
    elseif (im(actualposx,actualposy+1) == 1) % actualposy~=sizeim(2) &&
        actualposy = actualposy+1;
        im(actualposx,actualposy) = 0.5;
    elseif (im(actualposx-1,actualposy) == 1 )
        actualposx = actualposx-1;
        im(actualposx,actualposy) = 0.5;
    elseif (im(actualposx,actualposy-1) == 1)
        actualposy = actualposy-1;
        im(actualposx,actualposy) = 0.5;
        % elseif (im(actualposx+1,actualposy) == 0.5 ) % actualposx~=sizeim(1) &&
        %      actualposx = actualposx+1;
        %      im(actualposx,actualposy) = 0.2;
        % elseif (im(actualposx,actualposy+1) == 0.5) % actualposy~=sizeim(2) &&
        %     actualposy = actualposy+1;
        %     im(actualposx,actualposy) = 0.2;
    elseif (im(actualposx-1,actualposy) == 0.5 )
        actualposx = actualposx-1;
        nmbreof1bis = nmbreof1bis+1;
        im(actualposx,actualposy) = 0.2;
    elseif (im(actualposx,actualposy-1) == 0.5)
        actualposy = actualposy-1;
        nmbreof1bis = nmbreof1bis+1;
        im(actualposx,actualposy) = 0.2;
    else

    end

    figure(5)
    pause(0.00001);
    B = imresize(im,20);
    imshow(B);

end

%% Priorité décendre, puis droite, puis gauche puis monter,
% Puis retour possible gauche ou monter

actualposx = 2;
actualposy = 2;


nmbreof1bis = nmbreof1;
for ix=1:nmbreof1bis+20
    if (im2(actualposx+1,actualposy) == 1 ) % actualposx~=sizeim(1) &&
        actualposx = actualposx+1;
        im2(actualposx,actualposy) = 0.5;
    elseif (im2(actualposx,actualposy+1) == 1) % actualposy~=sizeim(2) &&
        actualposy = actualposy+1;
        im2(actualposx,actualposy) = 0.5;
    elseif (im2(actualposx,actualposy-1) == 1)
        actualposy = actualposy-1;
        im2(actualposx,actualposy) = 0.5;
    elseif (im2(actualposx-1,actualposy) == 1 )
        actualposx = actualposx-1;
        im2(actualposx,actualposy) = 0.5;
        % elseif (im2(actualposx+1,actualposy) == 0.5) % actualposx~=sizeim(1) &&
        %      actualposx = actualposx+1;
        %      im2(actualposx,actualposy) = 0.2;
        % elseif (im2(actualposx,actualposy+1) == 0.5) % actualposy~=sizeim(2) &&
        %     actualposy = actualposy+1;
        %     im2(actualposx,actualposy) = 0.2;
    elseif (im2(actualposx,actualposy-1) == 0.5)
        actualposy = actualposy-1;
        nmbreof1bis = nmbreof1bis+1;
        im2(actualposx,actualposy) = 0.2;
    elseif (im2(actualposx-1,actualposy) == 0.5)
        actualposx = actualposx-1;
        nmbreof1bis = nmbreof1bis+1;
        im2(actualposx,actualposy) = 0.2;
    else
        %     actualposx
        %     actualposy

    end
    figure(6);
    pause(0.00001);
    B = imresize(im2,20);
    imshow(B);
end

%% Priorité droite, puis décendre, puis monter, puis gauche
% Puis retour possible de monter ou gauche

actualposx = 2;
actualposy = 2;
% figure(7);
% hold on;
nmbreof1bis = nmbreof1;
for ix=1:nmbreof1bis+20

    if (im3(actualposx,actualposy+1) == 1) % actualposy~=sizeim(2) &&
        actualposy = actualposy+1;
        im3(actualposx,actualposy) = 0.5;
    elseif (im3(actualposx+1,actualposy) == 1 ) % actualposx~=sizeim(1) &&
        actualposx = actualposx+1;
        im3(actualposx,actualposy) = 0.5;
    elseif (im3(actualposx-1,actualposy) == 1 ) % actualposx~=1 &&
        actualposx = actualposx-1;
        im3(actualposx,actualposy) = 0.5;
    elseif (im3(actualposx,actualposy-1) == 1) % actualposy~=1 &&
        actualposy = actualposy-1;
        im3(actualposx,actualposy) = 0.5;
        % elseif (im3(actualposx,actualposy+1) == 0.5) % actualposy~=sizeim(2) &&
        %     actualposy = actualposy+1;
        %     im3(actualposx,actualposy) = 0.2;
        % elseif (im3(actualposx+1,actualposy) == 0.5) % actualposx~=sizeim(1) &&
        %      actualposx = actualposx+1;
        %      im3(actualposx,actualposy) = 0.2;
    elseif (im3(actualposx-1,actualposy) == 0.5) % actualposx~=1 &&
        actualposx = actualposx-1;
        nmbreof1bis = nmbreof1bis+1;
        im3(actualposx,actualposy) = 0.2;
    elseif (im3(actualposx,actualposy-1) == 0.5) % actualposy~=1 &&
        actualposy = actualposy-1;
        nmbreof1bis = nmbreof1bis+1;
        im3(actualposx,actualposy) = 0.2;
    else
        %     actualposx
        %     actualposy

    end

    figure(7)
    pause(0.00001);
    B = imresize(im3,20);
    imshow(B);

end

%% Chemin de retour prévu ...
im5 = im4;
actualposx = 2;
actualposy = 4;
% figure(7);
% hold on;
nmbreof1bis = nmbreof1;
for ix=1:nmbreof1bis+30
    if (mod(sizeim(2),2) ~=0)
        if (im5(actualposx,actualposy+1) == 1)
            actualposy=actualposy+1;
            im5(actualposx,actualposy) = 0.5;
        elseif (actualposy-1~=1 && im5(actualposx,actualposy-2) == 1)
            actualposy=actualposy-1;
            im5(actualposx,actualposy) = 0.5;
        elseif (im5(actualposx+1,actualposy) == 1)
            actualposx=actualposx+1;
            im5(actualposx,actualposy) = 0.5;
        elseif (im5(actualposx-1,actualposy) == 1)
            actualposx=actualposx-1;
            im5(actualposx,actualposy) = 0.5;
        elseif (im5(actualposx,actualposy-1) ==1)
            actualposy=actualposy-1;
            im5(actualposx,actualposy) = 0.5;
        elseif (im5(actualposx,actualposy+1) == 0.5)
            actualposy=actualposy+1;
            im5(actualposx,actualposy) = 0.2;
            %         elseif (actualposy-1~=1 && im5(actualposx,actualposy-2) == 0.5)
            %             actualposy=actualposy-1;
            %             im5(actualposx,actualposy) = 0.2;
            %         elseif (im5(actualposx+1,actualposy) == 0.5)
            %             actualposx=actualposx+1;
            %             im5(actualposx,actualposy) = 0.2;
        elseif (im5(actualposx,actualposy-1) ==0.5)
            actualposy=actualposy-1;
            im5(actualposx,actualposy) = 0.2;
        elseif (im5(actualposx-1,actualposy) == 0.5)
            actualposx=actualposx-1;
            im5(actualposx,actualposy) = 0.2;
        else

        end
    else
        if (im5(actualposx,actualposy+1) == 1)
            actualposy=actualposy+1;
            im5(actualposx,actualposy) = 0.5;
        elseif (im5(actualposx,actualposy-1) == 1)
            actualposy=actualposy-1;
            im5(actualposx,actualposy) = 0.5;
        elseif (im5(actualposx+1,actualposy) == 1)
            actualposx=actualposx+1;
            im5(actualposx,actualposy) = 0.5;
        elseif (im5(actualposx-1,actualposy) == 1)
            actualposx=actualposx-1;
            im5(actualposx,actualposy) = 0.5;
            %         elseif (im5(actualposx,actualposy+1) == 0.5)
            %             actualposy=actualposy+1;
            %             im5(actualposx,actualposy) = 0.2;
            %         elseif (im5(actualposx,actualposy-1) == 0.5)
            %             actualposy=actualposy-1;
            %             im5(actualposx,actualposy) = 0.2;
        elseif (im5(actualposx-1,actualposy) == 0.5)
            actualposx=actualposx-1;
            im5(actualposx,actualposy) = 0.2;
        elseif (im5(actualposx+1,actualposy) == 0.5)
            actualposx=actualposx+1;
            im5(actualposx,actualposy) = 0.2;
        else
        end


    end

    figure(8);
    pause(0.00001);
    %     im5 = imrotate(im5,90);
    B = imresize(im5,20);
    imshow(B);
end

% %% Giving unique value to the field pixels
% A = 1;
% unique_im_num = im;
% for i=1:sizeim(1)+2;
%     for j=1:sizeim(2)+2;
%         if (unique_im_num(i,j)==1)
%             unique_im_num(i,j)=A;
%             A=A+1;
%         else
%         end
%     end
% end
% 
% %Printing figure with unique cells
% figure;
% imshow(unique_im_num);