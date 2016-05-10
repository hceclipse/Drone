close all
clear all
clc

A = [0 0];
% B = [-4 5];
B = [4 -5];
C = [3 3];

AB = B - A;
AC = C - A;
figure(1);
hold on;
plot(A(1),A(2),'o');
plot(B(1),B(2),'o');
plot(C(1),C(2),'o');


hold off;

angle = acos(dot(AB,AC) / (norm(AB)*norm(AC)))
