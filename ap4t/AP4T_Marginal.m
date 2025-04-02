%% Marginal (metric) ton impacts assessment
% Add one ton of emissions for each pollutant and bin to compute marginal
% impacts: concentrations, premature mortality, and damage. Reset baseline
% after each iteration
% County/EGU-sourced impacts for all pollutants
% Runtime < 30 minutes

% Optionally drop Tract_to_Tract for storage space, not dropped by default
% (note: AP4T_Marginal_Tract.m will be disabled if Tract_to_Tract is
% dropped)
% clear Tract_to_Tract

% Ensure age = 0 & impact dimensionality is as needed (in case
% AP4T_Subpopulation_Assessment.m was run)
age = 0; 
run Dose_Response_and_Valuation_Modules

%% Initialize source dimensions
B = 3; % B = bins
P = 5; % P = pollutants
C = height(AP4T_County_List);   % C = counties
E = height(AP4T_EGU_List);      % E = egu point sources

%% Initialize marginal spatial impact matrices for storage and export
Spatial_MC = cell(3,5); % Marginal concentrations
Spatial_MM = cell(3,5); % Marginal mortality
Spatial_MD = cell(3,5); % Marginal damage

%% Marginal spatial impacts from NH3 emissions
p = 1; % NH3
for b = 1:B    
    if b == 3
        S = E; % EGU sources
    else
        S = C; % County sources
    end
    MC_Tract_Matrix = zeros(S,R);
	MM_Tract_Matrix = zeros(S,R);
	MD_Tract_Matrix = zeros(S,R);
    for n = 1:S
        fprintf('b %d,p %d,n %d\n', b,p,n);
        run Reset_Baseline
        Emission_Plus = (AP4_Emissions{b,1}(:,p));
        Emission_Plus(n,1) = (Emission_Plus(n,1) + 1);
        NH3(:,b) = Cal_NH3.*(Emission_Plus'*AP4T_SR_Matrices{b,p});
        run Atmospheric_Chemistry_Marginal_NH3_Tract        % Employ special treatment of NH3 on the margin chemistry
        % run Atmospheric_Chemistry_Tract                   % Forego special treatment of NH3 on the margin chemistry
        run AP4T_Calibration/Calibration_Secondary_and_Tertiary
        PM25_Exp	= PM25; % ug/m^3
        Delta_PM25	= PM25_Exp - PM25_Base; % ug/m^3
        MC_Tract_Matrix(n,:) = Delta_PM25';
        run Experimental_PM25_Health
        MM_Tract_Matrix(n,:) = (Exp_Spatial_Mortality - Base_Spatial_Mortality)';
        MD_Tract_Matrix(n,:) = (Exp_Spatial_Damage - Base_Spatial_Damage)';
    end
    Spatial_MC{b,p} = MC_Tract_Matrix;
	Spatial_MM{b,p} = MM_Tract_Matrix;
	Spatial_MD{b,p} = MD_Tract_Matrix;
end

%% Marginal spatial impacts from NOx emissions
p = 2; % NOx
for b = 1:B
    if b == 3
        S = E; % EGU sources
    else
        S = C; % County sources
    end
    MC_Tract_Matrix = zeros(S,R);
	MM_Tract_Matrix = zeros(S,R);
	MD_Tract_Matrix = zeros(S,R);
    for n = 1:S
        fprintf('b %d,p %d,n %d\n', b,p,n);
        run Reset_Baseline
        Emission_Plus = (AP4_Emissions{b,1}(:,p));
        Emission_Plus(n,1) = (Emission_Plus(n,1) + 1);
        NOx(:,b) = Cal_NOx.*(Emission_Plus'*AP4T_SR_Matrices{b,p});
        run Atmospheric_Chemistry_Marginal_NOx_Tract        % Employ special treatment of NOx on the margin chemistry
        % run Atmospheric_Chemistry_Tract                   % Forego special treatment of NOx on the margin chemistry
        run AP4T_Calibration/Calibration_Secondary_and_Tertiary
        PM25_Exp	= PM25; % ug/m^3
        Delta_PM25	= PM25_Exp - PM25_Base; % ug/m^3
        MC_Tract_Matrix(n,:) = Delta_PM25';
        run Experimental_PM25_Health
        MM_Tract_Matrix(n,:) = (Exp_Spatial_Mortality - Base_Spatial_Mortality)';
        MD_Tract_Matrix(n,:) = (Exp_Spatial_Damage - Base_Spatial_Damage)';
    end
    Spatial_MC{b,p} = MC_Tract_Matrix;
	Spatial_MM{b,p} = MM_Tract_Matrix;
	Spatial_MD{b,p} = MD_Tract_Matrix;
end

%% Marginal spatial impacts from Primary PM2.5 emissions
p = 3; % Primary PM2.5
for b = 1:B
    if b == 3
        S = E; % EGU sources
    else
        S = C; % County sources
    end
    MC_Tract_Matrix = zeros(S,R);
	MM_Tract_Matrix = zeros(S,R);
	MD_Tract_Matrix = zeros(S,R);
    for n = 1:S
        fprintf('b %d,p %d,n %d\n', b,p,n);
        run Reset_Baseline
        if b == 1
            Emission_Plus = (AP4_Emissions{4,1}(:,p));
        else
            Emission_Plus = (AP4_Emissions{b,1}(:,p));
        end
        Emission_Plus(n,1) = (Emission_Plus(n,1) + 1);
        PMP(:,b) = Cal_PMP*(Emission_Plus'*AP4T_SR_Matrices{b,p})';
        run Atmospheric_Chemistry_Tract
        run AP4T_Calibration/Calibration_Secondary_and_Tertiary
        PM25_Exp	= PM25; % ug/m^3
        Delta_PM25	= PM25_Exp - PM25_Base; % ug/m^3
        MC_Tract_Matrix(n,:) = Delta_PM25';
        run Experimental_PM25_Health
        MM_Tract_Matrix(n,:) = (Exp_Spatial_Mortality - Base_Spatial_Mortality)';
        MD_Tract_Matrix(n,:) = (Exp_Spatial_Damage - Base_Spatial_Damage)';
    end
    Spatial_MC{b,p} = MC_Tract_Matrix;
	Spatial_MM{b,p} = MM_Tract_Matrix;
	Spatial_MD{b,p} = MD_Tract_Matrix;
end

%% Marginal spatial impacts from SO2 emissions
p = 4; % SO2
for b = 1:B
    if b == 3
        S = E; % EGU sources
    else
        S = C; % County sources
    end
    MC_Tract_Matrix = zeros(S,R);
	MM_Tract_Matrix = zeros(S,R);
	MD_Tract_Matrix = zeros(S,R);
    for n = 1:S
        fprintf('b %d,p %d,n %d\n', b,p,n);
        run Reset_Baseline
        Emission_Plus = (AP4_Emissions{b,1}(:,p));
        Emission_Plus(n,1) = (Emission_Plus(n,1) + 1);
        SO2(:,b) = Cal_SO2.*(Emission_Plus'*AP4T_SR_Matrices{b,p});
        run Atmospheric_Chemistry_Tract
        run AP4T_Calibration/Calibration_Secondary_and_Tertiary
        PM25_Exp	= PM25; % ug/m^3
        Delta_PM25	= PM25_Exp - PM25_Base; % ug/m^3
        MC_Tract_Matrix(n,:) = Delta_PM25';
        run Experimental_PM25_Health
        MM_Tract_Matrix(n,:) = (Exp_Spatial_Mortality - Base_Spatial_Mortality)';
        MD_Tract_Matrix(n,:) = (Exp_Spatial_Damage - Base_Spatial_Damage)';
    end
    Spatial_MC{b,p} = MC_Tract_Matrix;
	Spatial_MM{b,p} = MM_Tract_Matrix;
	Spatial_MD{b,p} = MD_Tract_Matrix;
end

%% Marginal spatial impacts from VOC emissions
p = 5; % VOCs
for b = 1:B
    if b == 3
        S = E; % EGU sources
    else
        S = C; % County sources
    end
    MC_Tract_Matrix = zeros(S,R);
	MM_Tract_Matrix = zeros(S,R);
	MD_Tract_Matrix = zeros(S,R);
    for n = 1:S
        fprintf('b %d,p %d,n %d\n', b,p,n);
        run Reset_Baseline
        if b == 1
            Emission_Plus = (AP4_Emissions{4,1}(:,p));
        else
            Emission_Plus = (AP4_Emissions{b,1}(:,p));
        end
        Emission_Plus(n,1) = (Emission_Plus(n,1) + 1);
        VOC(:,b) = Cal_VOC.*(Emission_Plus'*AP4T_SR_Matrices{b,p});
        run Atmospheric_Chemistry_Tract
        run AP4T_Calibration/Calibration_Secondary_and_Tertiary
        PM25_Exp	= PM25; % ug/m^3
        Delta_PM25	= PM25_Exp - PM25_Base; % ug/m^3
        MC_Tract_Matrix(n,:) = Delta_PM25';
        run Experimental_PM25_Health
        MM_Tract_Matrix(n,:) = (Exp_Spatial_Mortality - Base_Spatial_Mortality)';
        MD_Tract_Matrix(n,:) = (Exp_Spatial_Damage - Base_Spatial_Damage)';
    end
    Spatial_MC{b,p} = MC_Tract_Matrix;
	Spatial_MM{b,p} = MM_Tract_Matrix;
	Spatial_MD{b,p} = MD_Tract_Matrix;
end

%% Marginal impacts by source
MD_Ground           = zeros(C,5);
MD_Non_EGU_Point    = zeros(C,5);
MD_EGU_Point        = zeros(E,5);

% Sum impacts across receptor tracts
for p = 1:P
    MD_Ground(:,p)          = sum(Spatial_MD{1,p},2);
	MD_Non_EGU_Point(:,p)   = sum(Spatial_MD{2,p},2);
    MD_EGU_Point(:,p)       = sum(Spatial_MD{3,p},2);
end

%% end of script.