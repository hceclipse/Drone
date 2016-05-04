function [array_circle_pts,array_circle_pts2] = add_points_circle(array_points2,nomber_pts)
% For the circls
% Adding points to do the circles on every corner points

do_nomber_pts=1;
array_circle_pts_pos = 1;
array_circle_pts_pos2 = 1;
array_points_pos2 = size(array_points2,1);
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
end
% %% Making all the points that must be folowed
% 
% for loop = 1:size(array_circle_pts,1)-1
%     % Median betwin the 2 added point for circle
%     
%     Median = [array_circle_pts(loop,1) array_circle_pts(loop,2)]-[array_circle_pts2(loop+1,1) array_circle_pts2(loop+1,2)];
%     %     quiver(array_circle_pts(loop,1),array_circle_pts(loop,2),Median(1),Median(2))
%     Median = Median/2;
%     %     quiver(array_circle_pts(loop,1),array_circle_pts(loop,2),Median(1),Median(2))
%     % Line of the median
%     mPointx = array_circle_pts(loop,1)-Median(1);
%     mPointy = array_circle_pts(loop,2)-Median(2);
%     array_circl = [array_circle_pts(loop,1) array_circle_pts(loop,2)];
%     %     array_point = [mPoint(loop,1) mPoint(loop,2)];
%     mPoint(loop,1) = mPointx;
%     mPoint(loop,2) = mPointy;
%     
% end
% 
% 
% %% Plot of the mPoints and making of the 3rd point for the circle
% 
% for loop = 1:size(array_circle_pts,1)-1
%     % Normalized vecrot...
%     %     Vector_circle_pnt_3(loop,:) = ([array_points(loop+1,1)
%     %     array_points(loop+1,2)]-[mPoint(loop,1)
%     %     mPoint(loop,2)])/(norm([array_points(loop+1,1)
%     %     array_points(loop+1,2)])-norm([mPoint(loop,1) mPoint(loop,2)]));
%     % Vector not normalized
%     Vector_circle_pnt_3(loop,:) = [array_points(loop+1,1) array_points(loop+1,2)]-[mPoint(loop,1) mPoint(loop,2)];
%     Circle_pnt_3(loop,:) = mPoint(loop,:)+Vector_circle_pnt_3(loop,:)/3;
% end
% 
% X = Vector_circle_pnt_3
% Y = Circle_pnt_3;
% 
% %% Making the circls with 3 points
% % figure(8);
% % hold on;
% % 
% % % pour carrés uniquement
% % arcs = cell(1,4);
% % arcs{1} = pi/2:0.01:pi;
% % arcs{2} = pi:0.01:3*pi/2;
% % arcs{3} = 3*pi/2:0.01:2*pi;
% % arcs{4} = 0.2:0.01:pi/4+0.1;
% % loop_pts = 1;
% % array_final = ones(2000,2)*NaN;
% % for loop = 1:160
% %     
% %     pt1 = array_circle_pts2(loop+1,:);
% %     pt2 = array_circle_pts(loop,:);
% %     pt3 = Circle_pnt_3(loop,:);
% %     
% %     [centre radius] = calcCircle(pt1, pt2, pt3);
% %     
% %     ang=arcs{mod(loop-1,4)+1};
% %     xp=radius*cos(ang);
% %     yp=radius*sin(ang);
% %     
% %     plot(centre(1)+xp,centre(2)+yp);
% %     plot(pt1(1),pt1(2) ,'o');
% %     plot(pt2(1),pt2(2) ,'x');
% %     plot(pt3(1),pt3(2) ,'*');
% %     array_final(loop_pts,:) = pt2;
% %     loop_pts = loop_pts+1;
% %     array_final(loop_pts,:) = pt3;
% %     loop_pts = loop_pts+1;
% %     array_final(loop_pts,:) = pt1;
% %     loop_pts = loop_pts+1;
% %     
% % end
% % hold off;
% 
% end
% 
