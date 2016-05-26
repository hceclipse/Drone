clear all
close all
clc

%% Defining the shape of our field

% Shape that is square like
% Cx = [300 300 0 0];   % X position of the vectors
% Cy = [300 0 0 300];    % Y position of the vectors

Cx = [970 1230 350 -120 -280 290];
Cy = [1080 530 -30 110 800 210];

% Cx = [72,63,-23,14];
% Cy = [158,-37,52,112];

nomber_pts = length(Cx);

%% Fonction that gives us the first points in the field
Shift = 3;
First_points_saved = First_Shift(Cx,Cy,Shift);
% Printing of the first cycle
figure(1);
hold on;
plot(Cx,Cy,'r');
plot(First_points_saved(1,:),First_points_saved(2,:));
hold off;


%% Gives the new point shifted and the stoppes at the end if no more points needed
[All_points_square,array_points] = Shifting_stopping2(Cx,Cy,First_points_saved);

figure(2);
hold on;
% plot(Cx,Cy,'r');
plot(All_points_square(1,:),All_points_square(2,:),'b');
hold off;
%% Gives the points to make the circle
         [array_circle_pts,array_circle_pts2] = add_points_circle(All_points_square,nomber_pts);

%% Gives the
            [Vector_circle_pnt_3,Circle_pnt_3,mPoint]= add_3_point_circle(array_circle_pts,array_circle_pts2,array_points);

%% Gives the circle
          array_final = Circle_3pts(array_circle_pts,array_circle_pts2,Circle_pnt_3);

%% Adding objects

% Ox = [10 20 5 0];
% Oy = [30 5 5 10];
% array_final = Obsticals(Ox,Oy,array_final);

% Ox = [80 80 40 40];
% Oy = [80 40 40 80];
% array_final = Obsticals(Ox,Oy,array_final);



% Ox = [10 20 5 0];
% Oy = [230 205 205 210];
% % figure(69);
% % plot(Ox,Oy,'o')
% % pause
% array_final = Obsticals(Ox,Oy,array_final);

% Ox = [251 252 231 231];
% Oy = [253 235 232 262];
% % figure(69);
% % plot(Ox,Oy,'o')
% % pause
% array_final = Obsticals(Ox,Oy,array_final);

% for loop = 1:3;

%     if loop ==1
%         Ox = [10 20 5 0];
%         Oy = [30 5 5 10];
%         X = Obsticals(Ox,Oy,array_final);
%         array_final = X;
%     elseif loop ==2;
% %         pause
%         Ox = [80 80 40 40];
%         Oy = [80 40 40 80];
%         X = Obsticals(Ox,Oy,array_final);
%         array_final = X;
%     elseif loop ==3;
%         Ox = [10 20 5 0];
%         Oy = [30 5 5 10];
%         X = Obsticals(Ox,Oy,array_final);
%         array_final = X;
%     end
%
%
%


% end

