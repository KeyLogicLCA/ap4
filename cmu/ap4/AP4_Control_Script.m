%% This script runs the AP4 model
% Run time is < 10 min
% Results are marginal damages by source ($/metric ton)

run PM_25_Base_Concentration
run AP4_Setup
run AP4_Marginal_Damages_Ground
run AP4_Marginal_Damages_Non_EGU_Point
run AP4_Marginal_Damages_EGU_Point
run AP4_Marginal_Damages_Summary
run AP4_Post_Clean_Up

%% end of script.