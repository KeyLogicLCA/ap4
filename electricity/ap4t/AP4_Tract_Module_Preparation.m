% AP4_Tract_Module_Preparation.m
%
% CHANGELOG
% - swap height for size for AP4_Tract_List
% - append "u_" to user-selected variable
% - move One and One Mat from Population (it's better here)

%% Initiate number of receptors
R = size(AP4_Tract_List, 1);

%% Working matrices (for PM_25_Health)
One = ones(1,19);
One_Mat = ones(R,19);

%% Manage exposure and response inputs
% Tract-level population inventories
run Population

if ~aqm_only
    % Dose-response specification for risk assessment: ACS = 1 & H6C = 2
    run Dose_Response
    %% Willingness-to-pay (WTP) for mortality risk reductions
    run Mortality_Risk_Valuation
endif

%% Clean up
clear DR_Info Population_Data

%% end of script.