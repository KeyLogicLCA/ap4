%% Initialize source dimensions
% S = ground and non-egu point
% E = egu point

S = 3108;
E = 1814;

%% Manage exposure and response inputs
run Population

% Dose-response specification: ACS = 1 & H6C = 2
epi_study = 1;
run Dose_Response

%% Willingness-to-pay (WTP) for mortality risk reductions
wtp_year = 2017;    % Year for analysis (2000-2020)
usd_year = 2020;    % Year for USD (2000-2020)
run Mortality_Risk_Valuation
run PM_25_Health_Base

%% Initialize marginal damage matrices for storage and export
MD_Ground           = zeros(S,5);
MD_Non_EGU_Point    = zeros(S,5);
MD_EGU_Point        = zeros(E,5);

%% end of script.
