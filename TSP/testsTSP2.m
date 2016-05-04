function [mu,st] = testsTSP2(N, nExps, Wmean, Wstd, randomLaw)


DISTS = zeros(nExps,2);


A = randomGraph(N, Wmean, 0, 'gaussian');
[~,globSol] = TSPsolution(A);

parfor i=1:nExps
    A = randomGraph(N, Wmean, Wstd, randomLaw);
    DISTS(i,:) = [computeDist(A, globSol), TSPsolution(A)];
end

mu = mean(DISTS);
st = std(DISTS);
