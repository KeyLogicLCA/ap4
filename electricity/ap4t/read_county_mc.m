function [value] = read_county_mc(i,j,hdf_dir)
    % inputs are [i,j] from (3,5) Cell
    file = [hdf_dir 'cnty_mc.h5'];
    dataset_name = sprintf('/%d/%d', i, j);  % recreate S._i._j naming to be consistent
    
    % outputs matrix corresponding to i,j
    value = h5read(file, dataset_name); 

end


