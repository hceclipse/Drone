function [distance,path] = TSPBruteForce(A, initNode)

if nargin < 2
    initNode = 1;
end


N = length(A);

paths = perms([1:initNode-1 initNode+1:N]);

path = [initNode paths(1,:) initNode];
distance = computeDist(A, path);

for i=2:size(paths,1)
    tmpDist = computeDist(A, paths(i,:));
    if tmpDist < distance
        distance = tmpDist;
        path = paths(i,:);
    end
end
