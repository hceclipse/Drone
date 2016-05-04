function array_final = Circle_3pts(array_circle_pts,array_circle_pts2,Circle_pnt_3)
% Making the circls with 3 points
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
for loop = 1:size(array_circle_pts,1)-1
    
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

end

