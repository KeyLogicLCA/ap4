%% This script extracts results from the AP4_Tract model
%
% CHANGELOG
% - replace tablewrite w/ dlmwrite
% - save common directory names to variables
% - rename protected method name 'title' to 'u_title'
% - moved function to its own function file
% - add check for Tract Info Receptors CSV file
% - add existence checks for output folder creation
% - include archive option for outputs

% Emissions and source-receptor matrices are in metric tons
% Convert to short tons
mt_to_st = 1/1.10231131;

output_dir = 'AP4_Tract_Outputs/';
egu_dir = [output_dir 'AP4_Tract_EGUs/'];
title_dir = [egu_dir 'AP4_Tract_' u_title '/'];

% Save receptor (tract) IDs
% Note: redundant CSV file found in AP4_Tract_Outputs.m
r_file = [output_dir 'AP4_Tract_Info_Receptors.csv'];
if exist(r_file) ~= 2
    dlmwrite(r_file, AP4_Tract_List(:, 3), ",");
endif

% Create folders for outputs
if exist(egu_dir) ~= 7
    mkdir(egu_dir);
endif

if exist(title_dir) ~= 7
    mkdir(title_dir);
endif

%% AP4_Tract output: NH3
p = 1;
pollutant = 'NH3';
p_dir = [title_dir 'AP4_Tract_' pollutant '_' u_title, '/'];
mkdir(p_dir);
tractOutputF3(u_title, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)

%% AP4_Tract output: NOx
p = 2;
pollutant = 'NOx';
p_dir = [title_dir 'AP4_Tract_' pollutant '_' u_title '/'];
mkdir(p_dir);
tractOutputF3(u_title, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)

%% AP4_Tract output: PMP
p = 3;
pollutant = 'PMP';
p_dir = [title_dir 'AP4_Tract_' pollutant '_' u_title '/'];
mkdir(p_dir);
tractOutputF3(u_title, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)

%% AP4_Tract output: SO2
p = 4;
pollutant = 'SO2';
p_dir = [title_dir 'AP4_Tract_' pollutant '_' u_title '/'];
mkdir(p_dir);
tractOutputF3(u_title, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)

%% AP4_Tract output: VOC
p = 5;
pollutant = 'VOC';
p_dir = [title_dir 'AP4_Tract_' pollutant '_' u_title '/'];
mkdir(p_dir);
tractOutputF3(u_title, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)

%% end of script.