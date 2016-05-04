function distance = computeDist(A, path)

distance = 0;

for i=1:length(path)-1
    distance = distance + A(path(i),path(i+1));
end
