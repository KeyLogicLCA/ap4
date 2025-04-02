%% Emissions experiments
% Fires by type from 49 states (1-49 & 51-99)
% Plus all wildfires (50), all prescribed burns (100), and all fires (101)
N = 50*2 + 7; % Number of experiments
AP4T_Experiments = cell(5,N);

%% Define emissions experiments scenarios
% Columns comprise inidividual scenarios

s = height(AP4T_State_List); % S states
for n = 1:s
    fprintf('Emissions Inventory %d\n', n);
    % Use function at end of script 'wildFireEmissionsTract()'
        % Relevant for Primary PM2.5 and VOCs
    AP4T_Experiments{5,n} = wildFireEmissionsTract(n,AP4T_State_List)';
    AP4T_Experiments{5,n+50} = prscBurnEmissionsTract(n,AP4T_State_List)';
	% Use function at end of script 'wildFireEmissionsCounty()'
        % Relevant for NH3, NOx, and SO2
    AP4T_Experiments{1,n} = wildFireEmissionsCounty(n,AP4T_State_List)';
    AP4T_Experiments{1,n+50} = prscBurnEmissionsCounty(n,AP4T_State_List)';
end

%% Total wildfire and prescribed burn emissions
% Add total emissions across all states

fprintf('Emissions Inventory 50\n');
% CONUS wildfires
AP4T_Experiments{5,50} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/emissions_tract_wildfire_ap4_2017_metric.csv']));
AP4T_Experiments{1,50} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/emissions_county_wildfire_ap4_2017_metric.csv']));

% CONUS prescribed burns
AP4T_Experiments{5,100} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/emissions_tract_prscburn_ap4_2017_metric.csv']));
AP4T_Experiments{1,100} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/emissions_county_prscburn_ap4_2017_metric.csv']));
    
% CONUS wildland fires
AP4T_Experiments{5,101} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/emissions_tract_fire_ap4_2017_metric.csv']));
AP4T_Experiments{1,101} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/emissions_county_fire_ap4_2017_metric.csv']));
    
%% Select fire emissions
% Add emissions for Tulare County, CA; Tubbs, Nuns, Atlas + Fires in
% Sonomoa/Napa/Solano, CA Thomas Fire in Ventura County, CA; Collier
% County, FL; Gulf Coast, LA & TX; Just Tubbs

fprintf('Emissions Inventory 51\n');
% Tulare County, CA fires
AP4T_Experiments{5,102} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/Events/tract_emissions_wfs_event_tulare_2017_metric.csv']));
AP4T_Experiments{1,102} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/Events/county_emissions_wfs_event_tulare_2017_metric.csv']));

% Tubbs, Nuns, Atlas + Fires in Sonomoa/Napa/Solano, CA
AP4T_Experiments{5,103} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/Events/tract_emissions_wfs_event_sonoma_2017_metric.csv']));
AP4T_Experiments{1,103} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/Events/county_emissions_wfs_event_sonoma_2017_metric.csv']));
    
% Thomas Fire in Ventura County, CA
AP4T_Experiments{5,104} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/Events/tract_emissions_wfs_event_ventura_2017_metric.csv']));
AP4T_Experiments{1,104} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/Events/county_emissions_wfs_event_ventura_2017_metric.csv']));
    
% Collier County, FL fires
AP4T_Experiments{5,105} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/Events/tract_emissions_pbs_event_collier_2017_metric.csv']));
AP4T_Experiments{1,105} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/Events/county_emissions_pbs_event_collier_2017_metric.csv']));   

% Gulf Coast, LA & TX fires
AP4T_Experiments{5,106} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/Events/tract_emissions_pbs_event_gulf_2017_metric.csv']));
AP4T_Experiments{1,106} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/Events/county_emissions_pbs_event_gulf_2017_metric.csv']));  
    
% Tubbs wildfire
AP4T_Experiments{5,107} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/Events/tract_emissions_wfs_event_tubbs_2017_metric.csv']));
AP4T_Experiments{1,107} = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/Events/county_emissions_wfs_event_tubbs_2017_metric.csv']));  
    
%% Fill in emissions templates where needed
for n = 1:N
    % Emissions experiments are all for fire emissions
    AP4T_Experiments{2,n} = zeros(3108,5); % Non-EGU point
	AP4T_Experiments{3,n} = zeros(1814,5); % EGU point
	AP4T_Experiments{4,n} = zeros(3108,6); % Non-fire ground
end

%% Clean up
clear n N

%% Functions
% State-specific fire data
function matrix = wildFireEmissionsTract(index, intab)
    state = intab.state(intab.row == index,:);
    state = state{1,1};
    matrix = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/States/' ...
        'tract_emissions_wfs_' state '_2017_metric.csv']))';
end
function matrix = prscBurnEmissionsTract(index, intab)
    state = intab.state(intab.row == index,:);
    state = state{1,1};
    matrix = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/States/' ...
        'tract_emissions_pbs_' state '_2017_metric.csv']))';
end
function matrix = wildFireEmissionsCounty(index, intab)
    state = intab.state(intab.row == index,:);
    state = state{1,1};
    matrix = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/States/' ...
        'county_emissions_wfs_' state '_2017_metric.csv']))';
end
function matrix = prscBurnEmissionsCounty(index, intab)
    state = intab.state(intab.row == index,:);
    state = state{1,1};
    matrix = table2array(readtable(['AP4T_Inputs/' ...
        'Emissions_Data/Emissions_Experiments/States/' ...
        'county_emissions_pbs_' state '_2017_metric.csv']))';
end

%% end of script.