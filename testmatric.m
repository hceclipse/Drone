close all
clear all
clc

A = [1 2;3 4;5 6;7 8;inf inf;0 0;NaN NaN]
itter = 0;
for loop1 = 1:size(A,1)
%     for loop2 = 1:size(A,2)
        if A(loop1,:)== 0 0
            itter = itter+1
        end
%     end
end