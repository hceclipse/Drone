clear all
close all
clc

%% Defining the shape of our field

% Shape that is square like
Cx = [300 300 0 0];   % X position of the vectors
Cy = [300 0 0 300];    % Y position of the vectors

% % Shape that is prysme like
% Cx = [300 100 0 0];   % X position of the vectors
% Cy = [300 0 0 100];    % Y position of the vectors

% % Shape that is square like in the other rotation
% Cx = [300 0 0 300];   % X position of the vectors
% Cy = [300 300 0 0];    % Y position of the vectors

% % Shape that is square like shifted in space
% Cx = [0 0 300 300];   % X position of the vectors
% Cy = [0 300 300 0];    % Y position of the vectors

% % Shape that is square like
% Cx = [100 100 0 0];   % X position of the vectors
% Cy = [200 0 0 200];    % Y position of the vectors

% % Shape that is square like flat
% Cx = [300 300 0 0];   % X position of the vectors
% Cy = [100 0 0 100];    % Y position of the vectors

% % Shape that is square like flat
% Cx = [600 600 0 0];   % X position of the vectors
% Cy = [50 0 0 50];    % Y position of the vectors

% % Shape that is square like flat 2
% Cx = [800 0 0 400];   % X position of the vectors
% Cy = [50 50 0 0];    % Y position of the vectors

% % Shape that is square like tall
% Cx = [100 100 0 0];   % X position of the vectors
% Cy = [300 0 0 300];    % Y position of the vectors

% % Shape with 5 corners
% Cx = [200 0 -100 0 100];   % X position of the vectors
% Cy = [150 200 100 0 50];    % Y position of the vectors

% % Shape with 5 corners
% Cx = [200 0 -100 0 100];   % X position of the vectors
% Cy = [150 200 100 0 50];    % Y position of the vectors

% % Test concave shape
% Cx = [0 0 200 30]
% Cy = [0 200 200 150]

% % Test concave shape 4 borders horaire
% Cx = [200 200 0 0];
% Cy = [200 0 0 100];

% % Test concave shape 4 borders anti-horaire
% Cx = [200 0 0 200];
% Cy = [200 200 0 0];

% % Prysme
% Cx = [100,50,0,50];
% Cy = [50,0,50,100];

% Saving the original points that make the field
Cx_init = Cx;
Cy_init = Cy;

% Gives us the center (or mean of the fields)
CcentreX = sum(Cx)/length(Cx);
CcentreY = sum(Cy)/length(Cy);

% Printing of the field
figure(1);
hold on;
plot(Cx,Cy);
plot(CcentreX,CcentreY,'o');
nomber_pts = length(Cx);


%% Gives the center of mass of the field

len_Cx = length(Cx);
Cx(len_Cx+1) = Cx(1);
len_Cy = length(Cy);
Cy(len_Cy+1) = Cy(1);

Aire_surf = 0;
for loop = 1:length(Cx)-1
    Aire_surf = Cx(loop)*Cy(loop+1)-Cx(loop+1)*Cy(loop)+ Aire_surf;
end
A = (1/2)*Aire_surf;

Gx1 = 0;
for loop = 1:length(Cx)-1
    Gx1 =(Cx(loop)+Cx(loop+1))*(Cx(loop)*Cy(loop+1)-Cx(loop+1)*Cy(loop))+ Gx1;
end
Gx = (1/(6*A))*Gx1;

Gy1 = 0;
for loop = 1:length(Cx)-1
    Gy1 =((Cy(loop)+Cy(loop+1))*(Cx(loop)*Cy(loop+1)-Cx(loop+1)*Cy(loop)))+ Gy1;
end
Gy = (1/(6*A))*Gy1;

% Turnes back the values of Cx and Cy to initail values
Cy = Cy_init;
Cx = Cx_init;
plot(Gx,Gy,'o');
hold off;
%% To  have the medians that we wil keep and use

figure(2);
hold on;

% TODO change the size of that thing .... 4 if for simple square ...
Median_saved = zeros(2,len_Cx);

