%% Non-EGU point source emissions and intermediate concentrations reset
% This script resets concentrations from non-EGU point sources back to baseline
NH3(:,2)    = NH3_Cal_base.*(Emissions_2017_NEI{2,1}(:,1)'*SR_Matrices_Point_Non_EGU{1,1});
HNO3(:,2)   = NOx_Cal_base.*(Emissions_2017_NEI{2,1}(:,2)'*SR_Matrices_Point_Non_EGU{2,1});
PMP(:,2)    = PMP_Cal_base.*(Emissions_2017_NEI{2,1}(:,3)'*SR_Matrices_Point_Non_EGU{3,1});
SO4(:,2)    = SO2_Cal_base.*(Emissions_2017_NEI{2,1}(:,4)'*SR_Matrices_Point_Non_EGU{4,1});
VOC(:,2)    = VOC_Cal_base.*(Emissions_2017_NEI{2,1}(:,5)'*SR_Matrices_Point_Non_EGU{5,1});

%% end of script.