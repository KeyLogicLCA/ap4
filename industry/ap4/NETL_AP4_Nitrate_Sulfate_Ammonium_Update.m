%% Compute total concentrations across source contributions
% 18 = Molecular weight (MW) particulate NH4
% 62 = MW particulate Nitrate
% 96 = MW particulate Sulfate

% Convert total ammonium, sulfate, and nitrate to molar concentration
NH4_Total(:,1)	= (NH3_Industrial(:,1))./18;
SO4_Total(:,1)	= (SO4_Industrial(:,1))./96;
HNO3_Total(:,1)	= (HNO3_Industrial(:,1))./62;
% Volatile organic compounds and primary PM2.5 in mass concentration
PMP_Total(:,1)	= PMP_Industrial(:,1);
VOC_Total(:,1)	= VOC_Industrial(:,1);

%% Free ammonia available to react with nitrate
% NH4 and SO4 reaction takes precedent
SO4_PM = SO4_Total;
NH4e = (NH4_Total - 1.5.*SO4_PM);
for c = 1:3108
    if NH4e(c,1) <= 0
        NH4e(c,1) = 0;
    else
        NH4e(c,1) = NH4e(c,1);
    endif
end

%% Baseline particulate nitrate
% Use regression model to determine particulate nitrate, a function of
% total nitrate and free ammonia
% Particulate nitrate must not exceed total nitrate
NO3_PM = (0.178.*HNO3_Total - 0.032.*NH4e + 3.715.*(HNO3_Total.*NH4e));
for c = 1:3108
    if NO3_PM(c,1) > HNO3_Total(c,1)
        NO3_PM(c,1) = HNO3_Total(c,1);
    else
        NO3_PM(c,1) = NO3_PM(c,1);
    endif
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
PM_25_Industrial(:,1)  = (NH4_NO3 + NH4_2_SO4 + PMP_Total + VOC_Total);
PM_Spec     = [NH4_NO3 NH4_2_SO4 PMP_Total VOC_Total];

%% end of script.
