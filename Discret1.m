clear all
close all
clc

Cx = [10 10 40 40];   % X position of the vectors
Cy = [10 40 40 10];    % Y position of the vectors

figure(1);
plot(Cx,Cy,'*');
hold on;
nomber_pts = length(Cx);
o = [0 0]; % vector origin

for loop = 1:200
    
% Show the vector of the first loop
% for iter = 1:nomber_pts-1
%     C = [Cx(iter) Cy(iter)];
%     Cnext = [Cx(iter+1) Cy(iter+1)];
%     nd = (Cnext-C)./norm(Cnext-C); %normalize
%     nd = (Cnext-C);
%     % % Show vector betwin the points
%         quiver(C(1),C(2),nd(1),nd(2))
% end

% pause

% quiver(C(1),C(2),nd(1),nd(2))

C1 = [Cx(1) Cy(1)]
C2 = [Cx(2) Cy(2)]
C3 = [Cx(3) Cy(3)]
C4 = [Cx(4) Cy(4)]

% Vector betwin befor and last point
M1 = (C4-C2);

% show the ector betwin the one before and the one after form the one after
% quiver(C2(1),C2(2),M1(1),M1(2));

% Gives the eqasion of the 
slopeM = (C2(2)-C4(2))/(C2(1)-C4(1));
b = (-C2(1))*slopeM+C2(2);

% Plot the line betwin the point befor and the last
x = min(C2(1),C4(1)):max(C2(1),C4(1));
% plot(x, slopeM*x+b);

% Intermediat point of the two points
mPointx = (max(C2(1),C4(1))+min(C2(1),C4(1)))/2;
mPointy = mPointx*slopeM+b;

% Plot of the point
% plot(mPointx,mPointy ,'*');

% Saving the point
mPoint = [mPointx mPointy];

% Plot vector betwin
Median = mPoint-C1;
% quiver(C1(1),C1(2),Median(1),Median(2))

% Line of the median
slopeMed = (C1(2)-mPoint(2))/(C1(1)-mPoint(1));
bMed = (-C1(1))*slopeMed+C1(2);

% Plot median line
x = min(C1(1),mPoint(1)):max(C1(1),mPoint(1));
% plot(x, slopeMed*x+bMed);

% Shift of the point on the median

shift_int = mPoint-C1;
shift6 = C1+(shift_int/norm(shift_int))*6;
plot(shift6(1),shift6(2),'*');

% Sauvegarde du prochain point
Cx(1) = shift6(1);
Cy(1) = shift6(2);

% % Shift dans les points
Cx = circshift(Cx',3);
Cx = Cx';
Cy = circshift(Cy',3);
Cy = Cy';

pause (0.01)



end
