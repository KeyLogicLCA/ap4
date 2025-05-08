%% This script extracts results from the AP4_Tract model
% Emissions and source-receptor matrices are in metric tons
% Convert to short tons
mt_to_st = 1/1.10231131;

% Create folder for outputs
mkdir(['AP4_Tract_Outputs/AP4_Tract_Counties']);
writetable(AP4_Tract_List(:,3), ...
    ['AP4_Tract_Outputs/AP4_Tract_Info_Receptors.xlsx'], ...
    'sheet', 'receptors','WriteVariableNames',0)

mkdir(['AP4_Tract_Outputs/AP4_Tract_Counties/AP4_Tract_' num2str(fips(f),'%05.f')]);
writetable(County_Tract_List(:,3), ['AP4_Tract_Outputs/AP4_Tract_Counties' ...
    '/AP4_Tract_' num2str(fips(f),'%05.f') '/AP4_Tract_Info_Sources_' ...
    num2str(fips(f),'%05.f') '.xlsx'], ...
    'sheet', 'source','WriteVariableNames',0)

%% AP4_Tract output: NH3
p = 1;
pollutant = 'NH3';
mkdir(['AP4_Tract_Outputs/AP4_Tract_Counties/AP4_Tract_' num2str(fips(f),'%05.f') ...
    '/AP4_Tract_' pollutant '_' num2str(fips(f),'%05.f')]);
b = 1;
tractOutputF1(fips(f),b,p,'Ground',pollutant,Results_MC,Results_MM,mt_to_st)
b = 2;
tractOutputF1(fips(f),b,p,'Point',pollutant,Results_MC,Results_MM,mt_to_st)

%% AP4_Tract output: NOx
p = 2;
pollutant = 'NOx';
mkdir(['AP4_Tract_Outputs/AP4_Tract_Counties/AP4_Tract_' num2str(fips(f),'%05.f') ...
    '/AP4_Tract_' pollutant '_' num2str(fips(f),'%05.f')]);
b = 1;
tractOutputF1(fips(f),b,p,'Ground',pollutant,Results_MC,Results_MM,mt_to_st)
b = 2;
tractOutputF1(fips(f),b,p,'Point',pollutant,Results_MC,Results_MM,mt_to_st)

%% AP4_Tract output: PMP
p = 3;
pollutant = 'PMP';
mkdir(['AP4_Tract_Outputs/AP4_Tract_Counties/AP4_Tract_' num2str(fips(f),'%05.f') ...
    '/AP4_Tract_' pollutant '_' num2str(fips(f),'%05.f')]);
b = 1;
tractOutputF2(fips(f),b,p,'Ground',pollutant,Results_MC,Results_MM,mt_to_st)
b = 2;
tractOutputF1(fips(f),b,p,'Point',pollutant,Results_MC,Results_MM,mt_to_st)

%% AP4_Tract output: SO2
p = 4;
pollutant = 'SO2';
mkdir(['AP4_Tract_Outputs/AP4_Tract_Counties/AP4_Tract_' num2str(fips(f),'%05.f') ...
    '/AP4_Tract_' pollutant '_' num2str(fips(f),'%05.f')]);
b = 1;
tractOutputF1(fips(f),b,p,'Ground',pollutant,Results_MC,Results_MM,mt_to_st)
b = 2;
tractOutputF1(fips(f),b,p,'Point',pollutant,Results_MC,Results_MM,mt_to_st)

%% AP4_Tract output: VOC
p = 5;
pollutant = 'VOC';
mkdir(['AP4_Tract_Outputs/AP4_Tract_Counties/AP4_Tract_' num2str(fips(f),'%05.f') ...
    '/AP4_Tract_' pollutant '_' num2str(fips(f),'%05.f')]);
b = 1;
tractOutputF2(fips(f),b,p,'Ground',pollutant,Results_MC,Results_MM,mt_to_st)
b = 2;
tractOutputF1(fips(f),b,p,'Point',pollutant,Results_MC,Results_MM,mt_to_st)

%% Functions

function tractOutputF1(fips,b,p,bin,pollutant,data_mc,data_md,mt_to_st)
dlmwrite(['AP4_Tract_Outputs/AP4_Tract_Counties/AP4_Tract_' ...
    num2str(fips,'%05.f') '/AP4_Tract_' pollutant '_' num2str(fips,'%05.f') ...
    '/AP4_Tract_' bin '_' pollutant '_MC_' num2str(fips,'%05.f') '.csv'], ...
    data_mc{b,p}*mt_to_st, 'precision', 12)
dlmwrite(['AP4_Tract_Outputs/AP4_Tract_Counties/AP4_Tract_' ...
    num2str(fips,'%05.f') '/AP4_Tract_' pollutant '_' num2str(fips,'%05.f') ...
    '/AP4_Tract_' bin '_' pollutant '_MM_' num2str(fips,'%05.f') '.csv'], ...
    data_md{b,p}*mt_to_st, 'precision', 12)
end

function tractOutputF2(fips,b,p,bin,pollutant,data_mc,data_md,mt_to_st)
dlmwrite(['AP4_Tract_Outputs/AP4_Tract_Counties/AP4_Tract_' ...
    num2str(fips,'%05.f') '/AP4_Tract_' pollutant '_' num2str(fips,'%05.f') ...
    '/AP4_Tract_' bin '_' pollutant '_MC_' num2str(fips,'%05.f') '.csv'], ...
    data_mc{b,p}*mt_to_st, 'precision', 12)
dlmwrite(['AP4_Tract_Outputs/AP4_Tract_Counties/AP4_Tract_' ...
    num2str(fips,'%05.f') '/AP4_Tract_' pollutant '_' num2str(fips,'%05.f') ...
    '/AP4_Tract_' bin '_' pollutant '_MM_' num2str(fips,'%05.f') '.csv'], ...
    data_md{b,p}*mt_to_st, 'precision', 12)
end

%% end of script.