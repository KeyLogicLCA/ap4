%% Generate population, MR, and DR matrices
% 72,538 tracts and 19 age groups

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

Pop_Matrix = Population_Data{2,g}; % Tract-level population data

%% Mortality rates
% Row 1) Two methods: Dimenional and Distributional
    % Col 1) Dimensional = assign each tract its county's MRs
    % Col 2) Distributional = account for population breakdown by
    % race/ethnicity % of each tract; county-level MRs by race/ethnicity
    % distributed accordingly

% Row 2) contains county-level (tract-dimensional) subpopulation MRs by
% race/ethnicity; organized to align with populations A-I (see technical
% appendix)

MR_Matrix = MR_Data{2,g};
if br_diff == 0                 % Uniform baseline risk sensitivity analysis
   MR_Matrix = MR_Data{1,1};    % Dimensional approach
   MR_Matrix = MR_Data{1,2};    % Distributional approach (default)
end

%% Dose-respone
% Row 1) All-person beta coefficients
    % Col 1) American Cancer Society Cohort: Krewski et al. (2009)
    % Col 2) Harvard Six Cities Cohort: Lepeule et al. (2012)
    % Col 3) Medicare Cohort: Di et al. (2017)
DR_Matrix = DR_Data{1,1};       % ACS (default)

% Row 2) Differentiated beta coefficients from Di et al. (2017)
    % Assumes RRs determined with 65 and older population extends down to
    % 30 and older population; organized to align with populations A-I (see
    % technical appendix)
if rr_diff == 1                 % Differentiated relative risk sensitivity analysis
    DR_Matrix = DR_Data{2,g};   % Medicare cohort
end

%% Population working matrices
Pop_Adult = Pop_Matrix;
Pop_Adult(:,1) = 0;
Pop_Infant = zeros(R,19);
Pop_Infant(:,1) = Pop_Matrix(:,1);

%% Model working matrix
One_Mat = ones(R,19);

%% end of script.