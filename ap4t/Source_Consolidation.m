%% Tract-level S-R matrix consolidation
% Applicable for PMP & VOCs for ground-level sources

% run AP4T_Calibration/Calibration_Preliminary % Skip by default (results are Cal_non & Cal_own below)
% Results of preliminary calibration:
Cal_non = 0.766343128207634;
Cal_own = 0.126958657906070;

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
    fprintf('Source Consolidation: s = %d of %d\n', s, c);
    % County's tracts for consolidation
   	tracts = AP4T_Tract_List.id(AP4T_Tract_List.ap4 == s,:);
    % Tracts' populations for weighting
    populations = Population_Tract(tracts,2);
    pops_weight = populations/sum(populations);
    % Consolidate from tract-to-tract to county-to-tract
	ttt = Tract_to_Tract{s,1}; % Tract-to-tract
    tttpop = ttt .* pops_weight;
    ctt = sum(tttpop,1); % County-to-tract
	% Calibrate considering AP4 county-to-county SR matrices
    ctt = ctt.*Cal_non;                                 % Exported impacts
    ctt(1,tracts) = (Cal_own/Cal_non).*ctt(1,tracts);   % Own county impacts
    consolidation(s,:) = ctt;
end

%% Consolidated matrices
AP4T_SR_Matrices{1,3} = consolidation; % Primary PM2.5
AP4T_SR_Matrices{1,5} = consolidation; % VOCs

%% Tract-to-tract calibration & configuration
% Number of counties
c = height(AP4T_County_List);
for s = 1:c
	fprintf('Tract-to-Tract Calibration: s = %d of %d\n', s, c);
	tracts = AP4T_Tract_List.id(AP4T_Tract_List.ap4 == s,:);
    % Consolidate from tract-to-tract to county-to-tract
	ttt = Tract_to_Tract{s,1}; % Tract-to-tract
    % Calibrate considering AP4 county-to-county SR matrices
	ttt = ttt.*Cal_non;                                 % Exported impacts
    ttt(:,tracts) = (Cal_own/Cal_non).*ttt(:,tracts);   % Own county impacts
    Tract_to_Tract{s,1} = ttt;
end

%% end of script.