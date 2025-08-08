%% Convert from tract-to-tract to county-to-tract
% Relevant for ground-level PMP and VOCs that are modeled tract-to-tract.
% Coding aggregates via a population-weighted average incase the user does
% not know the specific tract from which emissions come but rather just the
% county.
%
% CHANGELOG
% - Update search w/o table; cols are ('ap4', 'fips', 'tract', and 'id')
% - add clean up step
% - add air quality only if-statement
% - fix fips(1) in tract_ids; should be for fips(f)

tract_ids = AP4_Tract_List(AP4_Tract_List(:, 2) == fips(f), 4);
tract_pop = zeros(size(tract_ids,1),1);

%% Extract a county's tract's populations
% Tract populations
for n = 1:size(tract_pop,1)
    tract_pop(n,1) = Pop_Total(tract_ids(n,1),1);
endfor

% Weights
tract_pop = tract_pop/sum(tract_pop);

%% Marginal impact conversion
% Concentrations
Results_MC{1,3} = sum(tract_pop'.*Results_MC{1,3},2);
Results_MC{1,5} = sum(tract_pop'.*Results_MC{1,5},2);

if ~aqm_only
    % Mortality
    Results_MM{1,3} = sum(tract_pop'.*Results_MM{1,3},2);
    Results_MM{1,5} = sum(tract_pop'.*Results_MM{1,5},2);
    % Damages
    Results_MD{1,3} = sum(tract_pop'.*Results_MD{1,3},2);
    Results_MD{1,5} = sum(tract_pop'.*Results_MD{1,5},2);
endif

%% Clean up
clear n tract_ids tract_pop

%% end of script.