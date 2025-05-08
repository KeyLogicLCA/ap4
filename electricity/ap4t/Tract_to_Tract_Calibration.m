%% Tract-to-Tract Averaged to County-to-County
Cal_Vector = zeros(1,3108); % template for county-to-county impacts
% Mean impact of county's tracts on U.S. tracts
mean_s = mean(Tract_to_Tract{index,1}); 
C = height(AP4_County_List);  % C counties
for n = 1:C
    cols = AP4_Tract_List.id(AP4_Tract_List.ap4 == n,:);
    % Mean impact of county's tracts on U.S. counties
    mean_sr = mean(mean_s(1,cols));
    % County-to-county impacts
    Cal_Vector(1,n) = mean_sr;
end

%% Calibration Coefficient Optimization
% Minimize mean fractional error of county average of tract-level
% ambient PM2.5 from AP4 county-level

% PMP
Cnty_MCs = Cnty_MC{1,3}(index,:); % AP4 county-level
MFE = @(x)mean(abs(Cnty_MCs - x.*Cal_Vector)./((Cnty_MCs + x.*Cal_Vector)./2));
x = fminbnd(MFE,0,10);
Cal_PMP = x;

% VOC
Cnty_MCs = Cnty_MC{1,5}(index,:); % AP4 county-level
MFE = @(x)mean(abs(Cnty_MCs - x.*Cal_Vector)./((Cnty_MCs + x.*Cal_Vector)./2));
x = fminbnd(MFE,0,10);
Cal_VOC = x;
 
%% end of script.