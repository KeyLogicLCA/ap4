%% Concentration-response functions for mortality
% Adult = log-linear specification (relative risk reported)
% Infant = logistic specification (odds ratio reported)

%% Total health impacts
% Adult, all-cause mortality
% Log-linear function
Spatial_Mortality_Adult = sum((MR_Matrix.*(One_Mat'.*(1-(1./(exp(DR_Matrix'.*PM25_Base')))))').*Pop_Adult,2);
Spatial_Damage_Adult = wtp.*Spatial_Mortality_Adult;
Damage_Adult = sum(sum(wtp.*Spatial_Mortality_Adult));

% Infant, all-cause mortality
% Logistic function
Spatial_Mortality_Infant = sum((MR_Matrix.*(One_Mat'.*(1-(1./((One_Mat-MR_Matrix)'.*exp(DR_Matrix'.*PM25_Base')+MR_Matrix'))))').*Pop_Infant,2);
Spatial_Damage_Infant = wtp.*Spatial_Mortality_Infant;
Damage_Infant = sum(sum(wtp.*Spatial_Mortality_Infant));

% Total mortality associated with ambient PM2.5
Base_Spatial_Mortality = Spatial_Mortality_Adult + Spatial_Mortality_Infant;
Base_Spatial_Damage = Spatial_Damage_Adult + Spatial_Damage_Infant;
Base_Damage = (Damage_Adult + Damage_Infant);

clear Damage_Adult Damage_Infant Spatial_Damage_Adult ...
    Spatial_Damage_Infant Spatial_Mortality_Adult Spatial_Mortality_Infant

%% Differentiated by age health impacts
% Handles matrices uniquely to keep age-groups differentiated
if age == 1
    % Adult, all-cause mortality
    % Log-linear function
    Spatial_Mortality_Adult = (MR_Matrix.*(One_Mat'.*(1-(1./(exp(DR_Matrix'.*PM25_Base')))))').*Pop_Adult;
    Spatial_Damage_Adult = wtp.*Spatial_Mortality_Adult;
    Damage_Adult = sum(wtp.*Spatial_Mortality_Adult);

    % Infant, all-cause mortality
    % Logistic function
    Spatial_Mortality_Infant = (MR_Matrix.*(One_Mat'.*(1-(1./((One_Mat-MR_Matrix)'.*exp(DR_Matrix'.*PM25_Base')+MR_Matrix'))))').*Pop_Infant;
    Spatial_Damage_Infant = wtp.*Spatial_Mortality_Infant;
    Damage_Infant = sum(wtp.*Spatial_Mortality_Infant);

    % Total mortality associated with ambient PM2.5
    Base_Spatial_Mortality = Spatial_Mortality_Adult + Spatial_Mortality_Infant;
    Base_Spatial_Damage = Spatial_Damage_Adult + Spatial_Damage_Infant;
    Base_Damage = (Damage_Adult + Damage_Infant);
end

clear Damage_Adult Damage_Infant Spatial_Damage_Adult ...
    Spatial_Damage_Infant Spatial_Mortality_Adult Spatial_Mortality_Infant

%% end of script.