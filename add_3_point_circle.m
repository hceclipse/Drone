function [Vector_circle_pnt_3,Circle_pnt_3,mPoint] = add_3_point_circle(array_circle_pts,array_circle_pts2,array_points)
%% Making all the points that must be folowed
% Plot of the mPoints and making of the 3rd point for the circle

for loop = 1:size(array_circle_pts,1)-1
    % Median betwin the 2 added point for circle
    
    Median = [array_circle_pts(loop,1) array_circle_pts(loop,2)]-[array_circle_pts2(loop+1,1) array_circle_pts2(loop+1,2)];
    %     quiver(array_circle_pts(loop,1),array_circle_pts(loop,2),Median(1),Median(2))
    Median = Median/2;
    %     quiver(array_circle_pts(loop,1),array_circle_pts(loop,2),Median(1),Median(2))
    % Line of the median
    mPointx = array_circle_pts(loop,1)-Median(1);
    mPointy = array_circle_pts(loop,2)-Median(2);
    array_circl = [array_circle_pts(loop,1) array_circle_pts(loop,2)];
    %     array_point = [mPoint(loop,1) mPoint(loop,2)];
    mPoint(loop,1) = mPointx;
    mPoint(loop,2) = mPointy;
    
    Vector_circle_pnt_3(loop,:) = [array_points(loop+1,1) array_points(loop+1,2)]-[mPoint(loop,1) mPoint(loop,2)];
    Circle_pnt_3(loop,:) = mPoint(loop,:)+Vector_circle_pnt_3(loop,:)/3;
    
end

Vector_circle_pnt_3 = Vector_circle_pnt_3;
Circle_pnt_3 = Circle_pnt_3;
mPoint = mPoint;



end


