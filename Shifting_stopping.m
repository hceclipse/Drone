function [All_points_square, array_points] = Shifting_stopping(Cx,Cy,Median_saved)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% Condition used to say if the point have crossed
notcrossed = 1;
x=0;
do_number_pts = 0;
C1 = [Cx(1) Cy(1)];

C1_init = C1;

array_points_pos =1;
array_points_pos2 =1;
in = 1;
shift_int = 0;
nomber_pts = length(Cx);
while (notcrossed)
    
    shift6 = C1+(shift_int/norm(shift_int))*6*(x);
    
    % The new points each turn
    array_points(array_points_pos,1)=shift6(1);
    array_points(array_points_pos,2)=shift6(2);
    array_points_pos = array_points_pos+1;
    
    % The points with a return to the origin on each cycle
    
    array_points2(array_points_pos2,1)=shift6(1);
    array_points2(array_points_pos2,2)=shift6(2);
    array_points_pos2 = array_points_pos2+1;
    
    Cx = circshift(Cx',1);
    Cx = Cx';
    Cy = circshift(Cy',1);
    Cy = Cy';
    C1 = [Cx(1) Cy(1)];
    
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
    
    if array_points_pos2 >= nomber_pts+10
        for loop_test_inter =  1:nomber_pts
            Cx_now(loop_test_inter)= array_points2(array_points_pos2-loop_test_inter-3,1);
            Cy_now(loop_test_inter)= array_points2(array_points_pos2-loop_test_inter-3,2);
        end
        %                 Cx_now
        %                 Cy_now
        %                 array_points2(array_points_pos2-1,1)
        %                 array_points2(array_points_pos2-1,2)
        
%         figure(2);
%                 hold on;
%         plot(Cx_now,Cy_now,'*')
%                       
%         plot(array_points2(array_points_pos2-2,1),array_points2(array_points_pos2-2,2),'o');
%                 hold off;
        in = inpolygon(array_points2(array_points_pos2-2,1),array_points2(array_points_pos2-2,2),Cx_now,Cy_now);
    end
    
    
    % in this if we want to know when to stop
    if in ==0;
        break;
        %         notcrossed= 0;
    end
end

All_points_square = array_points2;
All_points_square(1,:) = [C1_init(1),C1_init(2)];
All_points_square(nomber_pts+1,:) = [C1_init(1),C1_init(2)];

% % array_points gives the way short (look figure to understand)
% figure(2);
% plot(array_points(:,1),array_points(:,2))
% 
% % array_points2 gives the long way (look figure to understand)
% figure(3);
% plot(array_points2(:,1),array_points2(:,2))

end