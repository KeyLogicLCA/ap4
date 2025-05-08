%% Tract-level ambient PM2.5 baseline computation
% Model baseline pollution in every tract against which marginal emissions
% are evaluated
run Load_Workspace

%% Tract-level SR matrix data base template
% Cell (holds matrices -- i.e., a matrix of matrices) to hold tract-level
% marginal concentration matrices
DataBase_MC = cell(3,5);

%% Tract-level SR matrix interpolation
% Applicable for NH3, NOx, & SO2 and PMP & VOCs for point sources
% Method / Specification:
% 1) Closest Counties (cc) / 1) 3 cc, 2) 5 cc, 3) 10 cc
% 2) Counties w/in (cw) / 1) cw 30 miles, 2) cw 50 miles, 3) cw 100 miles
% 3) Adjacent Counties (ac) / 1) ac to home county, 2) + ac to those in 1
method = 1;
% Specification:
spec = 2;
idw = IDW_Distribution{method,spec};
run Crosswalk_County_to_Tract

%% end of script.