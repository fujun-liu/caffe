% 
mask_size = 16;
B = zeros(mask_size, mask_size);
B(1:2:end, 1:2:end) = 1;
[y,x] = find(B > 0);
linInd = sub2ind(size(B), y, x);
pairs = [];
for i = 1:length(linInd-1)
    for j = i+1:length(linInd)
        pairs = [pairs; linInd(i) linInd(j)];
    end
end

k = 500;
randIndice = randperm(length(pairs), k);
code_indice = pairs(randIndice, :);
size(code_indice)
save('code_indice.mat', 'code_indice');