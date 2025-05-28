%% This script runs the AP4 model
% Run time is < 10 min
% Set working directory in 'Load_Workspace.m' and 'AP4_Outputs.m' before
% starting the model
tic
run PM_25_Base_Concentration
run AP4_Setup
run AP4_Marginal_Concentrations_Ground
run AP4_Marginal_Concentrations_Non_EGU_Point
run AP4_Marginal_Concentrations_EGU_Point
run AP4_Outputs
run AP4_Post_Clean_Up
toc

%% end of script.