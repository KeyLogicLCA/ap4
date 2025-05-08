% AP4_Tract_Control_Script.m
% written by Luke Dennin, Carnegie Mellon University
% updated for GNU Octave by Tyler Davis, NETL site support contractor
% modified for Air Quality Modeling only and memory management
% Successfully tested running Octave 7.3.0 on macOS Monterey.
%
% last edited: 2023-02-27

tic
%% 0) Globals
% Trigger air quality modeling only
aqm_only = true;
% Set user-defined inverse distance weighting method, of which there are three,
% and the specification, of which there are 2 or 3 options per method.
% 1) Closest Counties: 1) 3 cc, 2) 5 cc, 3) 10 cc
% 2) Counties w/in: 1) cw 30 miles, 2) cw 50 miles, 3) cw 100 miles
% 3) Adjacent Counties: 1) ac to home county, 2) + ac to those in 1
idw_meth = 1;
idw_spec = 2;
% Set user-specified dose-response specification for risk assessment
% 1. ACS = American Cancer Society Cohort: Krewski et al. (2009)
% 2. H6C = Harvard Six Cities Study: Lepeule et al. (2012)
epi_study = 1;
% Set user-specified willingness-to-pay (WTP) analysis year and currency
% inflation year for mortality risk reductions
wtp_year = 2017;    % Year for analysis (options: 2000-2020)
usd_year = 2020;    % Year for USD (options: 2000-2020)
% Set user option whether ground-level source VOC and PMP should be
% aggregated to county level (if no, then leave at the tract level).
sourced_by_county = 'yes'; % "yes" or "no"
% Set user-specified archive option for output files
to_archive = true;

%% 1) Initiate
% This section initiates the tract application of the AP4 model.

% Loads pre-defined workspace with input data and AP4 county-level outputs
% needed for AP4_Tract. Conducts county-to-tract interpolation using
% inverse distance weighting (the specific method can be changed).
    % Run-Time: ~ 4 minutes
run AP4_Tract_Initiation             % 62 GB
run AP4_Tract_Module_Preparation

% Set user-specified county FIPS code (or codes)
% RUN ALL FIPS
fips = [42003 42007];
% 2023-02-25: start all FIPS
% - Error on f=159 (FIPS=6003); mean_s failed in Tract_to_Tract_Calibration.m
% - execution time: 9833 s
%fips = AP4_County_List(:,2)';

%% 2.A) Evaluate: Counties
% This section runs the tract application of the AP4 model for counties.
% AP4_Tract runs for a specified county (via its fips code:
% https://transition.fcc.gov/oet/info/maps/census/fips/fips.txt). It
% evaluates tract-level impacts from marginal emissions released from that
% county (or its tracts for ground-level PMP and VOCs). Output is a folder
% with five files -- one for each pollutant: NH3, NOx, PMP, SO2, & VOCs.
    % Run-Time: Ranges from 20 seconds to 7.5 minutes (for LA County)
    % Most of run-time is for file exporting
    % User Input: Single fips -- XXXXXXX; Vector [XXXXXXX YYYYYYY ...]
% Model:
run AP4_Tract_Counties

% Clean up (include here to avoid crashing the all EGU run)
clear Tract_to_Tract Cnty_MC

%% 2.B) Evaluate: EGUs
% This section runs the tract application of the AP4 model for EGUs.
% AP4_Tract runs for a specified EGU (via its eis code - see AP4_EGU_List).
% It evaluates tract-level impacts from marginal emissions released from
% that EGU's coordinates. Output is a folder with five files -- one for
% each pollutant: NH3, NOx, PMP, SO2, & VOCs.
    % Run-Time: 10 seconds
    % User Input: Single eis -- XXXXXXX; Vector [XXXXXXX YYYYYYY ...]

% User Inputs (list of EGU IDs and output title)
% EGU IDs found in AP4_EGU_List third column
% 2023-02-26: run all EGUs
% - execution time: 2642 s
%eis = AP4_EGU_List(:, 3)';
%u_title = 'All_EGU'; % completed in 2642 s
eis = 6789111;
u_title = 'john_e_amos_plant_in_putnam_wv';

% Model:
run AP4_Tract_EGUs

toc
%% end of script.