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

Medx = [0 0 0 0];
Medy = [0 0 0 0];

hold off;

figure(2);
hold on;

Median_saved = [[0 0 0 0];[0 0 0 0]];
for loop = 1:nomber_pts
    
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
    
    C1 = [Cx(1) Cy(1)];
    C2 = [Cx(2) Cy(2)];
    C3 = [Cx(3) Cy(3)];
    C4 = [Cx(4) Cy(4)];
    
    
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
    plot(x, slopeMed*x+bMed);
    
    % Shift of the point on the median
    
    shift_int = mPoint-C1;
    shift6 = C1+(shift_int/norm(shift_int))*6;
    plot(shift6(1),shift6(2),'*');
    
    % Sauvegarde du prochain point
    % Cx(1) = shift6(1);
    % Cy(1) = shift6(2);
    
    % % Shift dans les points
    Cx = circshift(Cx',1);
    Cx = Cx';
    Cy = circshift(Cy',1);
    Cy = Cy';
    
    shift6 = shift_int/norm(shift_int);
    Median_saved(:,1) = shift6;
    Median_saved = circshift(Median_saved',1);
    Median_saved = Median_saved';
    
    % is one point concave ?
    % if ti is we must invers it
    
    
end
hold off;

% Condition used to say if the point have crossed
notcrossed = 1;
figure(3);
hold on;
ass=1;
x=0;
do4 = 0;
C1 = [Cx(1) Cy(1)];
plot(C1(1),C1(2),'o');
while (notcrossed)
    
    
    if do4==nomber_pts
        % here so no while(1)
        x= x+1;
        % do all the points
        do4 = 0;
    end
    % in this if we want to know when to stop
    if x==20;
        break;
        notcrossed= 0;
    end
    shift6 = C1+(shift_int/norm(shift_int))*6*(x);
    if ass == 0
%         plot(shift6(1),shift6(2),shift6Past(1),shift6Past(2),'g');
        
        X = [shift6(1),shift6Past(1)];
        Y = [shift6(2),shift6Past(2)];
        scatter(X,Y)
%         hold on
        plot(X,Y)
%         hold off 
        ax = gca;
        ax.Color = 'blue';
        ax.XAxisLocation = 'bottom';
        ax.YAxisLocation = 'left';
        shift6Past=shift6;
        
        
        
    end
    if ass==1
        
        X = [C1(1),shift6(1)];
        Y = [C1(2),shift6(2)];
        scatter(X,Y)
%         hold on
        plot(X,Y)
%         hold off 
        ax = gca;
        ax.Color = 'blue';
        ax.XAxisLocation = 'bottom';
        ax.YAxisLocation = 'left';
        shift6Past=shift6;
%         plot(C1,shift6,'g');
        ass = 0;
        shift6Past=shift6;
        
    end
    
    
%     plot(shift6(1),shift6(2),'*');
% Move = [C1(1) C1(2) ; shift6(1) shift6(2)];
%     plot(Move);
    
    
    Cx = circshift(Cx',1);
    Cx = Cx';
    Cy = circshift(Cy',1);
    Cy = Cy';
    
    C1 = [Cx(1) Cy(1)];
    
    Median_saved = circshift(Median_saved',1);
    Median_saved = Median_saved';
    
    shift_int = Median_saved(:,1)';
    do4 = do4+1;
        pause(1)
end
hold off;

