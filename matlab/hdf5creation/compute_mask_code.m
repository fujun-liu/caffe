%compute_mask_code
clear; close all; clc
data_root_path = '/home/fujunl/caffe-train-data';
load('code_indice.mat', 'code_indice');
k = length(code_indice);
data_ids = {'train', 'test'};

for data_index = 1:length(data_ids)
    data_id = data_ids{data_index}
    
    load([data_root_path '/muscle-data-mask-' data_id '.mat'],'label_data');
    n = length(label_data); 
    encoding = zeros(k, n);
    for j=1:n
        mask = label_data(:,:,j);
        for i = 1:k
            encoding(i,j) = mask(code_indice(i,1)) == mask(code_indice(i,2));
        end
    end
    save([data_root_path '/muscle-data-encoding-' data_id '.mat'],'encoding', '-v7.3');
end

