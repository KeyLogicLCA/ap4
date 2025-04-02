%% Ground level emissions
s = 1;

%% Marginal damages from ground level NH3 emissions
run Ground_Reset
p = 1;
for n = 1:S
    fprintf('s %d,p %d,n %d\n', s,p,n);
    Emission_Plus = (Emissions_2017_NEI{s,1}(:,p));
    Emission_Plus(n,1) = (Emissions_2017_NEI{s,1}(n,p)+1);
    NH3(:,1) = NH3_Cal_base.*((Emission_Plus)'*SR_Matrices_Ground{p,1})';
    
    run Nitrate_Sulfate_Ammonium_Marginal_NH3_Emission_Update
    Delta_PM_25(:,1) = (PM_25-PM_25_Base);
    run PM_25_Health
    
    MD_Ground(n,p) = All_Mortality_Damage;
end

%% Marginal damages from ground level NOx emissions
run Ground_Reset
p = 2;
for n = 1:S 
    fprintf('s %d,p %d,n %d\n', s,p,n);
    Emission_Plus = (Emissions_2017_NEI{s,1}(:,p));
    Emission_Plus(n,1) = (Emissions_2017_NEI{s,1}(n,p)+1);
    HNO3(:,1) = NOx_Cal_base.*((Emission_Plus)'*SR_Matrices_Ground{p,1})';
    
    run Nitrate_Sulfate_Ammonium_Marginal_NOx_Emission_Update
    Delta_PM_25(:,1) = (PM_25-PM_25_Base);
    run PM_25_Health
    
    MD_Ground(n,p) = All_Mortality_Damage;
end

%% Marginal damages from ground level primary PM25 emissions
run Ground_Reset
p = 3;
for n = 1:S
    fprintf('s %d,p %d,n %d\n', s,p,n);
    Emission_Plus = (Emissions_2017_NEI{s,1}(:,p));
    Emission_Plus(n,1) = (Emissions_2017_NEI{s,1}(n,p)+1);
    PMP(:,1) = PMP_Cal_base'.*((Emission_Plus)'*SR_Matrices_Ground{p,1})';
    
    run Nitrate_Sulfate_Ammonium_Update
    Delta_PM_25(:,1) = (PM_25-PM_25_Base);
    run PM_25_Health
    
    MD_Ground(n,p) = All_Mortality_Damage;   
end

%% Marginal damages from ground level SO2 emissions
run Ground_Reset
p = 4;
for n = 1:S
    fprintf('s %d,p %d,n %d\n', s,p,n);
    Emission_Plus = (Emissions_2017_NEI{s,1}(:,p));
    Emission_Plus(n,1) = (Emissions_2017_NEI{s,1}(n,p)+1);
    SO4(:,1) = SO2_Cal_base.*((Emission_Plus)'*SR_Matrices_Ground{p,1})';
    
    run Nitrate_Sulfate_Ammonium_Update
    Delta_PM_25(:,1) = (PM_25-PM_25_Base);
    run PM_25_Health
    
    MD_Ground(n,p) = All_Mortality_Damage; 
end

%% Marginal damages from ground level VOC emissions
run Ground_Reset
p = 5;
for n = 1:S
    fprintf('s %d,p %d,n %d\n', s,p,n);
    Emission_Plus = (Emissions_2017_NEI{s,1}(:,p));
    Emission_Plus(n,1) = (Emissions_2017_NEI{s,1}(n,p)+1);
    VOC(:,1) = VOC_Cal_base.*((Emission_Plus)'*SR_Matrices_Ground{p,1})';
    
    run Nitrate_Sulfate_Ammonium_Update
    Delta_PM_25(:,1) = (PM_25-PM_25_Base);
    run PM_25_Health
    
    MD_Ground(n,p) = All_Mortality_Damage; 
end

%% Run reset before moving to non-EGU point sources
run Ground_Reset

%% end of script.