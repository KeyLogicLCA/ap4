%% Counterfactual emissions scenario impacts assessment
% Take emissions out from the baseline to evaluate the impacts of specific
% source(s)
run Experiment_Emissions_Inventories
e = length(AP4T_Experiments);
Spatial_EC = zeros(t,e);
Spatial_EM = zeros(t,e);
Spatial_ED = zeros(t,e);

%% Run air pollution experiments
% Cycle through experimental emissions inventories and track changes in
% PM2.5 concentrations

for i = [107:107] % Loop through 107 experiments (~3 hours) | currently set to evaluate just Tubbs wildfire emissions
    fprintf('Experiment %d of %d\n', i, e);
    run Transport_Experimental
    
    % Ground-level emissions and speciated concentrations
    b = 1; % Ground
    NH3(:,b)    = Cal_NH3*Transport_Exp{b,1};
    NOx(:,b)    = Cal_NOx*Transport_Exp{b,2};
    PMP(:,b)    = Cal_PMP*Transport_Exp{b,3};
    SO2(:,b)    = Cal_SO2*Transport_Exp{b,4};
    VOC(:,b)    = Cal_VOC*Transport_Exp{b,5};
    VOC_B(:,b)	= Cal_VOC_B*Transport_Exp{b,6};

    % Non-EGU point source emissions and speciated concentrations
    b = 2; % Non-EGU point
    NH3(:,b)    = Cal_NH3*Transport_Exp{b,1};
    NOx(:,b)    = Cal_NOx*Transport_Exp{b,2};
    PMP(:,b)    = Cal_PMP*Transport_Exp{b,3};
    SO2(:,b)    = Cal_SO2*Transport_Exp{b,4};
    VOC(:,b)    = Cal_VOC*Transport_Exp{b,5};

    % EGU emissions and speciated concentrations
    b = 3; % EGU point
    NH3(:,b)    = Cal_NH3*Transport_Exp{b,1};
    NOx(:,b)    = Cal_NOx*Transport_Exp{b,2};
    PMP(:,b)    = Cal_PMP*Transport_Exp{b,3};
    SO2(:,b)    = Cal_SO2*Transport_Exp{b,4};
    VOC(:,b)    = Cal_VOC*Transport_Exp{b,5};

    % Fire emissions and speciated concentrations
    b = 4; % EGU point
    PMP(:,b)    = Cal_PMP*Transport_Exp{b,3};
    VOC(:,b)    = Cal_VOC*Transport_Exp{b,5};
    
    % Partition total nitrate and ammonium 
    run Atmospheric_Chemistry_Tract
    run AP4T_Calibration/Calibration_Secondary_and_Tertiary

    % Store change in concentrations from baseline
    PM25_Exp        = PM25; % ug/m^3
    Delta_PM25      = PM25_Base - PM25_Exp; % ug/m^3
    Spatial_EC(:,i) = Delta_PM25; % ug/m^3

    % Run exposure and response assessment
        % Damages are less substantial on the margin (i.e., if we
        % alternatively run 'Marginal_PM25_Health.m' damages are more)
	run Experimental_PM25_Health
    
	% Store change in impacts from baseline
    Spatial_EM(:,i) = Base_Spatial_Mortality - Exp_Spatial_Mortality;
    Spatial_ED(:,i) = Base_Spatial_Damage - Exp_Spatial_Damage;

end

%% Effects per capita
% Population by tract
Pop_Tract = sum(Pop_Matrix,2);

% Normalize spatial matrices by population counts
Spatial_EMPC = Spatial_EM./Pop_Tract;
Spatial_EDPC = Spatial_ED./Pop_Tract;

%% end of script.