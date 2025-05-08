%% Initialize receptor dimensions
% R = receptors (i.e., tracts)
R = height(AP4_Tract_List);

%% Manage exposure and response inputs
% Tract-level population inventories
run Population

% Dose-response specification for risk assessment: ACS = 1 & H6C = 2
epi_study = 1;
run Dose_Response

%% Willingness-to-pay (WTP) for mortality risk reductions
wtp_year = 2017;    % Year for analysis (options: 2000-2020)
usd_year = 2020;    % Year for USD (options: 2000-2020)
run Mortality_Risk_Valuation

%% end of script.