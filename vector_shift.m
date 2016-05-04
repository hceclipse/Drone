function [a_x1,a_x2,b_x1,b_x2] = vector_shift(a,b,shift_parallel)

%% Will give us the point "a" shifted from the distance "shift_parallel"

ab = b-a;
% making a normelized vector of ab
t = (ab)/norm(ab);

% Will giv us the upper and lower shift
d = a + t;
e = a - t;

% Will be used to determin if we are getting closer or furder away from b
direction_vector = [b(1),b(2);d(1),d(2)];
direction_vector2 = [b(1),b(2);e(1),e(2)];

% Testing if we are gatting closer or furder away from b 
% and taking the firder away  ---> c value will change depending on the test
if abs(pdist(direction_vector,'euclidean'))<abs(pdist(direction_vector2,'euclidean'))
    c = d;
else
    c = e;
end

ac = c-a;
% making a perpendicular point 
ap = [0 -1;1 0]*ac';

% Shifting this perpendicular point (upper)
a_x1 = a + (ap')*shift_parallel;
check_vect_unitaire = [a(1),a(2);a_x1(1),a_x1(2)];
abs(pdist(check_vect_unitaire,'euclidean'));

% Shifting this perpendicular point (lower)
a_x2 = a - (ap')*shift_parallel;
check_vect_unitaire = [a(1),a(2);a_x2(1),a_x2(2)];
abs(pdist(check_vect_unitaire,'euclidean'));

% A test of angle can be done to see if the point ac is perpendicular to ab

% angle = acos(dot(ax1,ba) / (norm(ax1)*norm(ba))); % angle mus

% These two points will be used to make parallel 
% This parallel will be extended in the next fonction

%% Same but with the b point

ba = a-b;

t = (ba)/norm(ba);

d = b + t;
e = b - t;

direction_vector = [b(1),b(2);d(1),d(2)];
direction_vector2 = [b(1),b(2);e(1),e(2)];

if abs(pdist(direction_vector,'euclidean'))<abs(pdist(direction_vector2,'euclidean'))
    c = d;
else
    c = e;
end

bc = c-b;

ap = [0 -1;1 0]*bc';

b_x1 = b + (ap')*shift_parallel;
check_vect_unitaire = [b(1),b(2);b_x1(1),b_x1(2)];
abs(pdist(check_vect_unitaire,'euclidean'));

b_x2 = b - (ap')*shift_parallel;
check_vect_unitaire = [b(1),b(2);b_x2(1),b_x2(2)];
abs(pdist(check_vect_unitaire,'euclidean'));

end
