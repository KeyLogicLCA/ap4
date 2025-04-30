%% This script summarizes results from the AP4 model
% Summary matrix to store national average
MD_Summary_Matrix = zeros(3,5);

%% National average from ground level sources
% Use ground emissions for weights
b = 1;
MD_Summary_Matrix(b,1) = sum(MD_Ground(:,1).*Emissions_2017_NEI{b,1}(:,1))/sum(Emissions_2017_NEI{b,1}(:,1))/1000;
MD_Summary_Matrix(b,2) = sum(MD_Ground(:,2).*Emissions_2017_NEI{b,1}(:,2))/sum(Emissions_2017_NEI{b,1}(:,2))/1000;
MD_Summary_Matrix(b,3) = sum(MD_Ground(:,3).*Emissions_2017_NEI{b,1}(:,3))/sum(Emissions_2017_NEI{b,1}(:,3))/1000;
MD_Summary_Matrix(b,4) = sum(MD_Ground(:,4).*Emissions_2017_NEI{b,1}(:,4))/sum(Emissions_2017_NEI{b,1}(:,4))/1000;
MD_Summary_Matrix(b,5) = sum(MD_Ground(:,5).*(Emissions_2017_NEI{b,1}(:,5) + Emissions_2017_NEI{b,1}(:,6))/sum(Emissions_2017_NEI{b,1}(:,5) + Emissions_2017_NEI{b,1}(:,6)))/1000;

%% National average from non-EGU point sources
% Use non-EGU point emissions for weights
b = 2;
MD_Summary_Matrix(b,1) = sum(MD_Non_EGU_Point(:,1).*Emissions_2017_NEI{b,1}(:,1))/sum(Emissions_2017_NEI{b,1}(:,1))/1000;
MD_Summary_Matrix(b,2) = sum(MD_Non_EGU_Point(:,2).*Emissions_2017_NEI{b,1}(:,2))/sum(Emissions_2017_NEI{b,1}(:,2))/1000;
MD_Summary_Matrix(b,3) = sum(MD_Non_EGU_Point(:,3).*Emissions_2017_NEI{b,1}(:,3))/sum(Emissions_2017_NEI{b,1}(:,3))/1000;
MD_Summary_Matrix(b,4) = sum(MD_Non_EGU_Point(:,4).*Emissions_2017_NEI{b,1}(:,4))/sum(Emissions_2017_NEI{b,1}(:,4))/1000;
MD_Summary_Matrix(b,5) = sum(MD_Non_EGU_Point(:,5).*Emissions_2017_NEI{b,1}(:,5))/sum(Emissions_2017_NEI{b,1}(:,5))/1000;

%% National average from non-EGU point sources
% Use EGU point emissions for weights
b = 3;
MD_Summary_Matrix(b,1) = sum(MD_EGU_Point(:,1).*Emissions_2017_NEI{b,1}(:,1))/sum(Emissions_2017_NEI{b,1}(:,1))/1000;
MD_Summary_Matrix(b,2) = sum(MD_EGU_Point(:,2).*Emissions_2017_NEI{b,1}(:,2))/sum(Emissions_2017_NEI{b,1}(:,2))/1000;
MD_Summary_Matrix(b,3) = sum(MD_EGU_Point(:,3).*Emissions_2017_NEI{b,1}(:,3))/sum(Emissions_2017_NEI{b,1}(:,3))/1000;
MD_Summary_Matrix(b,4) = sum(MD_EGU_Point(:,4).*Emissions_2017_NEI{b,1}(:,4))/sum(Emissions_2017_NEI{b,1}(:,4))/1000;
MD_Summary_Matrix(b,5) = sum(MD_EGU_Point(:,5).*Emissions_2017_NEI{b,1}(:,5))/sum(Emissions_2017_NEI{b,1}(:,5))/1000;

%% end of script.