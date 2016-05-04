function plotUniform(N, nExps, SIGMAS, Wmean, waitbarQ)

if nargin < 5
    waitbarQ = true;
end
if nargin < 4
    Wmean = 50;
end


nSigmas = length(SIGMAS);
mus = zeros(nSigmas, 3);
sts = zeros(nSigmas, 3);

if waitbarQ
    wb = waitbar(0,'Computation in progress...');
end
for i=1:nSigmas
    [mus(i,:),sts(i,:)] = testsTSP(N, nExps, Wmean, SIGMAS(i), 'uniform');
    
    if waitbarQ
        waitbar(i/nSigmas,wb);
    end
end
if waitbarQ
    close(wb);
end

figure
hold on
errorbar(SIGMAS, mus(:,1), sts(:,1), 'red');
errorbar(SIGMAS, mus(:,2), sts(:,2), 'green');
errorbar(SIGMAS, mus(:,3), sts(:,3), 'blue');
