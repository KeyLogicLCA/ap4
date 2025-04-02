%% Compute total concentrations across source contributions
% 18 = Molecular weight (MW) particulate NH4
% 62 = MW particulate Nitrate
% 96 = MW particulate Sulfate

% Convert total ammonium, sulfate, and nitrate to molar conentration
NH4_Total(:,1)	= (NH3(:,1) + NH3(:,2) + NH3(:,3))./18;
SO4_Total(:,1)	= (SO4(:,1) + SO4(:,2) + SO4(:,3))./96;
HNO3_Total(:,1)	= (HNO3(:,1) + HNO3(:,2) + HNO3(:,3))./62;
% Volatile organic compounds and primary PM2.5 in mass concentration
PMP_Total(:,1)	= PMP(:,1) + PMP(:,2) + PMP(:,3);
VOC_Total(:,1)	= VOC(:,1) + VOC(:,2) + VOC(:,3) + VOC_B(:,1);

%% Free ammonia available to react with nitrate
% NH4 and SO4 reaction takes precedent
SO4_PM = SO4_Total;
NH4e = (NH4_Total - 1.5.*SO4_PM);
for c = 1:3108
    if NH4e(c,1) <= 0      
        NH4e(c,1) = 0;
    else
        NH4e(c,1) = NH4e(c,1);
    end  
end

%% Baseline ammonium nitrate + incremental ammonium nitrate
% Compute baseline particulate nitrate using baseline gaseous nitrate
NO3_PM_Base(:,1) = (0.178.*HNO3_Base - 0.032.*NH4e_Base + 3.715.*(HNO3_Base.*NH4e_Base));

% Use linear model for incremental contribution of NH3 emissions
dNH4e = NH4e - NH4e_Base;
NO3_PM_Nitrate_Limit(:,1) = (-0.039.*dNH4e + 9.497*(HNO3_Base.*dNH4e));
NO3_PM_Ammonia_Limit(:,1) = ( 0.519.*dNH4e + 7.900*(HNO3_Base.*dNH4e));

% Add marginal contribution to base concentration
for c = 1:3108
    if NH4e_Base(c,1) == 0        
        NO3_PM(:,1) = NO3_PM_Base(:,1)+ NO3_PM_Ammonia_Limit(:,1);
    else
        NO3_PM(:,1) = NO3_PM_Base(:,1) + NO3_PM_Nitrate_Limit(:,1);
    end  
end

% Particulate nitrate must not exceed total nitrate
for c = 1:3108
    if NO3_PM(c,1) > HNO3_Total(c,1)      
        NO3_PM(c,1) = HNO3_Total(c,1);
    else
        NO3_PM(c,1) = NO3_PM(c,1);
    end  
end

%% Compute ammonium nitrate and ammonium sulfate
% Ammonium Nitrate:
% 1 mole of particulate ammonium per 1 mole of particulate nitrate
NH4_NO3     = NO3_PM.*(1*18 + 62); 

% Ammonium Sulfate:
% Assume all sulfate neutralized by ambient ammonia
% 2 moles of particulate ammonium per 1 mole of sulfate
NH4_2_SO4   = SO4_PM.*(2*18 + 96);

% Assemble species into total PM_25
PM_25(:,1)  = (NH4_NO3 + NH4_2_SO4 + PMP_Total + VOC_Total);

%% end of script.