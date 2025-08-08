%% This script extracts results from the AP4 model
% Emissions and source-receptor matrices are in metric tons
% Convert to short tons
mt_to_st = 1/1.10231131;

% Marginal concentrations - ground sources
s = 1;
MC_Ground_NH3 = Results_MC{s,1}*mt_to_st;
MC_Ground_NOx = Results_MC{s,2}*mt_to_st;
MC_Ground_PMP = Results_MC{s,3}*mt_to_st;
MC_Ground_SO2 = Results_MC{s,4}*mt_to_st;
MC_Ground_VOC = Results_MC{s,5}*mt_to_st;

% Marginal concentrations - non-egu point sources
s = 2;
MC_Non_EGU_Point_NH3 = Results_MC{s,1}*mt_to_st;
MC_Non_EGU_Point_NOx = Results_MC{s,2}*mt_to_st;
MC_Non_EGU_Point_PMP = Results_MC{s,3}*mt_to_st;
MC_Non_EGU_Point_SO2 = Results_MC{s,4}*mt_to_st;
MC_Non_EGU_Point_VOC = Results_MC{s,5}*mt_to_st;

% Marginal concentrations - egu point sources
s = 3;
MC_EGU_Point_NH3 = Results_MC{s,1}*mt_to_st;
MC_EGU_Point_NOx = Results_MC{s,2}*mt_to_st;
MC_EGU_Point_PMP = Results_MC{s,3}*mt_to_st;
MC_EGU_Point_SO2 = Results_MC{s,4};
MC_EGU_Point_VOC = Results_MC{s,5}*mt_to_st;

%% Extract to .csv in AP4_Outputs folder

% NH3-driven PM
dlmwrite('AP4_Outputs/MC_Ground_NH3.csv', MC_Ground_NH3, 'precision', 12) %%%
dlmwrite('AP4_Outputs/MC_Non_EGU_Point_NH3.csv', MC_Non_EGU_Point_NH3, 'precision', 12) %%%
dlmwrite('AP4_Outputs/MC_EGU_Point_NH3.csv', MC_EGU_Point_NH3, 'precision', 12) %%%

% NOx-driven PM
dlmwrite('AP4_Outputs/MC_Ground_NOx.csv', MC_Ground_NOx, 'precision', 12) %%%
dlmwrite('AP4_Outputs/MC_Non_EGU_Point_NOx.csv', MC_Non_EGU_Point_NOx, 'precision', 12) %%%
dlmwrite('AP4_Outputs/MC_EGU_Point_NOx.csv', MC_EGU_Point_NOx, 'precision', 12) %%%

% Primary PM2.5-driven PM
dlmwrite('AP4_Outputs/MC_Ground_PMP.csv', MC_Ground_PMP, 'precision', 12) %%%
dlmwrite('AP4_Outputs/MC_Non_EGU_Point_PMP.csv', MC_Non_EGU_Point_PMP, 'precision', 12) %%%
dlmwrite('AP4_Outputs/MC_EGU_Point_PMP.csv', MC_EGU_Point_PMP, 'precision', 12) %%%

% SO2-driven PM
dlmwrite('AP4_Outputs/MC_Ground_SO2.csv', MC_Ground_SO2, 'precision', 12) %%%
dlmwrite('AP4_Outputs/MC_Non_EGU_Point_SO2.csv', MC_Non_EGU_Point_SO2, 'precision', 12) %%%
dlmwrite('AP4_Outputs/MC_EGU_Point_SO2.csv', MC_EGU_Point_SO2, 'precision', 12) %%%

% VOC-driven PM
dlmwrite('AP4_Outputs/MC_Ground_VOC.csv', MC_Ground_VOC, 'precision', 12) %%%
dlmwrite('AP4_Outputs/MC_Non_EGU_Point_VOC.csv', MC_Non_EGU_Point_VOC, 'precision', 12) %%%
dlmwrite('AP4_Outputs/MC_EGU_Point_VOC.csv', MC_EGU_Point_VOC, 'precision', 12) %%%

%% end of script.