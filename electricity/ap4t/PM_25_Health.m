
%% Concentration-response functions for mortality
% Adult = log-linear specification (relative risk reported)
% Infant = logistic specification (odds ratio reported)

%% Adult, all-cause mortality
% Log-linear function
Adult_Spatial_Deaths = sum((MR_Matrix.*(One'*(1-(1./(exp(dr.*Delta_PM_25')))))').*Pop_Exposed,2);
Adult_Spatial_Damage = wtp.*Adult_Spatial_Deaths;
Adult_Damage = sum(sum(wtp.*Adult_Spatial_Deaths));

%% Infant, all-cause mortality
% Logistic function
Infant_Spatial_Deaths = sum((MR_Matrix.*(One_Mat'.*(1-(1./((One_Mat-MR_Matrix)'.*exp(dr_infant.*Delta_PM_25')+MR_Matrix'))))').*Pop_Under1,2);
Infant_Spatial_Damage = wtp.*Infant_Spatial_Deaths;
Infant_Damage = sum(sum(wtp.*Infant_Spatial_Deaths));

%% Total mortality associated with ambient PM2.5
Total_Spatial_Deaths = Adult_Spatial_Deaths + Infant_Spatial_Deaths;
Total_Spatial_Damage = Adult_Spatial_Damage + Infant_Spatial_Damage;
Total_Damage = (Adult_Damage + Infant_Damage);

%% end of script.