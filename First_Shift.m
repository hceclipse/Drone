function First_points_saved = First_Shift(Cx,Cy,Shift )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Cx = [97 123 35 -12 -28 29];
% Cy = [108 53 -3 11 80 21];

Cx_init = Cx;
Cy_init = Cy;

for loop = 1:length(Cx)
    
    [a_x1,a_x2,b_x1,b_x2] = vector_shift ([Cx(1),Cy(1)],[Cx(2),Cy(2)],Shift);
    
    %% extending dimention of a_x2 and b_x2
    t = (b_x2-a_x2)/norm(b_x2-a_x2);
    prolong1 = a_x2+t*100;
    prolong2 = a_x2-t*100;
    
    % Calcule de la distance à l'aide de matlab et sans
    %     dist_1 = sqrt((b_x2(1)-prolong1(1))*(b_x2(1)-prolong1(1))+(b_x2(2)-prolong1(2))*(b_x2(2)-prolong1(2)))
    %     dist_2 = sqrt((b_x2(1)-prolong2(1))*(b_x2(1)-prolong2(1))+(b_x2(2)-prolong2(2))*(b_x2(2)-prolong2(2)))
    
    dist1 = [prolong1(1),prolong1(2);b_x2(1),b_x2(2)];
    dist2 = [prolong2(1),prolong2(2);b_x2(1),b_x2(2)];
    
    t = (a_x2-b_x2)/norm(a_x2-b_x2);
    prolong3 = b_x2+t*100;
    prolong4 = b_x2-t*100;
    
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
        
        E(loop,:) = collision2(a_x2,b_x2,b_x2_last,a_x2_last);
        if loop == length(Cx)
            E(1,:) = collision2(a_x2,b_x2,a_x2_first,b_x2_first);
        end
    end
    
    a_x2_last = a_x2;
    b_x2_last = b_x2;
    
end




Ex=E(:,1);
Ey=E(:,2);

% Changing the order of the vectors so that we have them in the same order
% than the field
for loop = 1:length(Cx)
    Ex_corresponding_Cx(loop) = Ex(length(Cx)-loop+1);
    Ey_corresponding_Cy(loop) = Ey(length(Cy)-loop+1);
    
end
Ex_corresponding_Cx = circshift(Ex_corresponding_Cx',2);
Ey_corresponding_Cy = circshift(Ey_corresponding_Cy',2);
for loop = 1:length(Cx)
    length_C_D(loop) = sqrt( (Cx(loop)-Ex_corresponding_Cx(loop))*(Cx(loop)-Ex_corresponding_Cx(loop))+(Cy(loop)-Ey_corresponding_Cy(loop))*(Cy(loop)-Ey_corresponding_Cy(loop)));
end

E = [Ex_corresponding_Cx';Ey_corresponding_Cy';length_C_D];
E = E';
First_points_saved = E';

end

