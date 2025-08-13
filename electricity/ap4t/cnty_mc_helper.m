% cnty_mc_helper.m
%
% Requires: hdf5oct package (https://gapost.github.io/hdf5oct/)
% Installation instructions (https://gnu-octave.github.io/packages/hdf5oct/)

function [value] = read_hdf_mc(i,j,s_index,r_index) #output value will be single mc concentration
    % read_hdf_mc : extract a single mc from the hdf5 file without loading all into memory
    % inputs are [i,j] from (3,5) matrix, and [s_index, r_index] the elements inside a given matrix cell
    file = [hdf_dir 'cnty_mc.h5'];
    dataset_name = sprintf('/_%d/_%d', row, col);  % recreate S._i._j naming to be consistent
    value = h5read(file, dataset_name, [s_index, r_index], [i, j]);
end

%function adjustment
function value = read_hdf_mc(i, j, s_index, r_index)
    file = [hdf_dir 'cnty_mc.h5'];
    dataset_name = sprintf('/_%d/_%d', i, j);

    % Get dataset size so get col #
    info = h5info(file, dataset_name);
    dims = info.Dataspace.Size;  % e.g., [3108 3108] or [1859 3108]

    % Convert ":" to numeric start/count
    if ischar(r_index) && strcmp(r_index, ':')
        start = [s_index, 1];
        count = [1, dims(2)];  % 1 row, all columns
    else
        start = [s_index, r_index];
        count = [1, 1];  % single value
    end

    value = h5read(file, dataset_name, start, count);
end



% slightly confused about when the transpose happens and when to account for it
    %   i - row, source type (3)
    %   j - col, pollutant (5)
    %   s_index - source index (row that is transposed in final output?)
    %   r_index - receptor index (col that is transposed in final output)

% from MATLAB documentation...
% ex. data = h5read('example.h5','/g4/world',start,count)


% Removing this single load of all files
% Cnty_MC = cell(3,5);
% S = load([hdf_dir 'cnty_mc.h5'], '-hdf5');
% for i=1:size(Cnty_MC, 1)
%     for j=1:size(Cnty_MC, 2)
%         Cnty_MC{i, j} = eval(['S._' num2str(i, '%i'), '._' num2str(j, '%i')]);
%     endfor
% endfor
% clearvars S i j
% POOF!

% Trace through code to locate where Cnty_MC is used...
%
% A. Load_workspace.m (7x)
%   * already cleared up since replacing load at once with helper function
% B. Tract_to_Tract_calibration.m (9x)
%
%**************************************************************
% Need to find location of idx... instead of Cnty_MC{1,3}(idx,:), will use the helper
% (idx,:) where idx decides the row, and take the entire column. should i reshape output
% of the helper function st. [value] is a column? and doesnt specify based on

% PMP
% Cnty_MCs = Cnty_MC{1,3}(idx,:); % AP4 county-level
% MAPE = @(x)mean(abs(Cnty_MCs - x.*Cal_Vector)./Cnty_MCs);
% x = fminbnd(MAPE,0,10);
% Cal_PMP = x;

% % VOC
% Cnty_MCs = Cnty_MC{1,5}(idx,:); % AP4 county-level
% MAPE = @(x)mean(abs(Cnty_MCs - x.*Cal_Vector)./Cnty_MCs);
% x = fminbnd(MAPE,0,10);
% Cal_VOC = x;

% %% Clean up
% clear Cnty_MCs MAPE x n mean_s mean_sr Cal_Vector cols C num_rows
%

% C. Crosswalk_County_to_tract.m (16x)

%****************************************************************
%AP4_Tract_Setup_EGUs.m
% the origin of idx

%% Tract-level SR matrix
% Marginal concentration matrices for input county
%
% CHANGELOG
% - swap height for size
% - Change lookup w/o table
% - Swap out protected variable, index for idx

% eis = eis';
% F = size(eis, 1); % number of input facilities
% indices = zeros(F,1);
% for n = 1:F
%     % Indices of included facilities
%     % - note columns are ('row', 'fips', and 'eis')
%     idx = AP4_EGU_List(AP4_EGU_List(:,3) == eis(n,1), 1);
%     if size(idx, 1) ~= 1
%         idx = idx(1);
%     endif
%     indices(n,1) = idx;
% endfor

