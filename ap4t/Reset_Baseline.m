%% Reset Baseline
% Reset baseline pollution in every cennsus tract against which marginal
% emissions are evaluated

%% Ground-level emissions and speciated concentrations
NH3(:,1)    = Cal_NH3*Transport_Base{1,1};
NOx(:,1)    = Cal_NOx*Transport_Base{1,2};
PMP(:,1)    = Cal_PMP*Transport_Base{1,3};
SO2(:,1)    = Cal_SO2*Transport_Base{1,4};
VOC(:,1)	= Cal_VOC*Transport_Base{1,5};
VOC_B(:,1)  = Cal_VOC_B*Transport_Base{1,6};

%% Non-EGU point source emissions and speciated concentrations
NH3(:,2) = Cal_NH3*Transport_Base{2,1};
NOx(:,2) = Cal_NOx*Transport_Base{2,2};
PMP(:,2) = Cal_PMP*Transport_Base{2,3};
SO2(:,2) = Cal_SO2*Transport_Base{2,4};
VOC(:,2) = Cal_VOC*Transport_Base{2,5};

%% EGU emissions and speciated concentrations
NH3(:,3) = Cal_NH3*Transport_Base{3,1};
NOx(:,3) = Cal_NOx*Transport_Base{3,2};
PMP(:,3) = Cal_PMP*Transport_Base{3,3};
SO2(:,3) = Cal_SO2*Transport_Base{3,4};
VOC(:,3) = Cal_VOC*Transport_Base{3,5};

%% Fire emissions and speciated concentrations
PMP(:,4) = Cal_PMP*Transport_Base{4,3};
VOC(:,4) = Cal_VOC*Transport_Base{4,5};

%% end of script.