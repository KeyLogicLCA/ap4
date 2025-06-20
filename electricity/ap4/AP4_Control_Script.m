%% This script runs the AP4 model
% Run time is < 10 min
% Make sure the working directory is electricity/ap4 before running model.

% Global variables
% - api_key (str) for EDX download (use 'abc' to skip)
% - run_verbose (bool) for printing marginal concentration emissions progress
api_key = "";
run_verbose = false;

% Main methods
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