%% Initiate the AP4T model
% Prepare Gaussian plume-based transport source-receptor matrices to model
% baseline pollution in every census tract against which marginal
% emissions/sources are evaluated

%% Load pre-defined workspace
run Load_Workspace

%% Tract-level SR matrix database template
% Source-receptor (i.e., tracts) database for bin-pollutant pairs
AP4T_SR_Matrices = cell(3,5);

%% County-to-county receptor interpolation
% Applicable for NH3, NOx, & SO2 for all sources and PMP & VOCs for point
% sources

% Interpolate receptor counties to the tract level using inverse distance
% weighted (IDW) averages, assumes tract impacts are a linear combination
% of nearby county impacts

% Base case method is to use the home county plus two levels of adjacency
% with a power parameter of 0.5.
% Interpolation can run with a number of closest counties (3, 5, or 10),
% counties within a specific radius (20, 30, or 50 miles), or addtional
% layers of adjacency (i.e., next most adjacent counties moving out from
% the tract's home county). IDW can also employ power parameter of 1 or 2
% instead of 0.5

run Receptor_Interpolation

%% Tract-to-tract source consolidation
% Applicable for PMP & VOCs for non-fire ground-level sources

% Consolidate source tracts to the county level using population weighting,
% assumes economic activity is correlated with populations and emissions

% Tract-to-tract SR matrices are calibrated using county-to-county SR
% matrices (brings transport estimates down; AP4 already tends to
% overestimate)

run Source_Consolidation

%% end of script.