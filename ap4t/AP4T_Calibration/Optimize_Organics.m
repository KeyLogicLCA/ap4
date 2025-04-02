%% AP4T Calibration Optimization: Organic Aerosols
% Minimize the mean fractional error (MFE) between modeled and monitored
% organic aerosols forming from VOC emissions by varying global calibration
% coefficients

% Function variables
x0 = [1,1]; % Initial values for coefficients
lb = [0.01,0.01]; % Lower bounds for coefficients
T = AP4T_Tract_List;
A = AQS_Spec;

%% Optimization function
objective = @(x)fun(x,Transport_Base,T,A);
constraints = @(x)nonlcon(x,Transport_Base,T,A);

x = fmincon(objective,x0,[],[],[],[],lb,[],constraints);

%% Functions for calibration coefficient optimization
% Air quality modeling, objective, and constraint functions

% Air quality modeling
function opt_oa = aqm(x,Transport_Base,T,A)

    % Emissions and concentration dispersion
    b = 1;  % Ground
    VOC(:,b)    = x(1).*Transport_Base{1,5};	% Non-biogenics & non-fire ground
    VOC_B(:,b)  = x(2).*Transport_Base{1,6};	% Biogenic ground
    b = 2;  % Non-EGU point
    VOC(:,b)    = x(1).*Transport_Base{2,5};
    b = 3;  % EGU point
    VOC(:,b)    = x(1).*Transport_Base{3,5};
    b = 4;  % Fires
	VOC(:,b)    = x(1).*Transport_Base{4,5};

    % Resolved organic aerosols by tract
    OA = VOC(:,1) + VOC(:,2) + VOC(:,3) + VOC(:,4) + VOC_B(:,1);
    
	% AP4T predictions
    opt_oa = table(table2array(T(:,3)), OA, 'VariableNames',["tract" "apt_oa"]);
    opt_oa = innerjoin(opt_oa, A); % Join with AQS observations
    
end

% Objective function
function MFE_oa = fun(x,Transport_Base,T,A)
    
    opt_oa = aqm(x,Transport_Base,T,A); % Air quality modeling

    % Fractional error calculations
    opt_oa.fe_oa = abs(opt_oa.apt_oa - opt_oa.aqs_oa)./(((opt_oa.apt_oa + opt_oa.aqs_oa)/2));
    MFE_oa = nanmean(opt_oa.fe_oa); % Mean across data
    
end

% Constraint function
function [c,ceq] = nonlcon(x,Transport_Base,T,A)

    opt_oa = aqm(x,Transport_Base,T,A); % Air quality modeling

    % Fractional bias calculations
    opt_oa.fb_oa = (opt_oa.apt_oa - opt_oa.aqs_oa)./(((opt_oa.apt_oa + opt_oa.aqs_oa)/2));
    c(1) = abs(nanmean(opt_oa.fb_oa)) - 0.25; % Mean across data
    
    % Criteria constraint for MFB
    ceq = []; % Must be less than or equal to +/- 0.3
    
end

%% end of script.