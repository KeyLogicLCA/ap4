%% County-to-tract interpolation
% Number of tracts
t = height(AP4_Tract_List);

%% Tract-level matrix creation

for r = 1:t  
    fprintf('county-to-tract: r %d\n', r);
    % Selected counties for interpolation
    counties = idw(idw(:,1) == r,2)';
    % Inverse distance weights
    weights = idw(idw(:,1) == r,3)';
    
    % County-level marginal concentrations
    distribute = cell(2,6);
    b = 1;
    distribute{b,1}	= Cnty_MC{b,1}(:,counties);
	distribute{b,2} = Cnty_MC{b,2}(:,counties);
	distribute{b,4}	= Cnty_MC{b,4}(:,counties);
    b = 2;
    distribute{b,1}	= Cnty_MC{b,1}(:,counties);
	distribute{b,2} = Cnty_MC{b,2}(:,counties);
	distribute{b,3} = Cnty_MC{b,3}(:,counties);
	distribute{b,4}	= Cnty_MC{b,4}(:,counties);
	distribute{b,5} = Cnty_MC{b,5}(:,counties);
    b = 3;
    distribute{b,1}	= Cnty_MC{b,1}(:,counties);
	distribute{b,2} = Cnty_MC{b,2}(:,counties);
	distribute{b,3} = Cnty_MC{b,3}(:,counties);
	distribute{b,4}	= Cnty_MC{b,4}(:,counties);
	distribute{b,5} = Cnty_MC{b,5}(:,counties);

    % Tract-level matrix buildout
    b = 1;
    DataBase_MC{b,1}(:,r)	= sum(distribute{b,1}.*weights,2); 
	DataBase_MC{b,2}(:,r)   = sum(distribute{b,2}.*weights,2); 
	DataBase_MC{b,4}(:,r) 	= sum(distribute{b,4}.*weights,2);
    b = 2;
    DataBase_MC{b,1}(:,r)	= sum(distribute{b,1}.*weights,2); 
	DataBase_MC{b,2}(:,r)	= sum(distribute{b,2}.*weights,2); 
	DataBase_MC{b,3}(:,r)	= sum(distribute{b,3}.*weights,2); 
	DataBase_MC{b,4}(:,r)	= sum(distribute{b,4}.*weights,2); 
	DataBase_MC{b,5}(:,r) 	= sum(distribute{b,5}.*weights,2);
    b = 3;
    DataBase_MC{b,1}(:,r)	= sum(distribute{b,1}.*weights,2); 
	DataBase_MC{b,2}(:,r)	= sum(distribute{b,2}.*weights,2); 
	DataBase_MC{b,3}(:,r)	= sum(distribute{b,3}.*weights,2); 
	DataBase_MC{b,4}(:,r)	= sum(distribute{b,4}.*weights,2); 
	DataBase_MC{b,5}(:,r) 	= sum(distribute{b,5}.*weights,2);
    
end

%% end of script.