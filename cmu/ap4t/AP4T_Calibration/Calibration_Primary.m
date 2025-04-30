%% Primary Calibration for AP4T - Global Coefficients
% Use monitoring data for PM2.5 and subspecies for primary calibration.
% Start with organic aerosols, then move to inorganic species, then finish
% with total particulates

%% Calibration coefficients for VOC emissions
% Optimize organic aerosol concentrations
run Optimize_Organics
Cal_VOC     = x(1);
Cal_VOC_B	= x(2);

%% Calibration coefficients for NH3, NOx, and SO2 emissions
% Optimize inorganic specieis concentrations
run Optimize_Inorganics
Cal_NH3     = x(1);
Cal_NOx     = x(2);
Cal_SO2     = x(3);

%% Calibration coefficients for primary PM2.5 emissions
% Optimize total concentrations by varying directly emitted PM2.5
run Optimize_Total
Cal_PMP     = x(1);

%% Clean up
clear A b constraints E HNO3 HNO3_Base lb MFE_oa MFE_tp NH3 NH4 ...
    NH4_2_SO4 NH4_NO3 NH4e NO3 NOx OA objective options PM25 PMP ...
    PRI SO2 SO4 SR t T VOC BOC_B x x0
 
%% end of script.