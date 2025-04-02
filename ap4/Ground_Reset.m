%% Ground level emissions and intermediate concentrations reset
% This script resets concentrations from ground level sources back to baseline
NH3(:,1)    = NH3_Cal_base.*(Emissions_2017_NEI{1,1}(:,1)'*SR_Matrices_Ground{1,1});
HNO3(:,1)   = NOx_Cal_base.*(Emissions_2017_NEI{1,1}(:,2)'*SR_Matrices_Ground{2,1});
PMP(:,1)    = PMP_Cal_base.*(Emissions_2017_NEI{1,1}(:,3)'*SR_Matrices_Ground{3,1});
SO4(:,1)    = SO2_Cal_base.*(Emissions_2017_NEI{1,1}(:,4)'*SR_Matrices_Ground{4,1});
VOC(:,1)    = VOC_Cal_base.*(Emissions_2017_NEI{1,1}(:,5)'*SR_Matrices_Ground{5,1});
VOC_B(:,1)  = VOC_B_Cal_base.*(Emissions_2017_NEI{1,1}(:,6)'*SR_Matrices_Ground{5,1});

%% end of script.