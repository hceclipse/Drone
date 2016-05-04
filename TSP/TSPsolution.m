function [distance,path] = TSPsolution(A, initNode)

if nargin < 2
    initNode = 1;
end


N = length(A);
[L,~] = listSavings(A, initNode);

distance = 0;

paths = cell(1,round(N/2));

IN = zeros(1,N);
nSP = 0;
BESP = zeros(round(N/2),2);

k = 1;
while length(paths{1}) < N-1
    i = L(1,k);
    j = L(2,k);
    
%     display(sprintf('[i j] = [%d %d]', i, j));
    
    % 1. i and j are new nodes -> new subpath
    if IN(i) == 0 && IN(j) == 0
%         display('Case 1');
        nSP = nSP + 1;
        paths{nSP} = [i j];
        BESP(nSP,:) = [i j];
        IN(i) = nSP;
        IN(j) = nSP;
        
        distance = distance + A(i,j);
    else
        % 2. i xor j is a new node
        if (IN(i) > 0 && IN(j) == 0) || (IN(j) > 0 && IN(i) == 0)
%             display('Case 2');
            if IN(j) > 0 && IN(i) == 0
                % exchange i and j
                t = i;
                i = j;
                j = t;
            end

            p = paths{IN(i)};
            if p(1) == i || p(length(p)) == i
                if p(1) == i
                    paths{IN(i)} = [j paths{IN(i)}];
                    BESP(IN(i),1) = j;
                    IN(j) = IN(i);
                else
                    paths{IN(i)} = [paths{IN(i)} j];
                    BESP(IN(i),2) = j;
                    IN(j) = IN(i);
                end
                
                distance = distance + A(i,j);
            end
        else
%             display('Case 3');
            % 3. i and j are old nodes -> connect subpaths ?
            if sum(sum(BESP == i)) > 0 && sum(sum(BESP == j)) > 0
                % Connection possible
                spi = [find(BESP(:,1) == i) find(BESP(:,2) == i)];
                spi = spi(1);
                spj = [find(BESP(:,1) == j) find(BESP(:,2) == j)];
                spj = spj(1);

                if spi ~= spj
                    if spi > spj
                        t = spi;
                        spi = spj;
                        spj = t;
                        t = i;
                        i = j;
                        j = t;
                    end

                    pathI = paths{spi};
                    pathJ = paths{spj};
                    if pathI(1) == i
                        if pathJ(1) == j
                            paths{spi} = [pathJ(length(pathJ):-1:1) pathI];
                            BESP(spi,1) = pathJ(length(pathJ));
                        else
                            paths{spi} = [pathJ pathI];
                            BESP(spi,1) = pathJ(1);
                        end
                    else
                        if pathJ(1) == j
                            paths{spi} = [pathI pathJ];
                            BESP(spi,2) = pathJ(length(pathJ));
                        else
                            paths{spi} = [pathI pathJ(length(pathJ):-1:1)];
                            BESP(spi,2) = pathJ(1);
                        end
                    end
                    
                    IN(IN == spj) = spi;
                    
                    for l=spj:nSP
                        paths{l} = paths{l+1};
                        BESP(l,:) = BESP(l+1,:);
                        IN(IN == l+1) = l;
                    end
                    BESP(nSP,:) = [0 0];
                    nSP = nSP - 1;

                    distance = distance + A(i,j);
                end
            end
        end
    end
    
%     for l=1:nSP
%         display(paths{l});
%     end
%     display(BESP);
%     display(IN);
    
    k = k + 1;
end


path = [initNode paths{1} initNode];
distance = distance + A(initNode,path(2)) + A(path(length(path)-1),initNode);

% if distance ~= computeDist(A,path)
%     error('Probleme dans le calcul de la distance...');
% end
