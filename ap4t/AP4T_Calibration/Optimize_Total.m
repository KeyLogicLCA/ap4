%% AP4T Calibration Optimization: Total particulates
% Minimize the mean fractional error (MFE) between modeled and monitored
% total particulates forming from all emissions by varying global
% calibration coefficient for primary PM2.5

% Function variables
x0 = [1]; % Initial values for coefficients
lb = [0.01]; % Lower bounds for coefficients
T = AP4T_Tract_List;
A = AQS_PM;

%% Optimization function
objective = @(x)fun(x,T,A,Cal_NH3,Cal_NOx,Cal_SO2,Cal_VOC,Cal_VOC_B,Transport_Base);
constraints = @(x)nonlcon(x,T,A,Cal_NH3,Cal_NOx,Cal_SO2,Cal_VOC,Cal_VOC_B,Transport_Base);

x = fmincon(objective,x0,[],[],[],[],lb,[],constraints);

%% Functions for calibration coefficient optimization
% Air quality modeling, objective, and constraint functions

% Air quality modeling
function opt_tp = aqm(x,T,A,Cal_NH3,Cal_NOx,Cal_SO2,Cal_VOC,Cal_VOC_B,Transport_Base)

    % Emissions and concentration dispersion
    b = 1; % Ground
    NH3(:,b)    = Cal_NH3.*Transport_Base{b,1};
    NOx(:,b)    = Cal_NOx.*Transport_Base{b,2};
    PMP(:,b)    = x(1).*Transport_Base{b,3};
    SO2(:,b)    = Cal_SO2.*Transport_Base{b,4};
	VOC(:,b)    = Cal_VOC.*Transport_Base{b,5};
    VOC_B(:,b)  = Cal_VOC_B.*Transport_Base{b,6};
    b = 2; % Non-EGU point
    NH3(:,b)    = Cal_NH3.*Transport_Base{b,1};
    NOx(:,b)    = Cal_NOx.*Transport_Base{b,2};
    PMP(:,b)    = x(1).*Transport_Base{b,3};
    SO2(:,b)    = Cal_SO2.*Transport_Base{b,4};
	VOC(:,b)    = Cal_VOC.*Transport_Base{b,5};
    b = 3; % EGU point
    NH3(:,b)    = Cal_NH3.*Transport_Base{b,1};
    NOx(:,b)    = Cal_NOx.*Transport_Base{b,2};
    PMP(:,b)    = x(1).*Transport_Base{b,3};
    SO2(:,b)    = Cal_SO2.*Transport_Base{b,4};
	VOC(:,b)    = Cal_VOC.*Transport_Base{b,5};
    b = 4; % Fires
    PMP(:,b)    = x(1).*Transport_Base{4,3};
	VOC(:,b)    = Cal_VOC.*Transport_Base{4,5};


    % Resolved organic aerosols by tract
    OA = VOC(:,1) + VOC(:,2) + VOC(:,3) + VOC(:,4) + VOC_B(:,1);
    % Resolved inorganics by tract
    NH4     = (NH3(:,1) + NH3(:,2) + NH3(:,3))./18;
    SO4     = (SO2(:,1) + SO2(:,2) + SO2(:,3))./96;
    HNO3	= (NOx(:,1) + NOx(:,2) + NOx(:,3))./62;
    % Resolved primaries by tract
    PRI     = PMP(:,1) + PMP(:,2) + PMP(:,3) + PMP(:,4);
    
    % Free ammonia available to react with nitrate
    NH4e = (NH4 - 1.5.*SO4);
    for t = 1:72538
        if NH4e(t,1) <= 0      
            NH4e(t,1) = 0;
        else
            NH4e(t,1) = NH4e(t,1);
        end  
    end
    
    % Particulate nitrate function
    NO3 = (0.178.*HNO3 - 0.032.*NH4e + 3.715.*(HNO3.*NH4e));
    % Must not exceed total nitrate
    for t = 1:72538
        if NO3(t,1) > HNO3(t,1)      
            NO3(t,1) = HNO3(t,1);
        elseif NO3(t,1) <= 0
            NO3(t,1) = 0;
        else
            NO3(t,1) = NO3(t,1);
        end  
    end
    
    % Ammonium nitrate and ammonioum sulfate
    NH4_NO3     = NO3.*(1*18 + 62); 
    NH4_2_SO4	= SO4.*(2*18 + 96);
    
    % Assemble species into total PM_25
    PM25        = (NH4_NO3 + NH4_2_SO4 + OA + PRI);

    % AP4T predictions
    opt_tp = table(table2array(T(:,3)), PM25, 'VariableNames',["tract" "apt"]);
    opt_tp = innerjoin(opt_tp, A); % Join with AQS observations
    
end

% Objective function
function MFE_tp = fun(x,T,A,Cal_NH3,Cal_NOx,Cal_SO2,Cal_VOC,Cal_VOC_B,Transport_Base)
    
    opt_tp = aqm(x,T,A,Cal_NH3,Cal_NOx,Cal_SO2,Cal_VOC,Cal_VOC_B,Transport_Base); % Air quality modeling

    % Fractional error calculations
    opt_tp.fe = abs(opt_tp.apt - opt_tp.aqs)./(((opt_tp.apt + opt_tp.aqs)/2));
    MFE_tp = nanmean(opt_tp.fe); % Mean across data
    
end

% Constraint function
function [c,ceq] = nonlcon(x,T,A,Cal_NH3,Cal_NOx,Cal_SO2,Cal_VOC,Cal_VOC_B,Transport_Base)

    opt_tp = aqm(x,T,A,Cal_NH3,Cal_NOx,Cal_SO2,Cal_VOC,Cal_VOC_B,Transport_Base); % Air quality modeling

    % Fractional bias calculations
    opt_tp.fb = (opt_tp.apt - opt_tp.aqs)./(((opt_tp.apt + opt_tp.aqs)/2));
    c(1) = abs(nanmean(opt_tp.fb)) - 0.25; % Mean across data
    
    % Criteria constraint for MFB
    ceq = []; % Must be less than or equal to +/- 0.3
    
end

%% end of script.