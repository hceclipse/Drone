close all
clear all
clc

a = [0,0];
b = [2,3];

figure(1);
hold on;
plot(a(1),a(2),'o');
plot(b(1),b(2),'o');
x = -100;
t = x/2*(b-a)/norm(b-a);
a = a + t;
b = b - t;

plot(a(1),a(2),'x');
plot(b(1),b(2),'x');
% plot(d(1),d(2),'*');
% plot(e(1),e(2),'*');