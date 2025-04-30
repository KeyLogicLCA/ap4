%% This script runs the AP4T model
% AP4T is an extension of AP4, using many of its inputs and much of its
% structure

%% AP4T Initation
% Computes tract-level baseline PM2.5, mortality risk, and damages
% Run time is ~12 minutes
run Reduced_Complexity_Initiation
run Baseline_PM25_Concentrations
run Dose_Response_and_Valuation_Modules

%% AP4T Experiments
% Runs experiments that take emissions out from the baseline
run AP4T_Experimental_Counterfactual  % ~100 seconds per experiment
run AP4T_Subpopulation_Assessment     % Quick (but requires manual changes)

%% AP4T Marginal
% APEEP (AP2,AP3,AP4) marginal ton algorithm (one ton at a time)
run AP4T_Marginal                     % ~30 minutes
run AP4T_Marginal_Tract               % ~30 minutes

%% end of script.