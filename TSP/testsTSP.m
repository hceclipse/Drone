function [mu,st] = testsTSP(N, nExps, Wmean, Wstd, randomLaw)


DISTS = zeros(nExps,3);


A = randomGraph(N, Wmean, 0, 'gaussian');
[~,globSol] = TSPsolution(A);

parfor i=1:nExps
    A = randomGraph(N, Wmean, Wstd, randomLaw);
    DISTS(i,:) = [computeDist(A, globSol), TSPsolution(A), TSPBruteForce(A)];
end

mu = mean(DISTS);
st = std(DISTS);
