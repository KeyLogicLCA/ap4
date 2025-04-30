%% AP4T's In-House Validation
% Compute mean fractional error (MFE) and mean fractional bias (MFB) of
% modeled versus monitored data

% Boylan & Russell (2006) suggested that an MFE less than or equal to 50%
% and an MFB less than or equal to +/- 30% indicates that a model has met
% its performance goal

% Matrix of test results
Test = zeros(5,2);

%% Total PM2.5 (Primary + Secondary)
% AP4T predictions
Test_PM = table(table2array(AP4T_Tract_List(:,3)),PM25,'VariableNames',["tract" "apt"]);
Test_PM = innerjoin(Test_PM,AQS_PM,'Keys',"tract"); % Join with AQS observations

Test_PM.fe = abs(Test_PM.apt - Test_PM.aqs)./(((Test_PM.apt + Test_PM.aqs)/2));
Test_PM.fb = (Test_PM.apt - Test_PM.aqs)./(((Test_PM.apt + Test_PM.aqs)/2));
Test(1,1) = mean(Test_PM.fe); % MFE total PM
Test(1,2) = mean(Test_PM.fb); % MFB total PM

%% Subspecies of PM2.5 (Secondary)
% AP4T predictions
Test_Spec = table(table2array(AP4T_Tract_List(:,3)), NH4_NO3, NH4_2_SO4, OA,'VariableNames',["tract" "apt_an" "apt_as" "apt_oa"]);
% Total secondary: AP4T
Test_Spec.apt_sec = Test_Spec.apt_an + Test_Spec.apt_as + Test_Spec.apt_oa;
Test_Spec = innerjoin(Test_Spec, AQS_Spec,'Keys',"tract"); % Join with AQS observations
% Total secondary: AQS
Test_Spec.aqs_sec = Test_Spec.aqs_an + Test_Spec.aqs_as + Test_Spec.aqs_oa;

Test_Spec.fe_an = abs(Test_Spec.apt_an - Test_Spec.aqs_an)./(((Test_Spec.apt_an + Test_Spec.aqs_an)/2));
Test_Spec.fe_as = abs(Test_Spec.apt_as - Test_Spec.aqs_as)./(((Test_Spec.apt_as + Test_Spec.aqs_as)/2));
Test_Spec.fe_oa = abs(Test_Spec.apt_oa - Test_Spec.aqs_oa)./(((Test_Spec.apt_oa + Test_Spec.aqs_oa)/2));
Test_Spec.fe_sec = abs(Test_Spec.apt_sec - Test_Spec.aqs_sec)./(((Test_Spec.apt_sec + Test_Spec.aqs_sec)/2));

Test_Spec.fb_an = (Test_Spec.apt_an - Test_Spec.aqs_an)./(((Test_Spec.apt_an + Test_Spec.aqs_an)/2));
Test_Spec.fb_as = (Test_Spec.apt_as - Test_Spec.aqs_as)./(((Test_Spec.apt_as + Test_Spec.aqs_as)/2));
Test_Spec.fb_oa = (Test_Spec.apt_oa - Test_Spec.aqs_oa)./(((Test_Spec.apt_oa + Test_Spec.aqs_oa)/2));
Test_Spec.fb_sec = (Test_Spec.apt_sec - Test_Spec.aqs_sec)./(((Test_Spec.apt_sec + Test_Spec.aqs_sec)/2));

Test(2,1) = nanmean(Test_Spec.fe_an); % MFE subspecies PM
Test(3,1) = nanmean(Test_Spec.fe_as);
Test(4,1) = nanmean(Test_Spec.fe_oa);
Test(5,1) = nanmean(Test_Spec.fe_sec);

Test(2,2) = nanmean(Test_Spec.fb_an); % MFB subspecies PM
Test(3,2) = nanmean(Test_Spec.fb_as);
Test(4,2) = nanmean(Test_Spec.fb_oa);
Test(5,2) = nanmean(Test_Spec.fb_sec);

%% Clean up
% clear Test_PM Test_Spec

%% end of script.