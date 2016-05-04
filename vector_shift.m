function [a_x1,a_x2,b_x1,b_x2] = vector_shift(a,b,shift_parallel)

ab = b-a;
t = (ab)/norm(ab);

d = a + t;
e = a - t;

direction_vector = [b(1),b(2);d(1),d(2)];
direction_vector2 = [b(1),b(2);e(1),e(2)];

if abs(pdist(direction_vector,'euclidean'))<abs(pdist(direction_vector2,'euclidean'))
    c = d;
else
    c = e;
end

ac = c-a;
ap = [0 -1;1 0]*ac';

a_x1 = a + (ap')*shift_parallel;
check_vect_unitaire = [a(1),a(2);a_x1(1),a_x1(2)];
abs(pdist(check_vect_unitaire,'euclidean'));

a_x2 = a - (ap')*shift_parallel;
check_vect_unitaire = [a(1),a(2);a_x2(1),a_x2(2)];
abs(pdist(check_vect_unitaire,'euclidean'));

%% Same but with the b point

ba = a-b;

t = (ba)/norm(ba);

d = b + t;
e = b - t;

% figure(2);
% hold on;
% plot(a(1),a(2),'o');
% plot(b(1),b(2),'o');

% plot(d(1),d(2),'*');
% plot(e(1),e(2),'x');
direction_vector = [b(1),b(2);d(1),d(2)];
direction_vector2 = [b(1),b(2);e(1),e(2)];

if abs(pdist(direction_vector,'euclidean'))<abs(pdist(direction_vector2,'euclidean'))
%     plot(d(1),d(2),'*');
    c = d;
else
%     plot(e(1),e(2),'*');
    c = e;
end

bc = c-b;

ap = [0 -1;1 0]*bc';

b_x1 = b + (ap')*shift_parallel;
check_vect_unitaire = [b(1),b(2);b_x1(1),b_x1(2)];
abs(pdist(check_vect_unitaire,'euclidean'));
% plot(b_x1(1),b_x1(2),'x');

b_x2 = b - (ap')*shift_parallel;
check_vect_unitaire = [b(1),b(2);b_x2(1),b_x2(2)];
abs(pdist(check_vect_unitaire,'euclidean'));
% plot(b_x2(1),b_x2(2),'x');
% hold off;

% ax1 = b_x1-b;
% 
% angle = acos(dot(ax1,ba) / (norm(ax1)*norm(ba)))
% 
% ax2 = b_x2-b;
% 
% angle = acos(dot(ax2,ba) / (norm(ax2)*norm(ba)))

end
