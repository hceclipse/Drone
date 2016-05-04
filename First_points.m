function First_points_saved = First_Points(nomber_pts, Cx, Cy)
% First_Points : gives us the first points that the drone will follow in
% the field
% nomber_pt =nomber_pts;
Median_saved = zeros(2,nomber_pts);
for loop = 1:nomber_pts
    %% TODO, change this version for other points
    C1 = [Cx(1) Cy(1)]; % C1 <--- is always the point we look at
    C2 = [Cx(2) Cy(2)];
    C_last = [Cx(nomber_pts) Cy(nomber_pts)];
    
    % Vector betwin befor and last point
    M1 = (C_last-C2);
    Median_vect_C2_C_last = M1/2;
    
    % Gives the midium point with vectors (no problems of slopes with
    % divisions with 0!
    mPointx = C2(1)+Median_vect_C2_C_last(1);
    mPointy = C2(2)+Median_vect_C2_C_last(2);
    
    % Saving the point
    mPoint = [mPointx mPointy];
    
    % Shift of the point on the median
    shift_int = mPoint-C1;
    shift_int_2 = C1-mPoint;
    
    % The shifting of the normalized point in both direction (for concave
    % and convex)
    shift6 = C1+(shift_int/norm(shift_int))*6;
    shift6_2 = C1+(shift_int/norm(shift_int))*-6;
    
    % Shift dans les points
    Cx = circshift(Cx',1);
    Cx = Cx';
    Cy = circshift(Cy',1);
    Cy = Cy';
    
    % On va chercher à savoir si l'on est bien dans notre figure et pas à
    % l'extérieur de celle-ci
    in = inpolygon(shift6(1),shift6(2),Cx,Cy);
    
    % Verification if the point is in the shape (concave or convex)
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

First_points_saved = Median_saved(:,:);
