%% Initialize source dimensions
% S = ground and non-egu point
% E = egu point

S = 3108;
E = 1859;

%% Initialize marginal damage matrices for storage and export
Results_MC        	= cell(3,5);
MC_County_Matrix    = zeros(S,S);
MC_EGU_Matrix       = zeros(E,S);

%% end of script.
