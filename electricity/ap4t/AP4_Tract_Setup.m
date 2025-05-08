%% Tract-level SR matrix
% Marginal concentration for input county
index = AP4_County_List.row(AP4_County_List.fips == fips(f),:);
Trct_MC = cell(2,5); % template for filling in

%% Tract-to-tract SR matrix pull
% Applicable for PM2.5-pri (PMP) & VOCs
% Calibration coefficients estimated using AP4 county-level impacts
run Tract_to_Tract_Calibration
Trct_MC{1,3} = Tract_to_Tract{index,1}.*Cal_PMP; % pmp
Trct_MC{1,5} = Tract_to_Tract{index,1}.*Cal_VOC; % voc

%% Tract-level SR matrix from interpolation
% Applicable for NH3, NOx, & SO2 and PMP & VOCs for point sources
% Ground-level
b = 1;
Trct_MC{b,1} = DataBase_MC{b,1}(index,:); % nh3
Trct_MC{b,2} = DataBase_MC{b,2}(index,:); % nox
Trct_MC{b,4} = DataBase_MC{b,4}(index,:); % so2
% Point sources
b = 2;
Trct_MC{b,1} = DataBase_MC{b,1}(index,:); % nh3
Trct_MC{b,2} = DataBase_MC{b,2}(index,:); % nox
Trct_MC{b,3} = DataBase_MC{b,3}(index,:); % pmp
Trct_MC{b,4} = DataBase_MC{b,4}(index,:); % so2
Trct_MC{b,5} = DataBase_MC{b,5}(index,:); % voc

%% Initialize source dimensions
% T = sources (i.e., tracts w/in specified county)
County_Tract_List = AP4_Tract_List(AP4_Tract_List.fips == fips(f),:);
T = height(County_Tract_List); % number of source tracts

%% Initialize marginal damage matrices for storage and export
% Groud-level and non-EGU point sources
Results_MC	= cell(2,5); % marginal concentrations
Results_MM	= cell(2,5); % marginal mortality
Results_MD	= cell(2,5); % marginal damages

MC_Tract_Matrix	= zeros(R,T);
MM_Tract_Matrix	= zeros(R,T);
MD_Tract_Matrix	= zeros(R,T);

%% end of script.