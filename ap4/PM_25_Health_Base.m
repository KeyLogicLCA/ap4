
%% Concentration-response functions for mortality
% Adult = log-linear specification (relative risk reported)
% Infant = logistic specification (odds ratio reported)

%% Adult, all-cause mortality
% Log-linear function
Adult_Deaths = sum((MR_Data.*(One'*(1-(1./(exp(dr.*PM_25_Base')))))').*Pop_Exposed,2);
Adult_Spatial_Damage = wtp.*Adult_Deaths;
Adult_Mortality_Damage = sum(sum(wtp.*Adult_Deaths));

%% Infant, all-cause mortality
% Logistic function
Infant_Deaths = sum((MR_Data.*(One_Mat'.*(1-(1./((One_Mat-MR_Data)'.*exp(dr_infant.*PM_25_Base')+MR_Data'))))').*Pop_Under1,2);
Infant_Spatial_Damage = wtp.*Infant_Deaths;
Infant_Mortality_Damage = sum(sum(wtp.*Infant_Deaths));

%% Total mortality associated with ambient PM2.5
All_Deaths = Adult_Deaths + Infant_Deaths;
All_Spatial_Damage = Adult_Spatial_Damage + Infant_Spatial_Damage;
All_Mortality_Damage = (Adult_Mortality_Damage+Infant_Mortality_Damage);

%% end of script.