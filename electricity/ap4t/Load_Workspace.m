%% Load AP4_Tract workspace
% Pulls in maringal concentration matrices, inverse distance weighting
% criteria, population & mortality rate data, dose-response information,
% and willingness-to-pay & economic data
clear
load 'AP4_Tract_Inputs/AP4_Tract_Control_Workspace_1_of_3.mat'
load 'AP4_Tract_Inputs/AP4_Tract_Control_Workspace_2_of_3.mat'
load 'AP4_Tract_Inputs/AP4_Tract_Control_Workspace_3_of_3.mat'

Tract_to_Tract = [Tract_to_Tract_1_of_2; Tract_to_Tract_2_of_2];
clearvars Tract_to_Tract_1_of_2 Tract_to_Tract_2_of_2

%% end of script.