for loop = 1:nomber_pts
    
    %     % Show the vector of the first loop
    %     for iter = 1:nomber_pts-1
    %         C = [Cx(iter) Cy(iter)];
    %         Cnext = [Cx(iter+1) Cy(iter+1)];
    %         nd = (Cnext-C)./norm(Cnext-C); %normalize
    %         nd = (Cnext-C);
    %         % Show vector betwin the points
    %             quiver(C(1),C(2),nd(1),nd(2))
    %             pause(0.9)
    %     end
    
    % quiver(C(1),C(2),nd(1),nd(2))
    
    C1 = [Cx(1) Cy(1)]; % C1 <--- is always the point we look at
    C2 = [Cx(2) Cy(2)];
    C_last = [Cx(nomber_pts) Cy(nomber_pts)];
    
    
    % Vector betwin befor and last point
    M1 = (C_last-C2);
    Median_vect_C2_C_last = M1/2;
    % show the vector betwin the one before and the one after form the one after
    %     quiver(C2(1),C2(2),M1(1),M1(2));
    % Gives the midium point with vectors (no problems of slopes with
    % divisions with 0!
    mPointx = C2(1)+Median_vect_C2_C_last(1);
    mPointy = C2(2)+Median_vect_C2_C_last(2);
    
    %     % Gives the eqasion of the line C2-C_last
    %     slopeM = (C2(2)-C_last(2))/(C2(1)-C_last(1));
    %     b = (-C2(1))*slopeM+C2(2);
    %
    %     % Plot the line betwin the point befor and the last
    %     %     x = min(C2(1),C_last(1)):max(C2(1),C_last(1));
    %     %     plot(x, slopeM*x+b);
    %
    %     % Intermediat point of the two points
    %     % TODO peut être fait de façon
    %     % vectorielle
    %     mPointx = (max(C2(1),C_last(1))+min(C2(1),C_last(1)))/2;
    %     mPointy = mPointx*slopeM+b;
    
    % Plot of the point
    %     plot(mPointx,mPointy ,'*');
    
    % Saving the point
    mPoint = [mPointx mPointy];
    
    % Plot vector betwin
    Median = mPoint-C1;
    Vecort_C1_Median = Median/2;
    quiver(C1(1),C1(2),Median(1),Median(2))
    % TODO  here we can give the direction if testes befor (cocave or convex)
    % Gives the midium point with vectors (no problems of slopes with
    % divisions with 0!
    %     mPointx = C1(1)+Vecort_C1_Median(1);
    %     mPointy = C1(2)+Vecort_C1_Median(2);
    %
    %     plot(mPointx,mPointy,'o')
    
    %     % Line of the median
    %     slopeMed = (C1(2)-mPoint(2))/(C1(1)-mPoint(1));
    %     bMed = (-C1(1))*slopeMed+C1(2);
    %
    %     % Plot median line
    %     x = min(C1(1),mPoint(1)):max(C1(1),mPoint(1));
    %     %         plot(x, slopeMed*x+bMed);
    
    % Shift of the point on the median
    
    shift_int = mPoint-C1;
    shift_int_2 = C1-mPoint;
    shift6 = C1+(shift_int/norm(shift_int))*6;
    shift6_2 = C1+(shift_int/norm(shift_int))*-6;
    plot(shift6(1),shift6(2),'*');
    plot(shift6_2(1),shift6_2(2),'x');
    % Sauvegarde of the next point
    % Cx(1) = shift6(1);
    % Cy(1) = shift6(2);
    
    % % Shift dans les points
    Cx = circshift(Cx',1);
    Cx = Cx';
    Cy = circshift(Cy',1);
    Cy = Cy';
    
    % is one point concave ?
    % if ti is we must invers it
    
    %     %Cette méthode ne fonctionne pas, car elle est mauvaise !!!
    %     direction_vector = [Gx,Gy;shift6(1),shift6(2)];
    %     di_1 = pdist(direction_vector,'euclidean');
    %     direction_vector2 = [Gx,Gy;shift6_2(1),shift6_2(2)];
    %     di_2 = pdist(direction_vector2,'euclidean');
    %
    %     if di_1 <= di_2;
    %         shift6 = shift_int/norm(shift_int);
    %         Median_saved(:,1) = shift6;
    %         Median_saved = circshift(Median_saved',1);
    %         Median_saved = Median_saved';
    %     else
    %         shift6_2 = shift_int_2/norm(shift_int_2);
    %         Median_saved(:,1) = shift6_2;
    %         Median_saved = circshift(Median_saved',1);
    %         Median_saved = Median_saved';
    %     end
    
    %     % Pas une bonne méthode non plus ...
    %     angle = acos(dot((C2-C1),(C_last-C1)) / (norm(C2-C1)*norm(C_last-C1)));
    %     angle = (angle/(pi))*180;
    %     if angle <= 90;
    %         shift6 = shift_int/norm(shift_int);
    %         Median_saved(:,1) = shift6;
    %         Median_saved = circshift(Median_saved',1);
    %         Median_saved = Median_saved';
    %     else
    %         shift6_2 = shift_int_2/norm(shift_int_2);
    %         Median_saved(:,1) = shift6_2;
    %         Median_saved = circshift(Median_saved',1);
    %         Median_saved = Median_saved';
    %     end
    
    % On va chercher à savoir si l'on est bien dans notre figure et pas à
    % l'extérieur de celle-ci
    
    in = inpolygon(shift6(1),shift6(2),Cx,Cy);
    
    if in ==1;
        shift6 = shift_int/norm(shift_int);
        Median_saved(:,1) = shift6;
        Median_saved = circshift(Median_saved',1);
        Median_saved = Median_saved';
    else
        shift6_2 = shift_int_2/norm(shift_int_2);
        Median_saved(:,1) = shift6_2;
        Median_saved = circshift(Median_saved',1);
        Median_saved = Median_saved';
    end
    
end
hold off;

%% Gives the shifting
% TODO we must finde how to see if there is a crossing and where to stop
% and what to do next...


% Condition used to say if the point have crossed
notcrossed = 1;
% hFig = figure(3);
% % set(hFig, 'Position', [200 200 500 500])
% hold on;
bouclex=1;
x=0;
do_number_pts = 0;
C1 = [Cx(1) Cy(1)];
plot(C1(1),C1(2),'o');

% Matrice to save the diffrent lines
array_lines = zeros(2000,4);
array_points = zeros(2000,2);
array_points2 = ones(2000,2)*NaN;
array_line_pos = 1;
array_points_pos =1;
array_points_pos2 =1;
first_passed = 0;
in = 1;
while (notcrossed)
    
    shift6 = C1+(shift_int/norm(shift_int))*6*(x);
    
    
    % The new points each turn
    array_points(array_points_pos,1)=shift6(1);
    array_points(array_points_pos,2)=shift6(2);
    array_points_pos = array_points_pos+1;
    
    % The points with a return to the origin on each cycle
    array_points2(array_points_pos2,1)=shift6(1);
    array_points2(array_points_pos2,2)=shift6(2);
    %     plot(array_points2(array_points_pos2,1),array_points2(array_points_pos2,2),'o');
    %     if first_passed == 1
    %     quiver(array_points2(array_points_pos2-1,1),array_points2(array_points_pos2-1,2),array_points2(array_points_pos2,1),array_points2(array_points_pos2,2))
    %     end
    %     first_passed = 1;
    array_points_pos2 = array_points_pos2+1;
    
    Cx = circshift(Cx',1);
    Cx = Cx';
    Cy = circshift(Cy',1);
    Cy = Cy';
    C1 = [Cx(1) Cy(1)];
    
    %     pause(0.1)
    %     plot(shift6(1),shift6(2),'*');
    
    
    
    Median_saved = circshift(Median_saved',1);
    Median_saved = Median_saved';
    
    shift_int = Median_saved(:,1)';
    do_number_pts = do_number_pts+1;
    if do_number_pts==nomber_pts
        % here so no while(1)
        x= x+1;
        array_points2(array_points_pos2,1) = array_points2(array_points_pos2-nomber_pts,1);
        array_points2(array_points_pos2,2) = array_points2(array_points_pos2-nomber_pts,2);
        array_points_pos2 = array_points_pos2+1;
        %         plot(array_points2(array_points_pos2,1),array_points2(array_points_pos2,2),'o');
        
        % do all the points
        do_number_pts = 0;
        
    end
    
    % TODO, must be corrected...
    
    if array_points_pos2 >= len_Cx+10
        for loop_test_inter =  1:len_Cx
            Cx_now(loop_test_inter)= array_points2(array_points_pos2-loop_test_inter-3,1);
            Cy_now(loop_test_inter)= array_points2(array_points_pos2-loop_test_inter-3,2);
        end
        %                 Cx_now
        %                 Cy_now
        %                 array_points2(array_points_pos2-1,1)
        %                 array_points2(array_points_pos2-1,2)
        figure(99);
        hold on;
        plot(Cx_now,Cy_now,'*')
        %         pause(1)
        plot(array_points2(array_points_pos2-2,1),array_points2(array_points_pos2-2,2),'o');
        hold off;
        in = inpolygon(array_points2(array_points_pos2-2,1),array_points2(array_points_pos2-2,2),Cx_now,Cy_now);
    end
    
    
    % in this if we want to know when to stop
    if in ==0;
        break;
        %         notcrossed= 0;
    end
end
figure (88);
hold on;

plot(array_points2(:,1),array_points2(:,2),'x')
plot(array_points(:,1),array_points(:,2),'o')
hold off;
% % Adding points to do the circles just for the border, not the one going in
% % the middle
% figure(4);
% hold on;
% for loop = 2:array_points_pos-1
%     Intermed = [array_points(loop,1) array_points(loop,2)]-[array_points(loop-1,1) array_points(loop-1,2)];
%     quiver(array_points(loop-1,1),array_points(loop-1,2),Intermed(1),Intermed(2))
%
%
%     Intermed2 = [array_points(loop-1,1) array_points(loop-1,2)]-[array_points(loop,1) array_points(loop,2)];
%     quiver(array_points(loop,1),array_points(loop,2),Intermed2(1),Intermed2(2))
%     shift_cercle = [array_points(loop,1),array_points(loop,2)]+(Intermed2/norm(Intermed2))*3;
%     shift_cercle2 = [array_points(loop-1,1),array_points(loop-1,2)]+(Intermed/norm(Intermed))*3;
%     plot(array_points(loop,1),array_points(loop,2),'o');
%     %     plot(shift_cercle(1),shift_cercle(2),'*');
%     %     plot(shift_cercle2(1),shift_cercle2(2),'o');
%
%
%
% end
% hold off;

%% For the circls
% Adding points to do the circles on every vecor
figure(5);
hold on;
plot(Gx,Gy,'o');
do_nomber_pts=1;
array_circle_pts = ones(2000,2)*NaN;
array_circle_pts_pos = 1;
array_circle_pts2 = ones(2000,2)*NaN;
array_circle_pts_pos2 = 1;

% Parameters for the befor and after circle points
last_first_point = 20;
other_points = 5;

for loop = 2:array_points_pos2-1
    
    Intermed = [array_points2(loop,1) array_points2(loop,2)]-[array_points2(loop-1,1) array_points2(loop-1,2)];
    quiver(array_points2(loop-1,1),array_points2(loop-1,2),Intermed(1),Intermed(2))
    Intermed2 = [array_points2(loop-1,1) array_points2(loop-1,2)]-[array_points2(loop,1) array_points2(loop,2)];
    quiver(array_points2(loop,1),array_points2(loop,2),Intermed2(1),Intermed2(2))
    
    % Used to derermin the angle betwin the vectors
    %     A = array_points2(loop,1) + array_points2(loop,2)*i;
    %     B = array_points2(loop-1,1) + array_points2(loop-1,2)*i;
    %     angle = acos( (A*B)/(norm(A)*norm(B)));
    %
    % % AB = Intermed
    % % AC = Intermed2
    % % % AB*AC = norm(AB)*norm(AC)*cos(A)
    % % A = acos((AB*AC)/(norm(AB)*norm(AC)))
    
    if do_nomber_pts == nomber_pts+1
        
        % Ces points là sont les passages du point origine au point du
        % cycle suivant
        %         shift_cercle = [array_points2(loop,1),array_points2(loop,2)]+(Intermed2/norm(Intermed2))*3;
        %         shift_cercle2 = [array_points2(loop-1,1),array_points2(loop-1,2)]+(Intermed/norm(Intermed))*3;
        % %                 plot(array_points2(loop,1),array_points2(loop,2),'o');
        %         plot(shift_cercle(1),shift_cercle(2),'*');
        %         plot(shift_cercle2(1),shift_cercle2(2),'o');
        do_nomber_pts=0;
    elseif do_nomber_pts == nomber_pts
        % Starting point of the cicile with diffrent point
        shift_cercle = [array_points2(loop,1),array_points2(loop,2)]+(Intermed2/norm(Intermed2))*last_first_point;
        shift_cercle2 = [array_points2(loop-1,1),array_points2(loop-1,2)]+(Intermed/norm(Intermed))*other_points;
        %         plot(array_points2(loop,1),array_points2(loop,2),'x');
        %         plot(shift_cercle(1),shift_cercle(2),'*');
        %         plot(shift_cercle2(1),shift_cercle2(2),'o');
        array_circle_pts(array_circle_pts_pos,:) = [shift_cercle(1) shift_cercle(2)];
        array_circle_pts_pos = array_circle_pts_pos+1;
        array_circle_pts2(array_circle_pts_pos2,:) = [shift_cercle2(1) shift_cercle2(2)];
        array_circle_pts_pos2 = array_circle_pts_pos2+1;
        
    else
        % Touts les points qui font les cycle, sans les pts intermediaires
        shift_cercle = [array_points2(loop,1),array_points2(loop,2)]+(Intermed2/norm(Intermed2))*other_points;
        shift_cercle2 = [array_points2(loop-1,1),array_points2(loop-1,2)]+(Intermed/norm(Intermed))*other_points;
        %         %         plot(array_points2(loop,1),array_points2(loop,2),'o');
        %         plot(shift_cercle(1),shift_cercle(2),'*');
        %         plot(shift_cercle2(1),shift_cercle2(2),'o');
        array_circle_pts(array_circle_pts_pos,:) = [shift_cercle(1) shift_cercle(2)];
        array_circle_pts_pos = array_circle_pts_pos+1;
        array_circle_pts2(array_circle_pts_pos2,:) = [shift_cercle2(1) shift_cercle2(2)];
        array_circle_pts_pos2 = array_circle_pts_pos2+1;
    end
    do_nomber_pts = do_nomber_pts+1;
end
hold off;


%% Making all the points that must be folowed
figure(6);
hold on;
do_nomber_pts = 0;
array_full_pts = ones(2000,2)*NaN;
array_full_pts_pos =0;
mPoint = ones(2000,2)*NaN;
for loop = 1:160
    % Median betwin the 2 added point for circle
    
    Median = [array_circle_pts(loop,1) array_circle_pts(loop,2)]-[array_circle_pts2(loop+1,1) array_circle_pts2(loop+1,2)];
    %     quiver(array_circle_pts(loop,1),array_circle_pts(loop,2),Median(1),Median(2))
    Median = Median/2;
    %     quiver(array_circle_pts(loop,1),array_circle_pts(loop,2),Median(1),Median(2))
    % Line of the median
    mPointx = array_circle_pts(loop,1)-Median(1);
    mPointy = array_circle_pts(loop,2)-Median(2);
    array_circl = [array_circle_pts(loop,1) array_circle_pts(loop,2)];
    array_point = [mPoint(loop,1) mPoint(loop,2)];
    mPoint(loop,1) = mPointx;
    mPoint(loop,2) = mPointy;
    %Plot the median point
    plot(mPointx,mPointy,'o')
    
    
end
hold off;

%% Plot of the mPoints and making of the 3rd point for the circle

figure(7);
hold on;
Vector_circle_pnt_3 = ones(2000,2)*NaN;
Circle_pnt_3 = ones(2000,2)*NaN;
for loop = 1:160
    plot(mPoint(loop,1),mPoint(loop,2),'o');
    plot(array_points(loop+1,1),array_points(loop+1,2),'o');
    % Normalized vecrot...
    %     Vector_circle_pnt_3(loop,:) = ([array_points(loop+1,1)
    %     array_points(loop+1,2)]-[mPoint(loop,1)
    %     mPoint(loop,2)])/(norm([array_points(loop+1,1)
    %     array_points(loop+1,2)])-norm([mPoint(loop,1) mPoint(loop,2)]));
    % Vector not normalized
    Vector_circle_pnt_3(loop,:) = [array_points(loop+1,1) array_points(loop+1,2)]-[mPoint(loop,1) mPoint(loop,2)];
    Circle_pnt_3(loop,:) = mPoint(loop,:)+Vector_circle_pnt_3(loop,:)/3;
    plot(Circle_pnt_3(loop,1),Circle_pnt_3(loop,2),'x');
end
hold off;

%% Making the circls with 3 points
% figure(8);
% hold on;

% pour carrés uniquement
arcs = cell(1,4);
arcs{1} = pi/2:0.01:pi;
arcs{2} = pi:0.01:3*pi/2;
arcs{3} = 3*pi/2:0.01:2*pi;
arcs{4} = 0.2:0.01:pi/4+0.1;
loop_pts = 1;
% array_final = ones(2000,2)*NaN;
for loop = 1:160
    
    pt1 = array_circle_pts2(loop+1,:);
    pt2 = array_circle_pts(loop,:);
    pt3 = Circle_pnt_3(loop,:);
    
    [centre radius] = calcCircle(pt1, pt2, pt3);
    
    ang=arcs{mod(loop-1,4)+1};
    xp=radius*cos(ang);
    yp=radius*sin(ang);
    
    %     plot(centre(1)+xp,centre(2)+yp);
    %     plot(pt1(1),pt1(2) ,'o');
    %     plot(pt2(1),pt2(2) ,'x');
    %     plot(pt3(1),pt3(2) ,'*');
    array_final(loop_pts,:) = pt2;
    loop_pts = loop_pts+1;
    array_final(loop_pts,:) = pt3;
    loop_pts = loop_pts+1;
    array_final(loop_pts,:) = pt1;
    loop_pts = loop_pts+1;
    
end
% hold off;

% close all;
figure(9);
hold on;

%% Adding obsicals
% % Simple square
% Ox = [25 25 10 10];   % X position of the vectors
% Oy = [25 10 10 25];    % Y position of the vectors

% Polygone
% Ox = [10 20 5 0];
% Oy = [30 5 5 10];

% % Polygone
% Ox = [10 20 5 0];
% Oy = [30 5 5 10];

% % Simple big square shifted
Ox = [200 200 20 20];   % X position of the vectors
Oy = [200 20 20 200];    % Y position of the vectors

% % Simple big square shifted
% Ox = [200 200 100 100];   % X position of the vectors
% Oy = [200 20 20 200];    % Y position of the vectors

% % Hexagone
% Ox = [30 20 10 20 30 40];
% Oy = [20 20 10 5 3 10];

% % Droite
% Ox = [40 40];
% Oy = [9 50];

length_shape_obj = length(Ox);
Ox(length(Ox)+1) = Ox(1);
Oy(length(Oy)+1) = Oy(1);
plot (Ox,Oy);
crossed = 0;
crossed2times = 0;
% mem_Col = ones(2000,4)*NaN;
route1_loop = 0;
route2_loop = 0;
route2_loop_previous =0;
route1_loop_previous =0;
save_2 = 0;
save_1 = 0;
points_linked =1;
final_obstical = 0;
save_old_and_new =[]
for loop = 1:200
    plot(array_final(loop,1),array_final(loop,2),'o');
    quiver(array_final(loop,1),array_final(loop,2),array_final(loop+1,1)-array_final(loop,1),array_final(loop+1,2)-array_final(loop,2))
    for loop2 = 1:length(Ox)-1;
        Col = collision([Ox(loop2) Oy(loop2)],[Ox(loop2+1) Oy(loop2+1)],[array_final(loop,1) array_final(loop,2)],[array_final(loop+1,1) array_final(loop+1,2)]);
        Col2 = collision([Ox(loop2) Oy(loop2)],[Ox(loop2+1) Oy(loop2+1)],[array_final(loop+1,1) array_final(loop+1,2)],[array_final(loop,1) array_final(loop,2)]);
        Col3 = collision([array_final(loop,1) array_final(loop,2)],[array_final(loop+1,1) array_final(loop+1,2)],[Ox(loop2) Oy(loop2)],[Ox(loop2+1) Oy(loop2+1)]);
        Col4 = collision([array_final(loop+1,1) array_final(loop+1,2)],[array_final(loop,1) array_final(loop,2)],[Ox(loop2) Oy(loop2)],[Ox(loop2+1) Oy(loop2+1)]);
        
        if (length(Col4)==2 || length(Col3)==2 || length(Col2)==2 || length(Col)==2)
            crossed = crossed+1;
            crossed2times = crossed2times+1;
        end
        
        if isnan(Col4)
        else
            
            mem_Col(crossed,3) = crossed;
            mem_Col(crossed,4) = loop2;
            mem_Col(crossed,1) = Col4(1);
            mem_Col(crossed,2) = Col4(2);
        end
        if isnan(Col3)
        else
            
            mem_Col(crossed,3) = crossed;
            mem_Col(crossed,4) = loop2;
            mem_Col(crossed,1) = Col3(1);
            mem_Col(crossed,2) = Col3(2);
        end
        
        if isnan(Col2)
        else
            
            mem_Col(crossed,3) = crossed;
            mem_Col(crossed,4) = loop2;
            mem_Col(crossed,1) = Col2(1);
            mem_Col(crossed,2) = Col2(2);
        end
        if isnan(Col)
        else
            mem_Col(crossed,3) = crossed;
            mem_Col(crossed,4) = loop2;
            mem_Col(crossed,1) = Col(1);
            mem_Col(crossed,2) = Col(2);
        end
    end
    if crossed2times ==1
        plot(array_final(loop,1),array_final(loop,2),'x');
        if save_1 == save_2
            save_1 = save_1+1;
            save_nolonger_pts(save_1,1) = loop;
            save_nolonger_pts(save_1,2) = points_linked
        end
    end
    if crossed2times == 2
        save_2= save_2+1;
        save_nolonger_pts2(save_2,1) = loop+1;
        save_nolonger_pts2(save_2,2) = points_linked;
        points_linked = points_linked+1;
        %% GOTODO here
        if (pdist([mem_Col(crossed-1,1),mem_Col(crossed-1,2); array_final(loop+1,1),array_final(loop+1,2)],'euclidean'))<(pdist([mem_Col(crossed,1),mem_Col(crossed,2);array_final(loop+1,1),array_final(loop+1,2)],'euclidean'));
            temp_val = mem_Col(crossed,1:4);
            mem_Col(crossed,1:4) = mem_Col(crossed-1,1:4);
            mem_Col(crossed-1,1:4) = temp_val;
            array_final(loop+1,1:2);
        else
            array_final(loop+1,1:2);
            mem_Col(crossed,1:4);
            mem_Col(crossed-1,1:4);
        end
        
        where_intersect_enter = mem_Col(crossed-1,4);
        
        
        enter_point = [mem_Col(crossed-1,1) mem_Col(crossed-1,2) ];
        where_intersect_out = mem_Col(crossed,4);
        out_point = [mem_Col(crossed,1) mem_Col(crossed,2) ];
        notdone =1;
        
        % the point of the object folowed in clockwise
        where_next_point = where_intersect_enter;
        while (notdone)
            
%             if where_intersect_out < where_intersect_enter
                route1_loop = route1_loop+1;
                save_point(route1_loop,1) = mem_Col(crossed-1,1);
                save_point(route1_loop,2) = mem_Col(crossed-1,2);
                temp = where_intersect_enter;
                for loopx = where_intersect_out+1:where_intersect_enter
                    
                    route1_loop = route1_loop+1;
                    save_point(route1_loop,1)= Ox(temp);
                    save_point(route1_loop,2)= Oy(temp);
                    temp = temp-1;
                end
                route1_loop = route1_loop+1;
                
                save_point(route1_loop,1)= out_point(1);
                save_point(route1_loop,2)= out_point(2);
                
                d1 =0;
                d1_final =0;
                temp1 = 0;
                clear save_point_temp1;
                for loop_comp_route = route1_loop_previous+1:route1_loop-1;
                    d1 = pdist(save_point(loop_comp_route:loop_comp_route+1,:),'euclidean');
                    d1_final = d1_final+d1;
                    temp1 = temp1+1;
                    save_point_temp1(temp1,1:2) = save_point(loop_comp_route,:);
                    
                    
                end
                save_point_temp1(temp1+1,1:2) = save_point(loop_comp_route+1,:);
%             end
            
%             if where_intersect_out < where_intersect_enter
                route2_loop = route2_loop+1;
                save_point2(route2_loop,1) = mem_Col(crossed-1,1);
                save_point2(route2_loop,2) = mem_Col(crossed-1,2);
                
                temp = where_intersect_enter+1;
                for loopx = 1: where_intersect_out+length_shape_obj-where_intersect_enter;
                    if temp == length_shape_obj+1;
                        temp = 1;
                    end
                    route2_loop = route2_loop+1;
                    save_point2(route2_loop,1)= Ox(abs(temp));
                    save_point2(route2_loop,2)= Oy(abs(temp));
                    temp = temp+1;
                    
                end
                route2_loop = route2_loop+1;
                save_point2(route2_loop,1)= out_point(1);
                save_point2(route2_loop,2)= out_point(2);
                
                d2 = 0;
                d2_final =0;
                temp2 = 0;
                
                clear save_point_temp2;
                for loop_comp_route = route2_loop_previous+1:route2_loop-1
                    d2 = pdist(save_point2(loop_comp_route:loop_comp_route+1,:),'euclidean');
                    d2_final = d2_final+d2;
                    temp2 = temp2+1;
                    save_point_temp2(temp2,1:2) = save_point2(loop_comp_route,:);
                end
                save_point_temp2(temp2+1,1:2) = save_point2(loop_comp_route+1,:);
%             end
            
            
            
            %             clear save_old_and_new;
            if d1_final< d2_final
                final_obstical = final_obstical+1;
                plot(save_point_temp1(:,1),save_point_temp1(:,2),'r');
                save_point_temp1(:,3) = final_obstical;
                save_old_and_new = vertcat(save_old_and_new,save_point_temp1);
            else
                final_obstical = final_obstical+1;
                plot(save_point_temp2(:,1),save_point_temp2(:,2),'g');
                save_point_temp2(:,3) = final_obstical;
                save_old_and_new = vertcat(save_old_and_new,save_point_temp2);
            end
            
            route1_loop_previous =route1_loop;
            route2_loop_previous =route2_loop;
            
            notdone =0;
        end
        crossed2times =0;
    end
    %     pause (0.1)
end
% plot(save_point(:,1),save_point(:,2),'r');
% plot(save_point2(:,1),save_point2(:,2),'g');
hold off;
% save_nolonger_pts
% save_nolonger_pts2
% save_old_and_new

loop_other_order = max(save_nolonger_pts2(:,2));
a =0 ;
for loop = 1:max(save_nolonger_pts2(:,2))
    array_temp1 = array_final(1:save_nolonger_pts(max(save_nolonger_pts2(:,2)-a)),:);
    %%TODO trouver une meilleur methode...
    save_old_and_new_temp = save_old_and_new(:,3)==loop_other_order;
    save_old_and_new_temp = find(save_old_and_new_temp,10);
    %         array_temp2 =[]
    for loop2 = 1:length(save_old_and_new_temp)
        save_old_and_new_temp(loop2);
        array_temp2(loop2,1:2) = save_old_and_new(save_old_and_new_temp(loop2),1:2);
    end
    %         array_temp2
    array_temp3 = array_final(save_nolonger_pts2(max(save_nolonger_pts2(:,2)-a)):length(array_final),:);
    loop_other_order =loop_other_order-1;
    array_final = vertcat(array_temp1,array_temp2,array_temp3);
%     length(array_final);
    a = a+1;
end
figure(100);
hold on
% plot(Ox,Oy);
plot(array_final(:,1),array_final(:,2))
% plot(array_final(save_nolonger_pts(:,1),1),array_final(save_nolonger_pts(:,1),2),'o');
% plot(array_final(save_nolonger_pts2(:,1),1),array_final(save_nolonger_pts2(:,1),2),'x');
hold off;