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
% x = [0 11 11 0 ];
% y = [0 0 11 11 ];

% Perfect Tiangle (impaire)
% x = [0 21 11 0 ];
% y = [0 0 10 20 ];

% Perfect Tiangle (paire) %Forme complexe
% x = [0 12 7 0 ];
% y = [0 0 7 12 ];

% Shape of sail
% x = [0 5 15 0 ];
% y = [0 0 10 20 ];

% fun shape
% x = [0 10 10 0];
% y = [0 5 10 10];

% fun shape
x = [0 1 0 5 3 5]*4;
y = [0 3 5 5 3 0]*4;

% %Figure of the
figure(1);
grid;
axis([min(x)-1, max(x)+1, min(y)-1, max(y)+1]);
patch(x,y,'red');
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
% im(actualposx,actualposy) = 0.2;
sizeim = size(im);

im4 = im;

%% Adding Obsicals

% Object shape
% Square
% Ox = [4 4 8 8 ];
% Oy = [4 8 8 4 ];

%Triangle
Ox = [4 4 8 8 ];
Oy = [4 8 4 4 ];

figure(11);
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

    figure(2)
    pause(0.00001);
    B = imresize(im,20);
    imshow(B);

end

%% Priorité décendre, puis diagnoale, puis droite, puis monter, puis diagonale, puis gauche
% Puis retour possible pour monter ou gauche

% figure(5);

actualposx = 2;
actualposy = 2;
im = im4;
nmbreof1bis = nmbreof1;
for ix=1:nmbreof1bis+20

    if (im(actualposx+1,actualposy) == 1 ) % actualposx~=sizeim(1) &&
        actualposx = actualposx+1;
        im(actualposx,actualposy) = 0.5;
    elseif (im(actualposx+1,actualposy+1) == 1 )
        actualposx = actualposx+1;
        actualposy = actualposy+1;
        im(actualposx,actualposy) = 0.5;
    elseif (im(actualposx,actualposy+1) == 1) % actualposy~=sizeim(2) &&
        actualposy = actualposy+1;
        im(actualposx,actualposy) = 0.5;
    elseif (im(actualposx-1,actualposy) == 1 )
        actualposx = actualposx-1;
        im(actualposx,actualposy) = 0.5;
    elseif (im(actualposx-1,actualposy-1) == 1 )
        actualposx = actualposx-1;
        actualposy = actualposy-1;
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
    elseif (im(actualposx-1,actualposy-1) == 0.5 )
        actualposx = actualposx-1;
        actualposy = actualposy-1;
        im(actualposx,actualposy) = 0.2;
    elseif (im(actualposx,actualposy-1) == 0.5)
        actualposy = actualposy-1;
        nmbreof1bis = nmbreof1bis+1;
        im(actualposx,actualposy) = 0.2;
    else

    end

    figure(3)
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
    figure(4);
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

    figure(5)
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

    figure(6);
    pause(0.00001);
    %     im5 = imrotate(im5,90);
    B = imresize(im5,20);
    imshow(B);
end

%% Giving unique value to the field pixels
A = 1;
unique_im_num = im4;
for i=1:sizeim(1)+2;
    for j=1:sizeim(2)+2;
        if (unique_im_num(i,j)==1)
            unique_im_num(i,j)=A;
            A=A+1;
        else
        end
    end
end

%Printing figure with unique cells
% figure;
% imshow(unique_im_num);
unique_im_num_notulterd = unique_im_num;
% B = imresize(unique_im_num,20);
% imshow(B);

%% Tests with randomisation and 4 diffrents neighbor

% 4 voisins
Best_done = 5;
for x = 1:2000
    unique_im_num = unique_im_num_notulterd;
    pathtaken = [];
    for y = 1:200
        if y == 1
            start_point = [2,2];
            actualposx = start_point(1);
            actualposy = start_point(2);
        end
        numberneighbor = 0;
        neighbor =[];
        if (unique_im_num(actualposx+1,actualposy) > 0)
            numberneighbor = numberneighbor+1;
            neighbor(numberneighbor) = unique_im_num(actualposx+1,actualposy);
            %         else
            %             neighbor(1) = -2;
            %             display(neighbor(1));
        end
        if (unique_im_num(actualposx,actualposy+1) > 0)
            numberneighbor = numberneighbor+1;
            neighbor(numberneighbor) = unique_im_num(actualposx,actualposy+1);
            %         else
            %             neighbor(2) = -2;
            %             display(neighbor(2));
        end
        if (unique_im_num(actualposx-1,actualposy) > 0)
            numberneighbor = numberneighbor+1;
            neighbor(numberneighbor) = unique_im_num(actualposx-1,actualposy);

            %         else
            %             neighbor(3) = -2;
            %             display(aneighbor(3));
        end
        if (unique_im_num(actualposx,actualposy-1) > 0)
            numberneighbor = numberneighbor+1;
            neighbor(numberneighbor) = unique_im_num(actualposx,actualposy-1);
            %         else
            %             neighbor(4) = -2;
            %             neighbor(4)= 0
            %             display(neighbor(4));
        end
        %         neighborsize = size(neighbor)

        %         if isempty(neighbor)
        %             break;
        %         end
        %
        %         if size(find(neighbor==0))>0
        %         end

        %         X = randi(size(neighbor,2));
        if numberneighbor == 0
            break;
        end


        X = randi(numberneighbor);
        [newposx,newposy] = find(unique_im_num==neighbor(X));

        if (unique_im_num_notulterd(actualposx,actualposy)) > 0
            pathtaken = [pathtaken unique_im_num_notulterd(actualposx,actualposy)];
        end

        actualposx = newposx;
        actualposy = newposy;

        unique_im_num(newposx,newposy) = -1;



