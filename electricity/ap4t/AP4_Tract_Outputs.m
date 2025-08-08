%% This script extracts results from the AP4_Tract model
%
% CHANGELOG
% - remove 'writetable' and replace with 'dlmwrite'
% - move functions to their own function files
%   - note the functional equivalence between tractOutputF1 and tractOutputF2
% - separate F1 and F2 for MC and MM results
% - liberally add air quality modeling only if-statements
% - add check if receptor file exists before rewriting
% - rewrite tractOutputF1 to be more flexible and add archiving
% - create pollutant output directory name

%% Main
% Emissions and source-receptor matrices are in metric tons
% Convert to short tons
mt_to_st = 1/1.10231131;

output_dir = 'AP4_Tract_Outputs/';
cnty_dir = [output_dir 'AP4_Tract_Counties/'];
fips_dir = [cnty_dir 'AP4_Tract_' num2str(fips(f),'%05.f') '/'];

% Create folder for outputs
if exist(output_dir) ~= 7
    mkdir(output_dir)
endif

% Save receptor (tract) IDs
r_file = [output_dir 'AP4_Tract_Info_Receptors.csv'];
if exist(r_file) ~= 2
    dlmwrite(r_file, AP4_Tract_List(:, 3), ",");
endif

if exist(cnty_dir) ~= 7
    mkdir(cnty_dir);
endif

if exist(fips_dir) ~= 7
    mkdir(fips_dir);
endif

% Save receptor sources for given FIPS
r_fips_file = [fips_dir ...
    'AP4_Tract_Info_Sources_' num2str(fips(f),'%05.f') '.csv'];
dlmwrite(r_fips_file, County_Tract_List(:, 3), ",");
if to_archive
    gzip(r_fips_file);
    unlink(r_fips_file);
endif


%% AP4_Tract output: NH3
p = 1;
pollutant = 'NH3';
p_dir = [fips_dir 'AP4_Tract_' pollutant '_' num2str(fips(f),'%05.f') '/'];
mkdir(p_dir);

b = 1;
tractOutputF1(fips(f), b, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)
if ~aqm_only
    tractOutputF2(fips(f),b,p,'Ground',pollutant,Results_MM,mt_to_st)
endif

b = 2;
tractOutputF1(fips(f), b, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)
if ~aqm_only
    tractOutputF2(fips(f),b,p,'Point',pollutant,Results_MM,mt_to_st)
endif


%% AP4_Tract output: NOx
p = 2;
pollutant = 'NOx';
p_dir = [fips_dir 'AP4_Tract_' pollutant '_' num2str(fips(f),'%05.f') '/'];
mkdir(p_dir);

b = 1;
tractOutputF1(fips(f), b, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)
if ~aqm_only
    tractOutputF2(fips(f),b,p,'Ground',pollutant,Results_MM,mt_to_st)
endif

b = 2;
tractOutputF1(fips(f), b, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)
if ~aqm_only
    tractOutputF2(fips(f),b,p,'Point',pollutant,Results_MM,mt_to_st)
endif


%% AP4_Tract output: PMP
p = 3;
pollutant = 'PMP';
p_dir = [fips_dir 'AP4_Tract_' pollutant '_' num2str(fips(f),'%05.f') '/'];
mkdir(p_dir);

b = 1;
tractOutputF1(fips(f), b, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)
if ~aqm_only
    tractOutputF2(fips(f),b,p,'Ground',pollutant,Results_MM,mt_to_st)
endif

b = 2;
tractOutputF1(fips(f), b, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)
if ~aqm_only
    tractOutputF2(fips(f),b,p,'Point',pollutant,Results_MM,mt_to_st)
endif


%% AP4_Tract output: SO2
p = 4;
pollutant = 'SO2';
p_dir = [fips_dir 'AP4_Tract_' pollutant '_' num2str(fips(f),'%05.f') '/'];
mkdir(p_dir);

b = 1;
tractOutputF1(fips(f), b, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)
if ~aqm_only
    tractOutputF2(fips(f),b,p,'Ground',pollutant,Results_MM,mt_to_st)
endif

b = 2;
tractOutputF1(fips(f), b, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)
if ~aqm_only
    tractOutputF2(fips(f),b,p,'Point',pollutant,Results_MM,mt_to_st)
endif


%% AP4_Tract output: VOC
p = 5;
pollutant = 'VOC';
p_dir = [fips_dir 'AP4_Tract_' pollutant '_' num2str(fips(f),'%05.f') '/'];
mkdir(p_dir);

b = 1;
tractOutputF1(fips(f), b, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)
if ~aqm_only
    tractOutputF2(fips(f),b,p,'Ground',pollutant,Results_MM,mt_to_st)
endif

b = 2;
tractOutputF1(fips(f), b, p, 'MC', p_dir, Results_MC, mt_to_st, to_archive)
if ~aqm_only
    tractOutputF2(fips(f),b,p,'Point',pollutant,Results_MM,mt_to_st)
endif

%% Clean up
clear pollutant p b p_dir r_fips_file cnty_dir fips_dir

%% end of script.