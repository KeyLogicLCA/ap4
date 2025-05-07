
%%
% This script runs the AP4 model to estimate PM2.5 baseline concentrations (line 9).
% This script imports the SR matrices for 12 industrial sectors (line 10).
% This script accepts user-defined emission vectors for industrial sources
% along with the SR matrices to estimate PM2.5 concentrations from
% industrial sources (line 11). Extraneous data cleared (line 12).

% Add a boolean switch to read industry emissions from file
% as found in NETL_AP4_PM25_Concentration_Script.m
api_key = "";
use_industry_emissions = true;

run PM_25_Base_Concentration
run NETL_AP4_Industrial_Source_Matrix_Import.m
run NETL_AP4_PM25_Concentration_Script.m
%run NETL_AP4_Clean_Up


%% end of script.
