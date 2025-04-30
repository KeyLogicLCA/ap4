%% This script summarizes results from the AP4T model
% Summary matrix to store national average
MD_Summary_Matrix = zeros(4,5);

%% National average from wildland fire ground level sources
% Subtract non-fire ground emissions from total ground emissions for weights
b = 1;
MD_Summary_Matrix(b,1) = sum(MD_Ground(:,1).*(AP4_Emissions{1,1}(:,1) - AP4_Emissions{4,1}(:,1)))/sum(AP4_Emissions{1,1}(:,1) - AP4_Emissions{4,1}(:,1))/1000;
MD_Summary_Matrix(b,2) = sum(MD_Ground(:,2).*(AP4_Emissions{1,1}(:,2) - AP4_Emissions{4,1}(:,2)))/sum(AP4_Emissions{1,1}(:,2) - AP4_Emissions{4,1}(:,2))/1000;
MD_Summary_Matrix(b,4) = sum(MD_Ground(:,4).*(AP4_Emissions{1,1}(:,4) - AP4_Emissions{4,1}(:,4)))/sum(AP4_Emissions{1,1}(:,4) - AP4_Emissions{4,1}(:,4))/1000;

%% National average from non-fire ground level sources
% Use non-fire ground emissions for weights
b = 2;
MD_Summary_Matrix(b,1) = sum(MD_Ground(:,1).*AP4_Emissions{4,1}(:,1))/sum(AP4_Emissions{4,1}(:,1))/1000;
MD_Summary_Matrix(b,2) = sum(MD_Ground(:,2).*AP4_Emissions{4,1}(:,2))/sum(AP4_Emissions{4,1}(:,2))/1000;
MD_Summary_Matrix(b,3) = sum(MD_Ground(:,3).*AP4_Emissions{4,1}(:,3))/sum(AP4_Emissions{4,1}(:,3))/1000;
MD_Summary_Matrix(b,4) = sum(MD_Ground(:,4).*AP4_Emissions{4,1}(:,4))/sum(AP4_Emissions{4,1}(:,4))/1000;
MD_Summary_Matrix(b,5) = sum(MD_Ground(:,5).*(AP4_Emissions{4,1}(:,5) + AP4_Emissions{4,1}(:,6))/sum(AP4_Emissions{4,1}(:,5) + AP4_Emissions{4,1}(:,6)))/1000;

%% National average from non-EGU point sources
% Use non-EGU point emissions for weights
b = 3;
MD_Summary_Matrix(b,1) = sum(MD_Non_EGU_Point(:,1).*AP4_Emissions{2,1}(:,1))/sum(AP4_Emissions{2,1}(:,1))/1000;
MD_Summary_Matrix(b,2) = sum(MD_Non_EGU_Point(:,2).*AP4_Emissions{2,1}(:,2))/sum(AP4_Emissions{2,1}(:,2))/1000;
MD_Summary_Matrix(b,3) = sum(MD_Non_EGU_Point(:,3).*AP4_Emissions{2,1}(:,3))/sum(AP4_Emissions{2,1}(:,3))/1000;
MD_Summary_Matrix(b,4) = sum(MD_Non_EGU_Point(:,4).*AP4_Emissions{2,1}(:,4))/sum(AP4_Emissions{2,1}(:,4))/1000;
MD_Summary_Matrix(b,5) = sum(MD_Non_EGU_Point(:,5).*AP4_Emissions{2,1}(:,5))/sum(AP4_Emissions{2,1}(:,5))/1000;

%% National average from non-EGU point sources
% Use EGU point emissions for weights
b = 4;
MD_Summary_Matrix(b,1) = sum(MD_EGU_Point(:,1).*AP4_Emissions{3,1}(:,1))/sum(AP4_Emissions{3,1}(:,1))/1000;
MD_Summary_Matrix(b,2) = sum(MD_EGU_Point(:,2).*AP4_Emissions{3,1}(:,2))/sum(AP4_Emissions{3,1}(:,2))/1000;
MD_Summary_Matrix(b,3) = sum(MD_EGU_Point(:,3).*AP4_Emissions{3,1}(:,3))/sum(AP4_Emissions{3,1}(:,3))/1000;
MD_Summary_Matrix(b,4) = sum(MD_EGU_Point(:,4).*AP4_Emissions{3,1}(:,4))/sum(AP4_Emissions{3,1}(:,4))/1000;
MD_Summary_Matrix(b,5) = sum(MD_EGU_Point(:,5).*AP4_Emissions{3,1}(:,5))/sum(AP4_Emissions{3,1}(:,5))/1000;

%% end of script.