clear all
close all
clc

% Cx = [25 25 10 10];
% Cy = [25 10 10 25];
%
% Cx = [10 10 25 25];
% Cy = [10 25 25 10];
%
% Cx = [10 25 25 10];
% Cy = [25 25 10 10];

Cx = [97 123 35 -12 -28 29];
Cy = [108 53 -3 11 80 21];

for loop = 1:length(Cx)
    
    [a_x1,a_x2,b_x1,b_x2] = vector_shift ([Cx(1),Cy(1)],[Cx(2),Cy(2)],3);
    
    %% extending dimention of a_x2 and b_x2
    t = (b_x2-a_x2)/norm(b_x2-a_x2);
    prolong1 = a_x2+t*10;
    prolong2 = a_x2-t*10;
    
    % Calcule de la distance à l'aide de matlab et sans
    %     dist_1 = sqrt((b_x2(1)-prolong1(1))*(b_x2(1)-prolong1(1))+(b_x2(2)-prolong1(2))*(b_x2(2)-prolong1(2)))
    %     dist_2 = sqrt((b_x2(1)-prolong2(1))*(b_x2(1)-prolong2(1))+(b_x2(2)-prolong2(2))*(b_x2(2)-prolong2(2)))
    
    dist1 = [prolong1(1),prolong1(2);b_x2(1),b_x2(2)];
    dist2 = [prolong2(1),prolong2(2);b_x2(1),b_x2(2)];
    
    t = (a_x2-b_x2)/norm(a_x2-b_x2);
    prolong3 = b_x2+t*10;
    prolong4 = b_x2-t*10;
    
    dist3 = [prolong3(1),prolong3(2);a_x2(1),a_x2(2)];
    dist4 = [prolong4(1),prolong4(2);a_x2(1),a_x2(2)];
    
    if abs(pdist(dist1,'euclidean'))>abs(pdist(dist2,'euclidean'))
        a_x2 = prolong1;
    else
        a_x2 = prolong2;
    end
    
    if abs(pdist(dist3,'euclidean'))>abs(pdist(dist4,'euclidean'))
        b_x2 = prolong3;
    else
        b_x2 = prolong4;
    end
    
    %% Début de l'itération pour chaque intersection de shift
    
    Cx = circshift(Cx',1);
    Cx = Cx';
    Cy = circshift(Cy',1);
    Cy = Cy';
     
    ax2(loop,:) = a_x2;
    bx2(loop,:) = b_x2;
    
    if loop == 1
        a_x2_first = a_x2;
        b_x2_first = b_x2;
    else
        E(loop,:) = collision(a_x2,b_x2,b_x2_last,a_x2_last);
        if loop == length(Cx)
            E(1,:) = collision(a_x2,b_x2,a_x2_first,b_x2_first);
        end
    end
    
    a_x2_last = a_x2;
    b_x2_last = b_x2;
    
end


% Ex=E(:,1);
% Ex(length(E)+1)=E(1,1);
%
% Ey=E(:,2);
% Ey(length(E)+1)=E(1,2);
% plot(Ex,Ey)


% hold off;