function saving = computeSaving(i, j, A)


if (A(i,j) == -1)
    display('i et j doivent etre voisins...');
    return;
end

Aij = A(i,j);
max = 0;

for k=[1:i-1 i+1:length(A)]
    if A(i,k) ~= -1 && A(k,j) ~= -1
        sav = A(i,k) + A(k,j) - Aij;
        
        if sav > max
            max = sav;
        end
    end
end

saving = max;
