function A = randomGraph(N, Wmean, Wstd, randomLaw)

if nargin < 4
    randomLaw = 'uniform';
end
if nargin < 3
    Wstd = 1;
end
if nargin < 2
    Wmean = 20;
end

A = zeros(N,N);

if strcmp(randomLaw, 'uniform')
    a = Wmean - sqrt(3*Wstd^4)/2;
    b = 2*Wmean - a;
%     display(sprintf('[a b] = [%.2f %.2f]', a, b));
else
    a2 = Wmean - sqrt(2*Wstd^4)/2;
    b2 = 2*Wmean - a2;
%     if strcmp(randomLaw,'gaussian') == 0
%         display(sprintf('[a b] = [%.2f %.2f]', a2, b2));
%     end
end


for i=1:N
    for j=i+1:N
        if strcmp(randomLaw, 'uniform')
            A(i,j) = random('Uniform', a, b);
        else
            if strcmp(randomLaw, 'gaussian')
                A(i,j) = abs(random('Normal', Wmean, Wstd));
            else
                if rand() < 0.5
                    A(i,j) = a2;
                else
                    A(i,j) = b2;
                end
            end
        end
        A(j,i) = A(i,j);
    end
end