%                         figure(10);
%                         B = imresize(unique_im_num,10);
%                         imshow(B);
%                         pause(0.0001)

        % Memo of the best way found

    end
    Just_done = length(pathtaken);
    if Best_done < Just_done
        best_path_taken = pathtaken;
        Best_done = length(pathtaken);
    else

    end
end

%% Doing the best path

unique_im_num2 = unique_im_num_notulterd;
for x=1:length(best_path_taken)
    [newposx,newposy] = find(unique_im_num2==best_path_taken(x));
    unique_im_num2(newposx,newposy) = -1;
    figure(10);
    B = imresize(unique_im_num2,10);
    imshow(B);
    pause(0.1)
    %     [newposx, newposy]
end

%% Tests with randomisation and 8 diffrents neighbors
Best_done = 5;
for x = 1:2000
    unique_im_num = unique_im_num_notulterd;
    pathtaken = [];
    for y = 1:200
        if y == 1
            start_point = [2,2];
            actualposx = start_point(1);
            actualposy = start_point(2);
        end
        
        
        %8 voisins
        numberneighbor = 0;
        neighbor =[];
        if (unique_im_num(actualposx+1,actualposy) > 0)
            numberneighbor = numberneighbor+1;
            neighbor(numberneighbor) = unique_im_num(actualposx+1,actualposy);
        end
        if (unique_im_num(actualposx,actualposy+1) > 0)
            numberneighbor = numberneighbor+1;
            neighbor(numberneighbor) = unique_im_num(actualposx,actualposy+1);
        end
        if (unique_im_num(actualposx+1,actualposy+1) > 0)
            numberneighbor = numberneighbor+1;
            neighbor(numberneighbor) = unique_im_num(actualposx+1,actualposy+1);
        end
        if (unique_im_num(actualposx-1,actualposy) > 0)
            numberneighbor = numberneighbor+1;
            neighbor(numberneighbor) = unique_im_num(actualposx-1,actualposy);
        end
        if (unique_im_num(actualposx,actualposy-1) > 0)
            numberneighbor = numberneighbor+1;
            neighbor(numberneighbor) = unique_im_num(actualposx,actualposy-1);
        end
        if (unique_im_num(actualposx-1,actualposy-1) > 0)
            numberneighbor = numberneighbor+1;
            neighbor(numberneighbor) = unique_im_num(actualposx-1,actualposy-1);
        end
        if (unique_im_num(actualposx+1,actualposy-1) > 0)
            numberneighbor = numberneighbor+1;
            neighbor(numberneighbor) = unique_im_num(actualposx+1,actualposy-1);
        end
        if (unique_im_num(actualposx-1,actualposy+1) > 0)
            numberneighbor = numberneighbor+1;
            neighbor(numberneighbor) = unique_im_num(actualposx-1,actualposy+1);
        end
        %         X = randi(size(neighbor,2));
        %         [newposx,newposy] = find(unique_im_num==neighbor(X));
        %
        %         unique_im_num(newposx,newposy) = -1;
        %
        %         actualposx = newposx
        %         actualposy = newposy
        %
        %         figure(10);
        %         B = imresize(unique_im_num,10);
        %         imshow(B);
        %     end
        % end
        %
        
        if numberneighbor == 0
            break;
        end
        
        
        X = randi(numberneighbor);
        [newposx,newposy] = find(unique_im_num==neighbor(X));
        
        if (unique_im_num_notulterd(actualposx,actualposy)) > 0
            pathtaken = [pathtaken unique_im_num_notulterd(actualposx,actualposy)];
        end
        
        actualposx = newposx;
        actualposy = newposy;
        
        unique_im_num(newposx,newposy) = -1;
        
        
        %
        %                         figure(10);
        %                         B = imresize(unique_im_num,10);
        %                         imshow(B);
        %                         pause(0.1)
        %
        %         Memo of the best way found
        
    end
    Just_done = length(pathtaken);
    if Best_done < Just_done
        best_path_taken = pathtaken;
        Best_done = length(pathtaken);
    else
        
    end
end

%% Doing the best path

unique_im_num2 = unique_im_num_notulterd;
for x=1:length(best_path_taken)
    [newposx,newposy] = find(unique_im_num2==best_path_taken(x));
    unique_im_num2(newposx,newposy) = -1;
    figure(11);
    B = imresize(unique_im_num2,10);
    imshow(B);
    pause(0.1)
%     [newposx, newposy]
end


% %% Algorithme du marchand 4 neighbor
%
% start_point = [2,2];
% actualposx = start_point(1);
% actualposy = start_point(2);
%
% numberneighbor = 0;
% if (unique_im_num(actualposx+1,actualposy) > 0)
%     neighbor(1) = unique_im_num(actualposx+1,actualposy);
%     numberneighbor = numberneighbor+1;
% end
% if (unique_im_num(actualposx,actualposy+1) > 0)
%     neighbor(2) = unique_im_num(actualposx,actualposy+1);
%     numberneighbor = numberneighbor+1;
% end
% if (unique_im_num(actualposx-1,actualposy) > 0)
%     neighbor(3) = unique_im_num(actualposx-1,actualposy);
%     numberneighbor = numberneighbor+1;
% end
% if (unique_im_num(actualposx,actualposy-1) > 0)
%     numberneighbor = numberneighbor+1;
%     neighbor(4) = unique_im_num(actualposx,actualposy-1);
% end
%
