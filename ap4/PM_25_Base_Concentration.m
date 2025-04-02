%% Ambient PM2.5 baseline computation
% Model baseline pollution in every county against which marginal emissions
% are evaluated
run Load_Workspace

%% Calibration
run Calibration_Coefficients
run Calibration_Secondary_and_Tertiary

%% Ground level emissions and intermediate concentrations
NH3(:,1)    = NH3_Cal_base.*(Emissions_2017_NEI{1,1}(:,1)'*SR_Matrices_Ground{1,1});
HNO3(:,1)   = NOx_Cal_base.*(Emissions_2017_NEI{1,1}(:,2)'*SR_Matrices_Ground{2,1});
PMP(:,1)    = PMP_Cal_base.*(Emissions_2017_NEI{1,1}(:,3)'*SR_Matrices_Ground{3,1});
SO4(:,1)    = SO2_Cal_base.*(Emissions_2017_NEI{1,1}(:,4)'*SR_Matrices_Ground{4,1});
VOC(:,1)    = VOC_Cal_base.*(Emissions_2017_NEI{1,1}(:,5)'*SR_Matrices_Ground{5,1});
VOC_B(:,1)  = VOC_B_Cal_base.*(Emissions_2017_NEI{1,1}(:,6)'*SR_Matrices_Ground{5,1});

%% Non-EGU point source emissions and intermediate concentrations
NH3(:,2)    = NH3_Cal_base.*(Emissions_2017_NEI{2,1}(:,1)'*SR_Matrices_Point_Non_EGU{1,1});
HNO3(:,2)   = NOx_Cal_base.*(Emissions_2017_NEI{2,1}(:,2)'*SR_Matrices_Point_Non_EGU{2,1});
PMP(:,2)    = PMP_Cal_base.*(Emissions_2017_NEI{2,1}(:,3)'*SR_Matrices_Point_Non_EGU{3,1});
SO4(:,2)    = SO2_Cal_base.*(Emissions_2017_NEI{2,1}(:,4)'*SR_Matrices_Point_Non_EGU{4,1});
VOC(:,2)    = VOC_Cal_base.*(Emissions_2017_NEI{2,1}(:,5)'*SR_Matrices_Point_Non_EGU{5,1});

%% EGU emissions and intermediate concentrations
NH3(:,3)    = NH3_Cal_base.*(Emissions_2017_NEI{3,1}(:,1)'*SR_Matrices_Point_EGU{1,1});
HNO3(:,3)   = NOx_Cal_base.*(Emissions_2017_NEI{3,1}(:,2)'*SR_Matrices_Point_EGU{2,1});
PMP(:,3)    = PMP_Cal_base.*(Emissions_2017_NEI{3,1}(:,3)'*SR_Matrices_Point_EGU{3,1});
SO4(:,3)    = SO2_Cal_base.*(Emissions_2017_NEI{3,1}(:,4)'*SR_Matrices_Point_EGU{4,1});
VOC(:,3)    = VOC_Cal_base.*(Emissions_2017_NEI{3,1}(:,5)'*SR_Matrices_Point_EGU{5,1});
  
%% Partition total nitrate and ammonium 
run Nitrate_Sulfate_Ammonium_Update

%% Store baseline concentrations
PM_25_Base  = PM_25; % ug/m^3
HNO3_Base   = HNO3_Total; % moles
NH4e_Base   = NH4e; % moles

%% end of script.