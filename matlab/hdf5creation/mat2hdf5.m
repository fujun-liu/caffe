%% WRITING TO HDF5
data_root_path = '/home/fujunl/caffe-train-data';
data_ids = {'train', 'test'};
for data_index = 1:length(data_ids)
    data_id = data_ids{data_index}
    
    load([data_root_path '/muscle-data-mask-' data_id '.mat'],'img_data');
    load([data_root_path '/muscle-data-encoding-' data_id '.mat'],'encoding');
    filename=[data_root_path '/muscle-data-' data_id '.h5'];
    
    num_total_samples = length(img_data);
    
    endchunksz=100;
    created_flag=false;
    totalct=0;
    for batchno=1:num_total_samples/chunksz
      fprintf('batch no. %d\n', batchno);
      last_read=(batchno-1)*chunksz;

      % to simulate maximum data to be held in memory before dumping to hdf5 file 
      batchdata=img_data(:,:,:,last_read+1:last_read+chunksz); 
      batchlabs=encoding(:,last_read+1:last_read+chunksz);

      % store to hdf5
      startloc=struct('dat',[1,1,1,totalct+1], 'lab', [1,totalct+1]);
      curr_dat_sz=store2hdf5(filename, batchdata, batchlabs, ~created_flag, startloc, chunksz); 
      created_flag=true;% flag set so that file is created only once
      totalct=curr_dat_sz(end);% updated dataset size (#samples)
    end

    % display structure of the stored HDF5 file
    h5disp(filename);
end



