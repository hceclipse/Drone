function [L,S] = listSavings(A, initNode)

N = length(A);

L = zeros(2,N*(N-1));
S = zeros(1,N*(N-1));

nlinks = 0;

for i=[1:initNode-1 initNode+1:N]
    for j=i+1:N
        if A(i,j) ~= -1
            nlinks = nlinks+1;
            
            L(:,nlinks) = [i; j];
            S(nlinks) = computeSaving(i, j, A);
        end
    end
end

[L,S] = sortList(L(:,1:nlinks),S(1:nlinks));
