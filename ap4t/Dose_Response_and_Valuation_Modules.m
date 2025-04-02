%% Initialize receptor dimensions
% R = receptors (i.e., tracts)
R = height(AP4T_Tract_List);

%% Manage exposure and response inputs
% Tract-level population, mortality rate, and dose-response inventories
rr_diff = 0;        % Default setting is to treat relative risk uniformly
run Exposure_and_Response

%% Willingness-to-pay (WTP) for mortality risk reductions
wtp_year = 2017;    % Year for analysis (options: 2000-2020)
usd_year = 2020;    % Year for USD (options: 2000-2020)
run Mortality_Risk_Valuation

%% Baseline impacts
% Premature mortality, & damages from all pollution from all emission
% sources
age = 0;
run Baseline_PM25_Health

%% end of script.