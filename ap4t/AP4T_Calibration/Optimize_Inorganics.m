%% AP4T Calibration Optimization: Inorganic Species
% Minimize the mean fractional error (MFE) between modeled and monitored
% inorganic subspecies forming from NH3, NOx, and SO2 emissions by varying
% global calibration coefficients

% Function variables
x0 = [1,1,1]; % Initial values for coefficients
lb = [0.01,0.01,0.01]; % Lower bounds for coefficients
T = AP4T_Tract_List;
A = AQS_Spec;

% Optimization function
objective = @(x)fun(x,Transport_Base,T,A);
constraints = @(x)nonlcon(x,Transport_Base,T,A);

x = fmincon(objective,x0,[],[],[],[],lb,[],constraints);

%% Functions for calibration coefficient optimization
% Air quality modeling, objective, and constraint functions

% Air quality modeling
function opt_is = aqm(x,Transport_Base,T,A)

    % Emissions and concentration dispersion
    b = 1; % Ground
    NH3(:,b)    = x(1).*Transport_Base{b,1};
    NOx(:,b)    = x(2).*Transport_Base{b,2};
    SO2(:,b)    = x(3).*Transport_Base{b,4};
    b = 2; % Non-EGU point
    NH3(:,b)    = x(1).*Transport_Base{b,1};
    NOx(:,b)    = x(2).*Transport_Base{b,2};
    SO2(:,b)    = x(3).*Transport_Base{b,4};
    b = 3; % EGU point
    NH3(:,b)    = x(1).*Transport_Base{b,1};
    NOx(:,b)    = x(2).*Transport_Base{b,2};
    SO2(:,b)    = x(3).*Transport_Base{b,4};

    % Resolved inorganics by tract
    NH4     = (NH3(:,1) + NH3(:,2) + NH3(:,3))./18;
    SO4     = (SO2(:,1) + SO2(:,2) + SO2(:,3))./96;
    HNO3	= (NOx(:,1) + NOx(:,2) + NOx(:,3))./62;
    
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

    % AP4T predictions
    opt_is = table(table2array(T(:,3)), NH4_NO3, NH4_2_SO4, 'VariableNames',["tract" "apt_an" "apt_as"]);
    opt_is = innerjoin(opt_is, A); % Join with AQS observations
    
end

% Objective function
function MFE_is = fun(x,Transport_Base,T,A)

	opt_is = aqm(x,Transport_Base,T,A); % Air quality modeling

   	% Add for inorganic species
    opt_is.aqs_is = opt_is.aqs_an + opt_is.aqs_as;
	opt_is.apt_is = opt_is.apt_an + opt_is.apt_as;

    % Fractional error calculations
    opt_is.fe_is = abs(opt_is.apt_is - opt_is.aqs_is)./(((opt_is.apt_is + opt_is.aqs_is)./2));
    MFE_is = nanmean(opt_is.fe_is); % Mean across data
    
end

% Constraint function
function [c,ceq] = nonlcon(x,Transport_Base,T,A)

    opt_is = aqm(x,Transport_Base,T,A); % Air quality modeling
    
    % Fractional error calculations
    opt_is.fe_an = abs(opt_is.apt_an - opt_is.aqs_an)./(((opt_is.apt_an + opt_is.aqs_an)/2));
    opt_is.fe_as = abs(opt_is.apt_as - opt_is.aqs_as)./(((opt_is.apt_as + opt_is.aqs_as)/2));
	c(1) = nanmean(opt_is.fe_an) - 0.45; % Mean across data
	c(2) = nanmean(opt_is.fe_as) - 0.45;
    
	% Fractional bias calculations
    opt_is.fb_an = (opt_is.apt_an - opt_is.aqs_an)./(((opt_is.apt_an + opt_is.aqs_an)/2));
    opt_is.fb_as = (opt_is.apt_as - opt_is.aqs_as)./(((opt_is.apt_as + opt_is.aqs_as)/2));
	c(3) = abs(nanmean(opt_is.fb_an)) - 0.25; % Mean across data
	c(4) = abs(nanmean(opt_is.fb_as)) - 0.25;
    
    % Criteria constraint for MFE and MFB
    ceq = []; % Must be less than or equal 0.5 and +/- 0.3, respectively
    
end

%% end of script.