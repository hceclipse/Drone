close all
clear all
clc

pt1 = [0,1];
pt2 = [2,4];
pt3 = [3,8];

[centre radius] = calcCircle(pt1, pt2, pt3);

ang=0:0.01:2*pi;
xp=radius*cos(ang);
yp=radius*sin(ang);
figure(1);
hold on;
plot(centre(1)+xp,centre(2)+yp);
plot(pt1(1),pt1(2) ,'*');
plot(pt2(1),pt2(2) ,'*');
plot(pt3(1),pt3(2) ,'*');
hold off;

