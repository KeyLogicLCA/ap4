%% Load AP4 workspace
% Pulls in emissions data, S-R matrices, population & mortality rate data,
% dose-response information, and willingness-to-pay & economic data
% TODO: needs updated for AP4_Control_Workspace.h5
clear


% Make sure you have a copy of the input CSVs
run Download_EDX

% Define the input directory
input_dir = "AP4_Inputs/";

% Initialize the cell objects for the 2D arrays
Emissions_2017_NEI = cell(3,1); % ground, non-egu point, egu
SR_Matrices_Ground = cell(5,1); % NH3, NOx, PM25, SO2, VOC
SR_Matrices_Point_EGU = cell(5,1);
SR_Matrices_Point_Non_EGU = cell(5,1);

% Load the HDF5 as a struct and save 2D arrays to new cells.
% NOTE: HDF seems to store cols,rows so transpose to rows,cols.
S = load([input_dir "AP4_Control_Workspace.h5"], '-hdf5');

Emissions_2017_NEI{1,1} = S.Emissions_2017_NEI.element_0';
Emissions_2017_NEI{2,1} = S.Emissions_2017_NEI.element_1';
Emissions_2017_NEI{3,1} = S.Emissions_2017_NEI.element_2';

SR_Matrices_Ground{1,1} = S.SR_Matrices_Ground.element_0';
SR_Matrices_Ground{2,1} = S.SR_Matrices_Ground.element_1';
SR_Matrices_Ground{3,1} = S.SR_Matrices_Ground.element_2';
SR_Matrices_Ground{4,1} = S.SR_Matrices_Ground.element_3';
SR_Matrices_Ground{5,1} = S.SR_Matrices_Ground.element_4';

SR_Matrices_Point_Non_EGU{1,1} = S.SR_Matrices_Point_Non_EGU.element_0';
SR_Matrices_Point_Non_EGU{2,1} = S.SR_Matrices_Point_Non_EGU.element_1';
SR_Matrices_Point_Non_EGU{3,1} = S.SR_Matrices_Point_Non_EGU.element_2';
SR_Matrices_Point_Non_EGU{4,1} = S.SR_Matrices_Point_Non_EGU.element_3';
SR_Matrices_Point_Non_EGU{5,1} = S.SR_Matrices_Point_Non_EGU.element_4';

SR_Matrices_Point_EGU{1,1} = S.SR_Matrices_Point_EGU.element_0';
SR_Matrices_Point_EGU{2,1} = S.SR_Matrices_Point_EGU.element_1';
SR_Matrices_Point_EGU{3,1} = S.SR_Matrices_Point_EGU.element_2';
SR_Matrices_Point_EGU{4,1} = S.SR_Matrices_Point_EGU.element_3';
SR_Matrices_Point_EGU{5,1} = S.SR_Matrices_Point_EGU.element_4';

%% end of script.