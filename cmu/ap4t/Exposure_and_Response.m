%% Generate population, MR, and DR matrices
% 72,538 tracts and 19 age groups
% R1, C1 of Population_Data cell is total tract-level population 
% R2 contains tract-level subpopulations by race/ethnicity (see
% Exposure_and_Response_Subpop.m)
Pop_Matrix = Population_Data{1,1};

%% Mortality rates
% Row 1) Two methods: Dimenional and Distributional
    % Col 1) Dimensional = assign each tract its county's MRs
    % Col 2) Distributional = account for population breakdown by
    % race/ethnicity % of each tract; county-level MRs by race/ethnicity
    % distributed accordingly
    
MR_Matrix = MR_Data{1,2}; % Default = Distributional Method

%% Dose-respone
% Row 1) All-person beta coefficients
    % Col 1) American Cancer Society Cohort: Krewski et al. (2009)
    % Col 2) Harvard Six Cities Cohort: Lepeule et al. (2012)
    % Col 3) Medicare Cohort: Di et al. (2017)
DR_Matrix = DR_Data{1,1}; % Default = Krewski et al. (2009)
if rr_diff == 1
   DR_Matrix = DR_Data{1,3}; % Di et al. (2017) main -- assume applicable down to 30+ years
end

%% Population working matrices
Pop_Adult = Pop_Matrix;
Pop_Adult(:,1) = 0;
Pop_Infant = zeros(R,19);
Pop_Infant(:,1) = Pop_Matrix(:,1);

%% Model working matrix
One_Mat = ones(R,19);

%% end of script.