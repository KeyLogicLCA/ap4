%% This script uploads the matrices for NETL Industrial source modeling.
% These are the source-receptor matrices for facilities under each NAICS code
% and the 3108 counties---the number of rows varies by NAICS and chemistry
% (i.e., not all facilities emit all chemicals).

% Define the chemical abbreviations in the correct order.
chem_list = cell(5,1);
chem_list(1,1) = 'NH3';
chem_list(2,1) = 'HNO3';
chem_list(3,1) = 'PMP';
chem_list(4,1) = 'SO4';
chem_list(5,1) = 'VOC';

% Deine the NAICS codes that are CSV files.
naics_list = cell(13,1);
naics_list(1,1) = '322110';
naics_list(2,1) = '3221201';
naics_list(3,1) = '322130';
naics_list(4,1) = '325120';
naics_list(5,1) = '325180';
naics_list(6,1) = '325193';
naics_list(7,1) = '325311';
naics_list(8,1) = '327310';
naics_list(9,1) = '331110';
naics_list(10,1) = '331511';
naics_list(11,1) = '331512';
naics_list(12,1) = '331513';
naics_list(13,1) = 'NG';

% For each NAICS code...
for j = 1:13
    ncode = naics_list{j, 1};
    % initialize a 5x1 cell and...
    str1 = ['NAICS_' ncode '= cell(5,1);'];
    eval(str1);
    % for each chemistry...
    for i = 1:5
        fname = glob([mat_dir 'SRM_' chem_list{i,1} '_' ncode '.csv']);
        % read the CSV matrix file into that cell.
        if (numel(fname) == 1)
            fname = fname{1,1};
            disp(['Reading', fname]);
            str2 = ['NAICS_' ncode '{' num2str(i) ', 1} = dlmread(fname, '','');'];
            eval(str2);
        endif
    end
end

clear ncode fname
clear str1 str2
clear i j

% end script
