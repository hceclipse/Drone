close all
clear all
clc
% % première droite
% A1 = 0;
% b1 = 5;
% x1 = 10+0.2:0.1:14.2426-0.2;
% y1 = x1*A1+b1;
% 
% % deuxième droite
% A2 = 0;
% b2 = 14.2426;
% x2 = 14.2426+0.2:0.1:35.7573-0.2;
% y2 = x2*A2+b2;
% 
% if A1 == A2
%     % Les deux droites sont parallèles
%     if b1 == b2 
%         % Les deux droites sont supperposé
%     end
% end
% 
% xcommun=(b2-b1)/(A1-A2);
% 
% 
% figure(1)
% hold on;
% % plot(ord)
% plot(x1, y1);
% plot(x2, y2);
% plot(xcommun, ycommun, '*');

% Methode with vector for interesection
x = [0 0; 6 6];  %# Starting points in first row, ending points in second row
y = [0 6; 6 0];

dx = diff(x);  %# Take the differences down each column
dy = diff(y);
den = dx(1)*dy(2)-dy(1)*dx(2);  %# Precompute the denominator
ua = (dx(2)*(y(1)-y(3))-dy(2)*(x(1)-x(3)))/den;
ub = (dx(1)*(y(1)-y(3))-dy(1)*(x(1)-x(3)))/den;

isInSegment = all(([ua ub] >= 0) & ([ua ub] <= 1))

% 2nd Methode with vector for interesection
p1 = [1 1]
p2 = [0 0]

q1 = [1 2]
% q2 = [-1 -1]
q2 = [0 1]

L=p1-p2;
M=p1-q1;
N=p2-q2;
A=[M N];
T=pinv(A)*L;
h=p1-T(1)*(p1-q1);

