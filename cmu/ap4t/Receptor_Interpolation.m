%% Tract-level S-R matrix interpolation
% Applicable for NH3, NOx, & SO2 for all sources and PMP & VOCs for point
% sources

% Method / Specification:
% 1) Closest Counties (cc):
%     1.1 = 3 cc, 
%     1.2 = 5 cc,
%     1.3 = 10 cc
% 2) Counties w/in (cw):        
%     2.1 = cw 20 miles, 
%     2.2 = cw 30 miles, 
%     2.3 = cw 50 miles
% 3) Adjacent Counties (ac):	
%     3.1 = home county + ac to home county,
%     3.2 = + ac to those in 3.1,
%     3.3 = + ac to those in 3.2
% Power Parameter:
% p = 0.5 or p = 1 or p = 2

% Baseline Option:
method = 3;                 % Ajacent counties (3)
specification = 2;          % Home + 2 levels of adjacency (3.2)
power = 0.5;              	% p = 0.5
if power == 1 % Moves specification to proper location when p = 1
    specification = specification + 3;
elseif power == 2 % Moves specification to proper location when p = 2
    specification = specification + 6;
end % Otherwise does nothing
idw = AP4T_Interpolation{method,specification};

%% County-to-tract interpolation
% Number of tracts
t = height(AP4T_Tract_List);
for r = 1:t  
    fprintf('Receptor Interpolation: r = %d of %d\n', r, t);
    % Selected counties for interpolation
    counties = idw(idw(:,1) == r,2)';
    % Inverse distance weights
    weights = idw(idw(:,1) == r,3)';
    interpolation = cell(3,5); % Template for interpolation
    for b = 1:3 % Bins
        for p = 1:5 % Pollutants
            % County-level source-recepor matrices
            interpolation{b,p} = AP4_SR_Matrices{b,p}(:,counties);   
        	% Tract-level matrix buildout
            AP4T_SR_Matrices{b,p}(:,r) = sum(interpolation{b,p}.*weights,2); 
        end
    end
end

%% Clean up
clear method idw t r b p interpolation counties weights specification

%% end of script.