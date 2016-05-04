A = [0 0]
B = [5 5]
C = [3 3]
D = [-3 -3]

AB = B - A;
CD = D - C;

angle = acos(dot(AB,CD) / (norm(AB)*norm(CD)));
