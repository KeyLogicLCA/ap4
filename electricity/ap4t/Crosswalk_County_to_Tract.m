%% County-to-tract interpolation
%
% CHANGELOG
% - swap height for size for AP4_Tract_List
% - remove distribute (no need to create new storage)
% - preallocate memory for DataBase_MC; reduces runtime from 6 hr to <6 min

%% Tract-level matrix creation
t = size(AP4_Tract_List, 1);
num_b1 = size(Cnty_MC{1,1}, 1);
num_b2 = size(Cnty_MC{2,1}, 1);
num_b3 = size(Cnty_MC{3,1}, 1);
num_b = [num_b1 num_b2 num_b3];

% Initialize the database for holding all this data
[m, n] = size(DataBase_MC);
for a=1:m
    for b=1:n
        DataBase_MC{a, b} = zeros(num_b(1, a), t);
    endfor
endfor
clearvars m n a b num_b1 num_b2 num_b3 num_b

for r = 1:t
    % Progress bar
    fprintf('Crosswalk: %3.3f\r', 100*r/t)

    % Selected counties for interpolation
    counties = idw(idw(:,1) == r, 2)';

    % Inverse distance weights
    weights = idw(idw(:,1) == r, 3)';

    % Tract-level matrix buildout
    % notably skips ground-level PM2.5 (1,3) and ground-level VOC (1,5)
    b = 1;
    DataBase_MC{b,1}(:,r) = sum(Cnty_MC{b,1}(:,counties).*weights,2);
    DataBase_MC{b,2}(:,r) = sum(Cnty_MC{b,2}(:,counties).*weights,2);
    DataBase_MC{b,4}(:,r) = sum(Cnty_MC{b,4}(:,counties).*weights,2);
    b = 2;
    DataBase_MC{b,1}(:,r) = sum(Cnty_MC{b,1}(:,counties).*weights,2);
    DataBase_MC{b,2}(:,r) = sum(Cnty_MC{b,2}(:,counties).*weights,2);
    DataBase_MC{b,3}(:,r) = sum(Cnty_MC{b,3}(:,counties).*weights,2);
    DataBase_MC{b,4}(:,r) = sum(Cnty_MC{b,4}(:,counties).*weights,2);
    DataBase_MC{b,5}(:,r) = sum(Cnty_MC{b,5}(:,counties).*weights,2);
    b = 3;
    DataBase_MC{b,1}(:,r) = sum(Cnty_MC{b,1}(:,counties).*weights,2);
    DataBase_MC{b,2}(:,r) = sum(Cnty_MC{b,2}(:,counties).*weights,2);
    DataBase_MC{b,3}(:,r) = sum(Cnty_MC{b,3}(:,counties).*weights,2);
    DataBase_MC{b,4}(:,r) = sum(Cnty_MC{b,4}(:,counties).*weights,2);
    DataBase_MC{b,5}(:,r) = sum(Cnty_MC{b,5}(:,counties).*weights,2);
endfor
fprintf('Crosswalk: %3.3f\n', 100*r/t);
clearvars counties weights b r t

%% end of script.