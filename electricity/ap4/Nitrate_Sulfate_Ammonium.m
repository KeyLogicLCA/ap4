%% Compute concentrations of particulate nitrate, ammonium, and sulfate
% 18 = Molecular weight (MW) particulate NH4
% 96 = MW particulate Sulfate
% 62 = MW particulate Nitrate

%% Compute total concentrations across source contributions
NH4_Total(:,1)     = (NH3(:,1) + NH3(:,2) + NH3(:,3));
SO4_Total(:,1)     = (SO4(:,1) + SO4(:,2) + SO4(:,3));
HNO3_Total(:,1)    = (HNO3(:,1) + HNO3(:,2) + HNO3(:,3))./62;
VOC_Total(:,1)     = (VOC(:,1) + VOC(:,2) + VOC(:,3) + VOC_B(:,1));
PM_25_Primary(:,1) = PM25_Direct(:,1)+PM25_Direct(:,2)+PM25_Direct(:,3);

%% Partitioning of ammonia into nitrate and sulfate
% This calculates free ammonia available to react with HNO3
NH4e(:,1) = (NH4_Total(:,1)./18 - 1.5.*SO4_Total(:,1)./96);

for c = 1:3108;
    if NH4e(c,1) <= 0;
        NH4e(c,1) = 0;
    else NH4e(c,1) = NH4e(c,1);
    end
end

% Compute baseline ammonium nitrate using baseline gaseous nitrate (post multiplication by 80 converts to ug/m^3)
NH4_NO3(:,1) = (0.178.*HNO3_Total - 0.032.*NH4e + 3.715.*(HNO3_Total.*NH4e)).*80;

% Assume all sulfate neutralized by ambient ammonia
NH4_2_SO4(:,1) = (1.375.*(SO4_Total));

% Assemble species into total PM_25
PM_25(:,1) = (NH4_NO3(:,1) + NH4_2_SO4(:,1) + VOC_Total(:,1) + PM_25_Primary(:,1));

%% end of script.

%% Previous code in AP3 model
%NH4_NO3(:,1) = 0.6509.*(0.33873.*HNO3_Total+0.12.*NH4e+ 3.511482.*(HNO3_Total.*NH4e)).*62;
