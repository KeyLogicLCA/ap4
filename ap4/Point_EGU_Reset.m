
%% EGU point source emissions and intermediate concentrations reset
% This script resets concentrations from EGU point sources back to baseline
NH3(:,3)    = NH3_Cal_base.*(Emissions_2017_NEI{3,1}(:,1)'*SR_Matrices_Point_EGU{1,1});
HNO3(:,3)   = NOx_Cal_base.*(Emissions_2017_NEI{3,1}(:,2)'*SR_Matrices_Point_EGU{2,1});
PMP(:,3)    = PMP_Cal_base.*(Emissions_2017_NEI{3,1}(:,3)'*SR_Matrices_Point_EGU{3,1});
SO4(:,3)    = SO2_Cal_base.*(Emissions_2017_NEI{3,1}(:,4)'*SR_Matrices_Point_EGU{4,1});
VOC(:,3)    = VOC_Cal_base.*(Emissions_2017_NEI{3,1}(:,5)'*SR_Matrices_Point_EGU{5,1});

%% end of script.