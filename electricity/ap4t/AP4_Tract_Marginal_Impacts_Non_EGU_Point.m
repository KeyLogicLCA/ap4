%% Non-EGU point source emissions
b = 2;

%% Marginal impacts from non-EGU point source NH3 emissions
p = 1;
Delta_PM_25 = Trct_MC{b,p}';
run PM_25_Health

Results_MC{b,p} = Delta_PM_25;
Results_MM{b,p} = Total_Spatial_Deaths;
Results_MD{b,p} = Total_Spatial_Damage;

%% Marginal impacts from non-EGU point source NOx emissions
p = 2;
Delta_PM_25 = Trct_MC{b,p}';
run PM_25_Health

Results_MC{b,p} = Delta_PM_25;
Results_MM{b,p} = Total_Spatial_Deaths;
Results_MD{b,p} = Total_Spatial_Damage;

%% Marginal impacts from non-EGU point source pri-PM2.5 emissions
p = 3;
Delta_PM_25 = Trct_MC{b,p}';
run PM_25_Health

Results_MC{b,p} = Delta_PM_25;
Results_MM{b,p} = Total_Spatial_Deaths;
Results_MD{b,p} = Total_Spatial_Damage;

%% Marginal impacts from non-EGU point source SO2 emissions
p = 4;
Delta_PM_25 = Trct_MC{b,p}';
run PM_25_Health

Results_MC{b,p} = Delta_PM_25;
Results_MM{b,p} = Total_Spatial_Deaths;
Results_MD{b,p} = Total_Spatial_Damage;

%% Marginal impacts from non-EGU point source VOC emissions
p = 5;
Delta_PM_25 = Trct_MC{b,p}';
run PM_25_Health

Results_MC{b,p} = Delta_PM_25;
Results_MM{b,p} = Total_Spatial_Deaths;
Results_MD{b,p} = Total_Spatial_Damage;

%% end of script.