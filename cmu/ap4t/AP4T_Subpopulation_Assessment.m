%% Damages by race/ethnicity & age
% Read in precomputed experimental concentrations (1:107 from AP4T_Experimental_Counterfactual.m)
Spatial_EC = dlmread('AP4T_Outputs/fire_experiments_pm_precomputed.csv');

% Generate cell for damages by age
e = size(Spatial_EC,2);
Spatial_EDA = cell(1,e);

%% Subpopulation specifications
% U.S. Census defined subpopulations:
% A = WHITE ALONE                                           (g = 1)
% B = BLACK OR AFRICAN AMERICAN ALONE                       (g = 2)
% C = AMERICAN INDIAN AND ALASKA NATIVE ALONE               (g = 3)
% D = ASIAN ALONE                                           (g = 4)
% E = NATIVE HAWAIIAN AND OTHER PACIFIC ISLANDER ALONE      (g = 5)
% F = SOME OTHER RACE ALONE                                 (g = 6)
% G = TWO OR MORE RACES                                     (g = 7)
% H = WHITE ALONE, NOT HISPANIC OR LATINO                   (g = 8)
% I = HISPANIC OR LATINO                                    (g = 9)

g = 1;              % Subpopulation specification
label = "A";        % Subpopulation for file name
age = 1;            % Age differentiation indicator (i.e., does not sum damages across age groups)
rr_diff = 0;        % Differentiate relative risk: 0 = no (default) & 1 = yes (sensitivity)
br_diff = 1;        % Differentiate baseline risk: 0 = no (sensitivity) & 1 = yes (default)
run Exposure_and_Response_Subpop    % Use for subpopulation analysis
% run Exposure_and_Response         % Use for "Total" analysis
run Baseline_PM25_Health

%% Run air pollution experiments
% Cycle through experimental emissions inventories and track changes in
% PM2.5 concentrations

for i = 1:e
    fprintf('Subpopulation Assessment %d of %d\n', i, e);

    % Read change in concentrations from baseline
    PM25_Exp = PM25_Base - Spatial_EC(:,i); % ug/m^3

    % Run exposure and response assessment
	run Experimental_PM25_Health
	Spatial_EDA{1,i} = Base_Spatial_Damage - Exp_Spatial_Damage;

end

%% Fire type aggregation
Spatial_FDA = cell(2,3);

Spatial_FDA{1,1} = Spatial_EDA{1,50};  % wildfires
Spatial_FDA{1,2} = Spatial_EDA{1,100}; % prescribed burns
Spatial_FDA{1,3} = Spatial_EDA{1,101}; % total fires

%% Effects by source per captia
% Population by tract and age
Pop_Tract = Pop_Matrix;

% Normalize spatial matrices by population counts
Spatial_FDA{2,1} = Spatial_FDA{1,1}./Pop_Tract;
Spatial_FDA{2,2} = Spatial_FDA{1,2}./Pop_Tract;
Spatial_FDA{2,3} = Spatial_FDA{1,3}./Pop_Tract;

%% end of script.