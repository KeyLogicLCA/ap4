%% Tract-to-Tract Averaged to County-to-County
%
% CHANGELOG
% - swap height for size
% - update id search in AP4_Tract_List; ('ap4', 'fips', 'tract', and 'id')
% - add clean up step (only Cal_PMP and Cal_VOC are referenced again)
% - fix mean_s when row count for Tract_to_Tract{index, 1} is only one
% - hotfix idx for index

Cal_Vector = zeros(1,3108); % template for county-to-county impacts
% Mean impact of county's tracts on U.S. tracts
% - if Tract_to_Tract{index, 1} has only 1 row, then do not take the mean
num_rows = size(Tract_to_Tract{idx, 1}, 1);
if num_rows > 1
    mean_s = mean(Tract_to_Tract{idx,1});
else
    mean_s = Tract_to_Tract{idx, 1};
endif

C = size(AP4_County_List, 1);  % C counties
for n = 1:C
    cols = AP4_Tract_List(AP4_Tract_List(:, 1) == n, 4);
    % Mean impact of county's tracts on U.S. counties
    mean_sr = mean(mean_s(1,cols));
    % County-to-county impacts
    Cal_Vector(1,n) = mean_sr;
endfor

%% Calibration Coefficient Optimization
% Minimize mean absolute percentage error of county average of tract-level
% ambient PM2.5 from AP4 county-level (take AP4 county-level as "true")

% PMP
Cnty_MCs = Cnty_MC{1,3}(idx,:); % AP4 county-level
MAPE = @(x)mean(abs(Cnty_MCs - x.*Cal_Vector)./Cnty_MCs);
x = fminbnd(MAPE,0,10);
Cal_PMP = x;

% VOC
Cnty_MCs = Cnty_MC{1,5}(idx,:); % AP4 county-level
MAPE = @(x)mean(abs(Cnty_MCs - x.*Cal_Vector)./Cnty_MCs);
x = fminbnd(MAPE,0,10);
Cal_VOC = x;

%% Clean up
clear Cnty_MCs MAPE x n mean_s mean_sr Cal_Vector cols C num_rows

%% end of script.