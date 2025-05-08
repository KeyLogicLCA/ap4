%% Ground level emissions
b = 1;

%% Marginal impacts from ground level NH3 emissions
p = 1;
Delta_PM_25 = Trct_MC{b,p}';
run PM_25_Health

Results_MC{b,p} = Delta_PM_25;
Results_MM{b,p} = Total_Spatial_Deaths;
Results_MD{b,p} = Total_Spatial_Damage;

%% Marginal impacts from ground level NOx emissions
p = 2;
Delta_PM_25 = Trct_MC{b,p}';
run PM_25_Health

Results_MC{b,p} = Delta_PM_25;
Results_MM{b,p} = Total_Spatial_Deaths;
Results_MD{b,p} = Total_Spatial_Damage;

%% Marginal impacts from ground level pri-PM2.5 emissions
p = 3;
for n = 1:T
    fprintf('b %d,p %d,n %d\n', b, p, n);
    Emission_Plus = zeros(T,1);
    Emission_Plus(n,1) = Emission_Plus(n,1) + 1;
    Delta_PM_25 = (Emission_Plus'*Trct_MC{b,p})';
    run PM_25_Health
    
    MC_Tract_Matrix(:,n) = Delta_PM_25;
    MM_Tract_Matrix(:,n) = Total_Spatial_Deaths;
    MD_Tract_Matrix(:,n) = Total_Spatial_Damage; 
end
Results_MC{b,p} = MC_Tract_Matrix;
Results_MM{b,p} = MM_Tract_Matrix;
Results_MD{b,p} = MD_Tract_Matrix;

%% Marginal impacts from ground level SO2 emissions
p = 4;
Delta_PM_25 = Trct_MC{b,p}';
run PM_25_Health

Results_MC{b,p} = Delta_PM_25;
Results_MM{b,p} = Total_Spatial_Deaths;
Results_MD{b,p} = Total_Spatial_Damage;

%% Marginal impacts from ground level VOC emissions
p = 5;
for n = 1:T
    fprintf('b %d,p %d,n %d\n', b, p, n);
    Emission_Plus = zeros(T,1);
    Emission_Plus(n,1) = Emission_Plus(n,1) + 1;
    Delta_PM_25 = (Emission_Plus'*Trct_MC{b,p})';
    run PM_25_Health
    
    MC_Tract_Matrix(:,n) = Delta_PM_25;
    MM_Tract_Matrix(:,n) = Total_Spatial_Deaths;
    MD_Tract_Matrix(:,n) = Total_Spatial_Damage;  
end
Results_MC{b,p} = MC_Tract_Matrix;
Results_MM{b,p} = MM_Tract_Matrix;
Results_MD{b,p} = MD_Tract_Matrix;

%% end of script.