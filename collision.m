function E = collision(A,B,C,D)
% The variables A,B,C et D are the position of the points 
% every variable is composed of his 2d position (x,y)
% the output E is the position of the 2d intersection (x_colision,Y_colision)
Ax = A(1);
Ay = A(2);
Cx = C(1);
Cy = C(2);

AB = B - A;
CD = D - C;
ABx = AB(1);
ABy = AB(2);
CDx = CD(1);
CDy = CD(2);

AA = Ax*ABy - Ay*ABx;
CA = Cx*ABy - Cy*ABx;
CB = CDx*ABy - CDy*ABx;

mu = (AA - CA) / CB;
lambda = (Cx + mu * CDx - Ax) / ABx;

% if and(mu >= 0, and(mu <= 1, and(lambda>=0,lambda<=1))) % Prends en compte les extrémitées des droites.
if and(mu > 0, and(mu < 1, and(lambda>0,lambda<1))) % ne prend aucune extremité d'aucune droite (juste premier/dernier point)
    E = A+lambda*AB;
else
    E = NaN;
%     E = [mu lambda A+lambda*AB];
end

