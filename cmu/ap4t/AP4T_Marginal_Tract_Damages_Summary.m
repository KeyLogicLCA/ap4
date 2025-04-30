%% This script summarizes results from the AP4T model
% Summary matrix to store national average
MD_Summary_Matrix = zeros(4,5);

%% National average from wildland fire ground level sources
% Use wildland fire emissions for weights
b = 1;
MD_Summary_Matrix(b,3) = sum(MD_Fire(:,1).*AP4_Emissions{5,1}(:,3))/sum(AP4_Emissions{5,1}(:,3))/1000;
MD_Summary_Matrix(b,5) = sum(MD_Fire(:,2).*AP4_Emissions{5,1}(:,5))/sum(AP4_Emissions{5,1}(:,5))/1000;

%% end of script.