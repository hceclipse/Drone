function [L2,S2] = sortList(L, S)

[S2,I] = sort(S,'descend');
L2 = L(:,I);
