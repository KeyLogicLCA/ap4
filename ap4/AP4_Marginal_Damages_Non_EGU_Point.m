%% Non-EGU point source emissions
s = 2;

%% Marginal damages from non-EGU point source NH3 emissions
run Point_Non_EGU_Reset
p = 1;
for n = 1:S
    fprintf('s %d,p %d,n %d\n', s,p,n);
    Emission_Plus = (Emissions_2017_NEI{s,1}(:,p));
    Emission_Plus(n,1) = (Emissions_2017_NEI{s,1}(n,p)+1);
    NH3(:,2) = NH3_Cal_base.*((Emission_Plus)'*SR_Matrices_Point_Non_EGU{p,1})';
    
    run Nitrate_Sulfate_Ammonium_Marginal_NH3_Emission_Update
    Delta_PM_25(:,1) = (PM_25-PM_25_Base);
    run PM_25_Health
    
    MD_Non_EGU_Point(n,p) = All_Mortality_Damage;
end

%% Marginal damages from non-EGU point source NOx emissions
run Point_Non_EGU_Reset
p = 2;
for n = 1:S 
    fprintf('s %d,p %d,n %d\n', s,p,n);
    Emission_Plus = (Emissions_2017_NEI{s,1}(:,p));
    Emission_Plus(n,1) = (Emissions_2017_NEI{s,1}(n,p)+1);
    HNO3(:,2) = NOx_Cal_base.*((Emission_Plus)'*SR_Matrices_Point_Non_EGU{p,1})';
    
    run Nitrate_Sulfate_Ammonium_Marginal_NOx_Emission_Update
    Delta_PM_25(:,1) = (PM_25-PM_25_Base);
    run PM_25_Health
    
    MD_Non_EGU_Point(n,p) = All_Mortality_Damage;
end

%% Marginal damages from non-EGU point source primary PM25 emissions
run Point_Non_EGU_Reset
p = 3;
for n = 1:S
    fprintf('s %d,p %d,n %d\n', s,p,n);
    Emission_Plus = (Emissions_2017_NEI{s,1}(:,p));
    Emission_Plus(n,1) = (Emissions_2017_NEI{s,1}(n,p)+1);
    PMP(:,2) = PMP_Cal_base'.*((Emission_Plus)'*SR_Matrices_Point_Non_EGU{p,1})';
    
    run Nitrate_Sulfate_Ammonium_Update
    Delta_PM_25(:,1) = (PM_25-PM_25_Base);
    run PM_25_Health
    
    MD_Non_EGU_Point(n,p) = All_Mortality_Damage;  
end

%% Marginal damages from non-EGU point source SO2 emissions
run Point_Non_EGU_Reset
p = 4;
for n = 1:S
    fprintf('s %d,p %d,n %d\n', s,p,n);
    Emission_Plus = (Emissions_2017_NEI{s,1}(:,p));
    Emission_Plus(n,1) = (Emissions_2017_NEI{s,1}(n,p)+1);
    SO4(:,2) = SO2_Cal_base.*((Emission_Plus)'*SR_Matrices_Point_Non_EGU{p,1})';
    
    run Nitrate_Sulfate_Ammonium_Update
    Delta_PM_25(:,1) = (PM_25-PM_25_Base);
    run PM_25_Health
    
    MD_Non_EGU_Point(n,p) = All_Mortality_Damage;
end

%% Marginal damages from non-EGU point source VOC emissions
run Point_Non_EGU_Reset
p = 5;
for n = 1:S
    fprintf('s %d,p %d,n %d\n', s,p,n);
    Emission_Plus = (Emissions_2017_NEI{s,1}(:,p));
    Emission_Plus(n,1) = (Emissions_2017_NEI{s,1}(n,p)+1);
    VOC(:,2) = VOC_Cal_base.*((Emission_Plus)'*SR_Matrices_Point_Non_EGU{p,1})';

    run Nitrate_Sulfate_Ammonium_Update
    Delta_PM_25(:,1) = (PM_25-PM_25_Base);
    run PM_25_Health
    
    MD_Non_EGU_Point(n,p) = All_Mortality_Damage;
end

%% Run reset before moving to EGU point sources
run Point_Non_EGU_Reset

%% end of script.