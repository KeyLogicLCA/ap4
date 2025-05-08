%% Tract-level SR matrix
% Marginal concentration matrices for input county
eis = eis';
F = height(eis); % number of input facilities
indices = zeros(F,1);
for n = 1:F
    % Indices of included facilities
    index = AP4_EGU_List.row(AP4_EGU_List.eis == eis(n,1),:);
    if height(index) ~= 1
        index = index(1);
    end
    indices(n,1) = index;
end

%% Tract-level SR matrix interpolation
% EGU Point sources
b = 3;
Trct_MC_EGU = cell(1,5);
Trct_MC_EGU{1,1} = DataBase_MC{b,1}(indices,:); % nh3
Trct_MC_EGU{1,2} = DataBase_MC{b,2}(indices,:); % nox
Trct_MC_EGU{1,3} = DataBase_MC{b,3}(indices,:); % pmp
Trct_MC_EGU{1,4} = DataBase_MC{b,4}(indices,:); % so2
Trct_MC_EGU{1,5} = DataBase_MC{b,5}(indices,:); % voc

%% Initialize marginal damage matrices for storage and export
% EGU point sources
Results_MC	= cell(1,5); % marginal concentrations
Results_MM	= cell(1,5); % marginal mortality
Results_MD	= cell(1,5); % marginal damages

MC_Tract_Matrix	= zeros(R,F);
MM_Tract_Matrix	= zeros(R,F);
MD_Tract_Matrix	= zeros(R,F);

%% end of script.