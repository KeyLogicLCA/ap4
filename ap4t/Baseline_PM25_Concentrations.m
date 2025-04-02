%% Ambient PM2.5 baseline computation
% Model baseline pollution in every cennsus tract against which marginal
% emissions are evaluated

%% Emissions dictionary
% NH3 = Ammonia
% NOx = Nitrogren Oxides
% PMP = Primary PM2.5
% SO2 = Sulfur Dioxide
% VOC = Volatile Organic Compounds
% VOC_B = Biogenic VOCs

%% Calibration
run Transport_Modeling
% run AP4T_Calibration/Calibration_Primary  % Skip by default (result is information in Calibration_Coefficients.m)
run AP4T_Calibration/Calibration_Coefficients

%% Ground-level emissions and speciated concentrations
b = 1; % Ground
NH3(:,b)    = Cal_NH3*Transport_Base{b,1};
NOx(:,b)    = Cal_NOx*Transport_Base{b,2};
PMP(:,b)    = Cal_PMP*Transport_Base{b,3};
SO2(:,b)    = Cal_SO2*Transport_Base{b,4};
VOC(:,b)    = Cal_VOC*Transport_Base{b,5};
VOC_B(:,b)	= Cal_VOC_B*Transport_Base{b,6};

%% Non-EGU point source emissions and speciated concentrations
b = 2; % Non-EGU point
NH3(:,b)    = Cal_NH3*Transport_Base{b,1};
NOx(:,b)    = Cal_NOx*Transport_Base{b,2};
PMP(:,b)    = Cal_PMP*Transport_Base{b,3};
SO2(:,b)    = Cal_SO2*Transport_Base{b,4};
VOC(:,b)    = Cal_VOC*Transport_Base{b,5};

%% EGU emissions and speciated concentrations
b = 3; % EGU point
NH3(:,b)    = Cal_NH3*Transport_Base{b,1};
NOx(:,b)    = Cal_NOx*Transport_Base{b,2};
PMP(:,b)    = Cal_PMP*Transport_Base{b,3};
SO2(:,b)    = Cal_SO2*Transport_Base{b,4};
VOC(:,b)    = Cal_VOC*Transport_Base{b,5};

%% Fire emissions and speciated concentrations
b = 4; % Fires
PMP(:,b)    = Cal_PMP*Transport_Base{b,3};
VOC(:,b)    = Cal_VOC*Transport_Base{b,5};
% PMP(:,b)    = 0; % no fires (for testing)
% VOC(:,b)    = 0;

%% Partition total nitrate and ammonium 
run Atmospheric_Chemistry_Tract
run AP4T_Calibration/Calibration_Secondary_and_Tertiary
run Validation_Modeled_vs_Monitored

% %% Store baseline concentrations
PM25_Base = PM25; % ug/m^3
HNO3_Base = HNO3; % moles
NH4e_Base = NH4e; % moles

%% end of script.