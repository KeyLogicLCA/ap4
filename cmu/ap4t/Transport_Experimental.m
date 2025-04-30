%% Gaussian computations
Transport_Exp = cell(4,6);

%% Primary PM2.5 & VOCs

b = 1;  % Non-fire ground pollution
f = 4;  % County-level ground emissions w/o fires
Transport_Exp{b,3} = (AP4_Emissions{f,1}(:,3)'*AP4T_SR_Matrices{b,3})' - ...
    (AP4T_Experiments{f,i}(:,3)'*AP4T_SR_Matrices{b,3})';	% Primary PM2.5
Transport_Exp{b,5} = (AP4_Emissions{f,1}(:,5)'*AP4T_SR_Matrices{b,5})' - ...
    (AP4T_Experiments{f,i}(:,5)'*AP4T_SR_Matrices{b,5})';	% Non-biogenic VOCs
Transport_Exp{b,6} = (AP4_Emissions{b,1}(:,6)'*AP4T_SR_Matrices{b,5})' - ...
    (AP4T_Experiments{b,i}(:,6)'*AP4T_SR_Matrices{b,5})';	% Bio-genic VOCs

b = 2;  % Non-EGU  point emissions/pollution
Transport_Exp{b,3} = (AP4_Emissions{b,1}(:,3)'*AP4T_SR_Matrices{b,3})' - ...
    (AP4T_Experiments{b,i}(:,3)'*AP4T_SR_Matrices{b,3})';	% Primary PM2.5
Transport_Exp{b,5} = (AP4_Emissions{b,1}(:,5)'*AP4T_SR_Matrices{b,5})' - ...
    (AP4T_Experiments{b,i}(:,5)'*AP4T_SR_Matrices{b,5})';	% VOCs

b = 3;  % EGU  point emissions/pollution
Transport_Exp{b,3} = (AP4_Emissions{b,1}(:,3)'*AP4T_SR_Matrices{b,3})' - ...
    (AP4T_Experiments{b,i}(:,3)'*AP4T_SR_Matrices{b,3})';	% Primary PM2.5
Transport_Exp{b,5} = (AP4_Emissions{b,1}(:,5)'*AP4T_SR_Matrices{b,5})' - ...
    (AP4T_Experiments{b,i}(:,5)'*AP4T_SR_Matrices{b,5})';	% VOCs

b = 4;  % Fires pollution
f = 5;  % Tract-level fire emissions
t = height(AP4T_Tract_List);
c = height(AP4T_County_List);
Concs_Fire_PMP = zeros(t,c);
Concs_Fire_VOC = zeros(t,c);
for s = 1:c
% 	fprintf('Tract-to-Tract Fire AP4T_SR_Matrices: s = %d of %d\n', s, c);
	tracts = AP4T_Tract_List.id(AP4T_Tract_List.ap4 == s,:);
	ttt = Tract_to_Tract{s,1}; % Tract-to-tract
	Concs_Fire_PMP(:,s) = (AP4_Emissions{f,1}(tracts,3)'*ttt)' - ...
        (AP4T_Experiments{f,i}(tracts,3)'*ttt)';
    Concs_Fire_VOC(:,s) = (AP4_Emissions{f,1}(tracts,5)'*ttt)' - ...
        (AP4T_Experiments{f,i}(tracts,5)'*ttt)';
end
Transport_Exp{b,3} = sum(Concs_Fire_PMP,2);     % Primary PM2.5
Transport_Exp{b,5} = sum(Concs_Fire_VOC,2);     % VOCs

clear ttt Concs_Fire_PMP Concs_Fire_VOC

%% Inorganic species

b = 1; % Ground (non-fire + fires)
Transport_Exp{b,1} = (AP4_Emissions{b,1}(:,1)'*AP4T_SR_Matrices{b,1})' - ...
    (AP4T_Experiments{b,i}(:,1)'*AP4T_SR_Matrices{b,1})';	% NH3
Transport_Exp{b,2} = (AP4_Emissions{b,1}(:,2)'*AP4T_SR_Matrices{b,2})' - ...
    (AP4T_Experiments{b,i}(:,2)'*AP4T_SR_Matrices{b,2})';	% NOx
Transport_Exp{b,4} = (AP4_Emissions{b,1}(:,4)'*AP4T_SR_Matrices{b,4})' - ...
    (AP4T_Experiments{b,i}(:,4)'*AP4T_SR_Matrices{b,4})';	% SO2
% Non-EGU point
b = 2;
Transport_Exp{b,1} = (AP4_Emissions{b,1}(:,1)'*AP4T_SR_Matrices{b,1})' - ...
    (AP4T_Experiments{b,i}(:,1)'*AP4T_SR_Matrices{b,1})';	% NH3    
Transport_Exp{b,2} = (AP4_Emissions{b,1}(:,2)'*AP4T_SR_Matrices{b,2})' - ...
    (AP4T_Experiments{b,i}(:,2)'*AP4T_SR_Matrices{b,2})';	% NOx
Transport_Exp{b,4} = (AP4_Emissions{b,1}(:,4)'*AP4T_SR_Matrices{b,4})' - ...
    (AP4T_Experiments{b,i}(:,4)'*AP4T_SR_Matrices{b,4})';	% SO2
% EGU point
b = 3;
Transport_Exp{b,1} = (AP4_Emissions{b,1}(:,1)'*AP4T_SR_Matrices{b,1})' - ...
    (AP4T_Experiments{b,i}(:,1)'*AP4T_SR_Matrices{b,1})';	% NH3    
Transport_Exp{b,2} = (AP4_Emissions{b,1}(:,2)'*AP4T_SR_Matrices{b,2})' - ...
    (AP4T_Experiments{b,i}(:,2)'*AP4T_SR_Matrices{b,2})';	% NOx
Transport_Exp{b,4} = (AP4_Emissions{b,1}(:,4)'*AP4T_SR_Matrices{b,4})' - ...
    (AP4T_Experiments{b,i}(:,4)'*AP4T_SR_Matrices{b,4})';	% SO2

%% end of script.