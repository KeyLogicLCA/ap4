%% 1) Initiate
% This section initiates the tract application of the AP4 model.

% Loads pre-defined workspace with input data and AP4 county-level outputs
% needed for AP4_Tract. Conducts county-to-tract interpolation using
% inverse distance weighting (the specific method can be changed).
    % Run-Time: ~ 4 minutes

% Initiation Scripts:
run AP4_Tract_Initiation
run AP4_Tract_Module_Preparation

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

% User Input:
fips = 42003;
sourced_by_county = "yes"; % "yes" or "no"
% ^ Aggreates ground level PMP and VOC tract-level sources to the county
% level using a population-weighted tract average

% Model:
run AP4_Tract_Counties

%% 2.B) Evaluate: EGUs
% This section runs the tract application of the AP4 model for EGUs.
% AP4_Tract runs for a specified EGU (via its eis code - see AP4_EGU_List).
% It evaluates tract-level impacts from marginal emissions released from
% that EGU's coordinates. Output is a folder with five files -- one for
% each pollutant: NH3, NOx, PMP, SO2, & VOCs.
    % Run-Time: 10 seconds
    % User Input: Single eis -- XXXXXXX; Vector [XXXXXXX YYYYYYY ...]

% User Inputs:
eis = 6789111;
title = 'john_e_amos_plant_in_putnam_wv'; % title for file

% Model:
run AP4_Tract_EGUs

%% end of script.