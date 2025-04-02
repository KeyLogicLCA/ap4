%% Compute total PM2.5 concentrations across source contributions
% Run atmospheric chemistry modeling. Total abient PM2.5 is combination of
% directly emitted PM2.5, organic aerosols from VOCs, ammonium sulfate from
% NH3 and SO2, and ammonium nitrate from NH3 and NOx

% Formation of ammonium sulfate, sulfate, and ammonium nitrate are
% dependent on the equilibrium between total ammonia (from NH3), sulfate
% (from SO2), and total nitrate (from NOx) in the ambient air

%% Pollutant dictionary
% NH4   = Ammonium
% SO4   = Sulfate
% HNO3  = Nitrate
% OA    = Organic Aerosols
% PRI   = Primary Ambient PM2.5

%% Aggregate speciated concentrations across bins
% Chemistry conversions: MW = molecular weight
% 18 = MW particulate ammonium
% 62 = MW particulate nitrate
% 96 = MW particulate sulfate

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

%% Baseline particulate nitrate
% Use regression model to determine particulate nitrate, a function of
% total nitrate and free ammonia
NO3 = (0.178.*HNO3 - 0.032.*NH4e + 3.715.*(HNO3.*NH4e));
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