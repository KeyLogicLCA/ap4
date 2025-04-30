%% Adaptation of Atmospheric_Chemistry.m for Marginal NOx
% Convert total ammonium, sulfate, and nitrate to molar conentration
NH4     = (NH3(:,1) + NH3(:,2) + NH3(:,3))./18;
SO4     = (SO2(:,1) + SO2(:,2) + SO2(:,3))./96;
HNO3	= (NOx(:,1) + NOx(:,2) + NOx(:,3))./62;
% Volatile organic compounds and primary PM2.5 in mass concentration
OA      = VOC(:,1) + VOC(:,2) + VOC(:,3) + VOC(:,4) + VOC_B(:,1);
PRI     = PMP(:,1) + PMP(:,2) + PMP(:,3) + PMP(:,4);

%% Free ammonia available to react with nitrate
% NH4 and SO4 reaction takes precedent
NH4e = (NH4 - 1.5.*SO4); % Free ammonia
for t = 1:72538
    if NH4e(t,1) <= 0      
        NH4e(t,1) = 0;
    else
        NH4e(t,1) = NH4e(t,1);
    end  
end


%% Baseline ammonium nitrate + incremental ammonium nitrate
% Compute baseline ammonium nitrate using baseline gaseous nitrate
NO3_Base = (0.178.*HNO3_Base - 0.032.*NH4e_Base + 3.715.*(HNO3_Base.*NH4e_Base));

% Use linear model for incremental contribution of NOx emission to NH4_NO3
dHNO3 = HNO3 - HNO3_Base;
NO3_Nitrate_Limit(:,1) = (0.365.*dHNO3 + 9.497*(dHNO3.*NH4e_Base));
NO3_Ammonia_Limit(:,1) = (0.348.*dHNO3 + 7.900*(dHNO3.*NH4e_Base));

% Add marginal contribution to base concentration
for t = 1:72538
    if NH4e_Base(t,1) == 0        
        NO3(t,1)  = NO3_Base(t,1)+ NO3_Ammonia_Limit(t,1);
    else
        NO3(t,1) = NO3_Base(t,1) + NO3_Nitrate_Limit(t,1);
    end  
end

% Particulate nitrate must not exceed total nitrate
for t = 1:72538
    if NO3(t,1) > HNO3(t,1)      
        NO3(t,1) = HNO3(t,1);
    elseif NO3(t,1) <= 0
        NO3(t,1) = 0;
    else
        NO3(t,1) = NO3(t,1);
    end  
end

%% Compute ammonium nitrate and ammonium sulfate
% Ammonium Nitrate:
% 1 mole of particulate ammonium per 1 mole of particulate nitrate
NH4_NO3     = NO3.*(1*18 + 62); 

% Ammonium Sulfate:
% Assume all sulfate neutralized by ambient ammonia
% 2 moles of particulate ammonium per 1 mole of sulfate
NH4_2_SO4   = SO4.*(2*18 + 96);

% Assemble species into total PM_25
PM25   = (NH4_NO3 + NH4_2_SO4 + OA + PRI);
PM_Spec = [NH4_NO3 NH4_2_SO4 OA PRI];

%% end of script.