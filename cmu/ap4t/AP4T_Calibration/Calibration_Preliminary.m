%% Preliminary calibration for AP4T - Using AP4
% Applicable for PMP & VOCs for ground-level sources

% Population by census tract for source (tract level) consolidation to
% county level, using population weighting
t = height(AP4T_Tract_List);
Tract = [1:1:t]';
Population_Tract = sum(Population_Data{1,1},2);
Population_Tract = [Tract Population_Tract];

%% Tract-to-county consolidation
% Number of counties
c = height(AP4T_County_List);
consolidation = zeros(c,t);
for s = 1:c
    fprintf('Tract-to-Tract Testing Matrix 1 of 2: s = %d of %d\n', s, c);
    % County's tracts for consolidation
   	tracts = AP4T_Tract_List.id(AP4T_Tract_List.ap4 == s,:);
    % Tracts' populations for weighting
    populations = Population_Tract(tracts,2);
    pops_weight = populations/sum(populations);
    
    % Consolidate from tract-to-tract to county-to-tract
	ttt = Tract_to_Tract{s,1}; % Tract-to-tract
    tttpop = ttt .* pops_weight;
    ctt = sum(tttpop,1); % County-to-tract
    consolidation(s,:) = ctt;
end

%% S-R matrix testing
% Estimate county-to-county impacts, using population weighting.
% Preparation for comparison to AP4 county-level modeling
tfc = consolidation';
test = zeros(c,c);
for r = 1:c
    fprintf('Tract-to-Tract Testing Matrix 2 of 2: r = %d of %d\n', r, c);
    % County's tracts for testing
   	tracts = AP4T_Tract_List.id(AP4T_Tract_List.ap4 == r,:);
    % Tracts' populations for weighting
    populations = Population_Tract(tracts,2);
    pops_weight = populations/sum(populations);
    
    % Consolidate from county-to-tract to county-to-county
	cfc = tfc(tracts,:);
    cfcpop = cfc .* pops_weight;
    ctc = sum(cfcpop,1);
    test(:,r) = ctc; % Test matrix (tract-to-tract --> county-to-county)
end
comp = AP4_SR_Matrices{1,3}; % Compare matrix (county-to-county)

%% Check consolidated tract-to-tract matrices w/ AP4
% AP4 performs up to standards for 3D air quality modeling at the county
% level and provides a reference for comparison of tract-to-tract Gaussian
% plume modeling
% AP4T's tract-to-tract overpredicts compared to AP4, which already over
% predicts. Calibrate down to improve performance

% All non-own counties (exports)
test_non = test;
comp_non = comp;
for i = 1:3108
    test_non(i,i) = nan;
	comp_non(i,i) = nan;
end

AE_non = abs(test_non - comp_non);
Err_non = (test_non - comp_non);
MAE_non_check = nanmean(AE_non,'all');
MErr_non = nanmean(Err_non,'all');

% Optimization function for calibration
MAE_non = @(x)calibrate_non(x,comp_non,test_non);
x0 = [1]; % Initial values for coefficient
lb = [0.01]; % Lower bounds for coefficient
[x,fval] = fmincon(MAE_non,x0,[],[],[],[],lb);
MAE_non = fval/1e9;
Cal_non = x;

%% Check own county impacts
% Within county tract-level impacts have a higher error than downwind
% tract-level impacts. Calibrate down to improve performance

% Own counties
test_own = nan(3108,3108);
comp_own = nan(3108,3108);
test_diag = diag(test);
comp_diag = diag(comp);

for i = 1:3108
    test_own(i,i) = test_diag(i,1);
	comp_own(i,i) = comp_diag(i,1);
end

AE_own = abs(test_own - comp_own);
Err_own = (test_own - comp_own);
MAE_own_check = nanmean(AE_own,'all');
MErr_own = nanmean(Err_own,'all');

% Optimization function for calibration
MAE_own = @(x)calibrate_own(x,comp_own,test_own);
x0 = [1]; % Initial values for coefficient
lb = [0.01]; % Lower bounds for coefficient
[x,fval] = fmincon(MAE_own,x0,[],[],[],[],lb);
MAE_own = fval/1e9;
Cal_own = x;

%% Clean up
clear t Tract Population_Tract c s tracts populations ...
    pops_weight ttt tttpop ctt tfc test r cfc cfcpop ctc comp AE_non ...
    Err_non MAE_non MErr_non comp_own test_own FE_own FB_own MAE_own ...
    MErr_own x0 lb x MAE_non_check MAE_own_check

%% Objective function: Minimize mean absolute error

function MAE_non = calibrate_non(Cal,C,T)
    % Mean absolute error
    MAE_non = nanmean(abs(Cal.*T - C),'all')*1e9; % x 1 billion to push optimization goals
end

function MAE_own = calibrate_own(Cal,C,T)
    MAE_own = nanmean(abs(Cal.*T - C),'all')*1e9;
end

%% end of script.