%% Tract-level ambient PM2.5 baseline computation
% Model baseline pollution in every tract against which marginal emissions
% are evaluated
%
% CHANGELOG
% - make global user-based variables start with prefix "u_" to help
%   distinguish them (also avoid using protected name 'method,' which is a
%   MATLAB function name)
% - clear IDW_Distribution after selection is made (for memory management)

% Read in input data (40 GB)
run Load_Workspace

%% Tract-level SR matrix data base template
% Cell (holds matrices -- i.e., a matrix of matrices) to hold tract-level
% marginal concentration matrices
DataBase_MC = cell(3,5);

%% Tract-level SR matrix interpolation
% Applicable for NH3, NOx, & SO2 and PMP & VOCs for point sources
% based on user-defined method and specification (62 GB)
idw = IDW_Distribution{idw_meth, idw_spec};
run Crosswalk_County_to_Tract

%% Clean up step
clear IDW_Distribution

%% end of script