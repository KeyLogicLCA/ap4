%% This script extracts results from the AP4_Tract model
% Emissions and source-receptor matrices are in metric tons
% Convert to short tons
mt_to_st = 1/1.10231131;

% Create folder for outputs
mkdir(['AP4_Tract_Outputs/AP4_Tract_EGUs']);
writetable(AP4_Tract_List(:,3), ...
    ['AP4_Tract_Outputs/AP4_Tract_Info_Receptors.xlsx'], ...
    'sheet', 'receptors','WriteVariableNames',0)

mkdir(['AP4_Tract_Outputs/AP4_Tract_EGUs/AP4_Tract_' title]);

%% AP4_Tract output: NH3
p = 1;
pollutant = 'NH3';
mkdir(['AP4_Tract_Outputs/AP4_Tract_EGUs/AP4_Tract_' title ...
    '/AP4_Tract_' pollutant '_' title]);
tractOutputF3(title,p,pollutant,Results_MC,Results_MM,mt_to_st)

%% AP4_Tract output: NOx
p = 2;
pollutant = 'NOx';
mkdir(['AP4_Tract_Outputs/AP4_Tract_EGUs/AP4_Tract_' title ...
    '/AP4_Tract_' pollutant '_' title]);
tractOutputF3(title,p,pollutant,Results_MC,Results_MM,mt_to_st)

%% AP4_Tract output: PMP
p = 3;
pollutant = 'PMP';
mkdir(['AP4_Tract_Outputs/AP4_Tract_EGUs/AP4_Tract_' title ...
    '/AP4_Tract_' pollutant '_' title]);
tractOutputF3(title,p,pollutant,Results_MC,Results_MM,mt_to_st)

%% AP4_Tract output: SO2
p = 4;
pollutant = 'SO2';
mkdir(['AP4_Tract_Outputs/AP4_Tract_EGUs/AP4_Tract_' title ...
    '/AP4_Tract_' pollutant '_' title]);
tractOutputF3(title,p,pollutant,Results_MC,Results_MM,mt_to_st)

%% AP4_Tract output: VOC
p = 5;
pollutant = 'VOC';
mkdir(['AP4_Tract_Outputs/AP4_Tract_EGUs/AP4_Tract_' title ...
    '/AP4_Tract_' pollutant '_' title]);
tractOutputF3(title,p,pollutant,Results_MC,Results_MM,mt_to_st)

%% Functions

function tractOutputF3(title,p,pollutant,data_mc,data_md,mt_to_st)
dlmwrite(['AP4_Tract_Outputs/AP4_Tract_EGUs/AP4_Tract_' ...
    title '/AP4_Tract_' pollutant '_' title ...
    '/AP4_Tract_EGU_' pollutant '_MC_' title '.csv'], ...
    data_mc{1,p}*mt_to_st, 'precision', 12)
dlmwrite(['AP4_Tract_Outputs/AP4_Tract_EGUs/AP4_Tract_' ...
    title '/AP4_Tract_' pollutant '_' title ...
    '/AP4_Tract_EGU_' pollutant '_MM_' title '.csv'], ...
    data_md{1,p}*mt_to_st, 'precision', 12)
end

%% end of script.