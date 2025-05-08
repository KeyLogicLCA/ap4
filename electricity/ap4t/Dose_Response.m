%% Dose-response (adult) from epidimiological literature
% ACS = American Cancer Society Cohort: Krewski et al. (2009)
% H6C = Harvard Six Cities Study: Lepeule et al. (2012)
if epi_study == 1
    dr = DR_Info(1,1);
    Pop_Exposed = Pop_Over30;
elseif epi_study == 2
    dr = DR_Info(2,1);
    Pop_Exposed = Pop_Over25;
endif

%% Infant dose-response
% Post Neonatal Infant Mortality: Woodruff et al. (2006)
dr_infant = DR_Info(3,1);

%% end of script.