%% Load AP4 (2024) workspace
% Pulls in emissions data, S-R matrices, population & mortality rate data,
% dose-response information, and willingness-to-pay & economic data

% Tyler's Cheat Sheet.
% `cd` or `chdir` ............ Change directory
% `who` ...................... Show variables in memory

clear

% Make sure you have a copy of the input CSVs
run Download_EDX.m

% Define folders
info_dir = 'Info_Matrices/';
mat_dir = 'Matrices/';

% Create 3x1 set
Emissions_2020_NEI = cell(3,1);
% Ground matrix
A1 = dlmread([mat_dir 'Emissions_G_NH3.csv'], ',');
A2 = dlmread([mat_dir 'Emissions_G_NOX.csv'], ',');
A3 = dlmread([mat_dir 'Emissions_G_PMP.csv'], ',');
A4 = dlmread([mat_dir 'Emissions_G_SO2.csv'], ',');
A5 = dlmread([mat_dir 'Emissions_G_VOC.csv'], ',');
A6 = dlmread([mat_dir 'Emissions_G_VOCB.csv'], ',');
Emissions_2020_NEI{1,1} = [A1 A2 A3 A4 A5 A6];
clear A1 A2 A3 A4 A5 A6

% Non-EGU point source matrix
B1 = dlmread([mat_dir 'Emissions_PNEGU_NH3.csv'], ',');
B2 = dlmread([mat_dir 'Emissions_PNEGU_NOX.csv'], ',');
B3 = dlmread([mat_dir 'Emissions_PNEGU_PMP.csv'], ',');
B4 = dlmread([mat_dir 'Emissions_PNEGU_SO2.csv'], ',');
B5 = dlmread([mat_dir 'Emissions_PNEGU_VOC.csv'], ',');
Emissions_2020_NEI{2,1} = [B1 B2 B3 B4 B5];
clear B1 B2 B3 B4 B5

% EGU point source matrix
C1 = dlmread([mat_dir 'Emissions_EGU_NH3.csv'], ',');
C2 = dlmread([mat_dir 'Emissions_EGU_NOX.csv'], ',');
C3 = dlmread([mat_dir 'Emissions_EGU_PMP.csv'], ',');
C4 = dlmread([mat_dir 'Emissions_EGU_SO2.csv'], ',');
C5 = dlmread([mat_dir 'Emissions_EGU_VOC.csv'], ',');
Emissions_2020_NEI{3,1} = [C1 C2 C3 C4 C5];
clear C1 C2 C3 C4 C5

% Create SRM sets
SR_Matrices_Ground = cell(6,1);
SR_Matrices_Ground{1,1} = dlmread([mat_dir 'SRM_G_NH3.csv'], ',');
SR_Matrices_Ground{2,1} = dlmread([mat_dir 'SRM_G_HNO3.csv'], ',');
SR_Matrices_Ground{3,1} = dlmread([mat_dir 'SRM_G_PMP.csv'], ',');
SR_Matrices_Ground{4,1} = dlmread([mat_dir 'SRM_G_SO4.csv'], ',');
SR_Matrices_Ground{5,1} = dlmread([mat_dir 'SRM_G_VOC.csv'], ',');
SR_Matrices_Ground{6,1} = dlmread([mat_dir 'SRM_G_VOCB.csv'], ',');

SR_Matrices_Point_Non_EGU = cell(5,1);
SR_Matrices_Point_Non_EGU{1,1} = dlmread([mat_dir 'SRM_PNEGU_NH3.csv'], ',');
SR_Matrices_Point_Non_EGU{2,1} = dlmread([mat_dir 'SRM_PNEGU_HNO3.csv'], ',');
SR_Matrices_Point_Non_EGU{3,1} = dlmread([mat_dir 'SRM_PNEGU_PMP.csv'], ',');
SR_Matrices_Point_Non_EGU{4,1} = dlmread([mat_dir 'SRM_PNEGU_SO4.csv'], ',');
SR_Matrices_Point_Non_EGU{5,1} = dlmread([mat_dir 'SRM_PNEGU_VOC.csv'], ',');

SR_Matrices_Point_EGU = cell(5,1);
SR_Matrices_Point_EGU{1,1} = dlmread([mat_dir 'SRM_EGU_NH3.csv'], ',');
SR_Matrices_Point_EGU{2,1} = dlmread([mat_dir 'SRM_EGU_HNO3.csv'], ',');
SR_Matrices_Point_EGU{3,1} = dlmread([mat_dir 'SRM_EGU_PMP.csv'], ',');
SR_Matrices_Point_EGU{4,1} = dlmread([mat_dir 'SRM_EGU_SO4.csv'], ',');
SR_Matrices_Point_EGU{5,1} = dlmread([mat_dir 'SRM_EGU_VOC.csv'], ',');


%load 'C:\Users\nzm\AP4\Model\AP4_Control_Workspace.mat'

%% end of script.
