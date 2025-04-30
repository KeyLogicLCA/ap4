%% Marginal (metric) ton impacts assessment
% Add one ton of emissions for each pollutant and bin to compute marginal
% impacts: concentrations, premature mortality, and damage. Reset baseline
% after each iteration
% Tract-sourced impacts for primary PM2.5 and VOCs
% Runtime < 30 minutes

b = 4; % fires

% Ensure age = 0 & impact dimensionality is as needed (in case
% AP4T_Subpopulation_Assessment.m was run)
age = 0; 
run Dose_Response_and_Valuation_Modules

%% Initialize source dimensions
C = height(AP4T_County_List);   % C = counties
T = height(AP4T_Tract_List);    % T = tracts

%% Initialize marginal damage matrices for storage and export
MD_Fire = zeros(T,2); % Marginal damage

%% Marginal damages from tract primary PM2.5 emissions
% Tract-sourced primary PM2.5 (appropriate for fire sources)
p = 3;  % primary PM2.5
for n = 1:C
	tracts = AP4T_Tract_List.id(AP4T_Tract_List.ap4 == n,:); % county's tracts
	ttt = Tract_to_Tract{n,1};  % county's tract-to-tract trasport
    for m = 1:length(tracts)
        run Reset_Baseline
        x = tracts(m); % tract id
        fprintf('b %d,p %d,x %d\n', b,p,x);
        Delta_PM = Cal_PMP.*ttt(m,:)'; % calibrated primary PM2.5 transport (add one ton)
        PMP(:,4) = PMP(:,4) + Delta_PM; % new fire-emitted primary PM2.5
        run Atmospheric_Chemistry_Tract
        run AP4T_Calibration/Calibration_Secondary_and_Tertiary
        PM25_Exp = PM25; % ug/m^3
        run Experimental_PM25_Health
        MD_Fire(x,1) = Exp_Damage - Base_Damage; % new damage less old damage
    end
end

%% Marginal damages from tract VOC emissions
% Tract-sourced VOCs (appropriate for fire sources)
p = 5; % VOCs
for n = 1:C
	tracts = AP4T_Tract_List.id(AP4T_Tract_List.ap4 == n,:);
	ttt = Tract_to_Tract{n,1}; % Tract-to-tract
    for m = 1:length(tracts)
        run Reset_Baseline
        x = tracts(m);
        fprintf('b %d,p %d,x %d\n', b,p,x);
        Delta_PM = Cal_VOC.*ttt(m,:)'; % calibrated VOC transport (add one ton)
        VOC(:,4) = VOC(:,4) + Delta_PM; % new fire-emitted VOC
        run Atmospheric_Chemistry_Tract
        run AP4T_Calibration/Calibration_Secondary_and_Tertiary
        PM25_Exp = PM25; % ug/m^3
        run Experimental_PM25_Health
        MD_Fire(x,2) = Exp_Damage - Base_Damage;
    end
end

%% end of script.