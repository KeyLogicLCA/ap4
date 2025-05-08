%% Generate population matrices
% 72,538 tracts and 19 age groups

Pop_Matrix = Population_Data{1,1};
MR_Matrix = MR_Data{1,1};

Pop_Total = zeros (R,1);
Pop_Total_Infants = zeros (R,1);
Pop_Total_Youth = zeros (R,1);
Pop_Total_Adults = zeros (R,1);
Pop_Total_Seniors = zeros (R,1);

Pop_Under1 = Pop_Matrix;
Pop_Over25 = Pop_Matrix;
Pop_Over30 = Pop_Matrix;
Pop_Over65 = Pop_Matrix;

%% Check totals
for r = 1:R
    Pop_Total(r,1) = sum(Pop_Matrix(r,:));
end
for r = 1:R
    Pop_Total_Infants(r,1) = sum(Pop_Matrix(r,1));
end
for r = 1:R
    Pop_Total_Youth(r,1) = sum(Pop_Matrix(r,2:7));
end
for r = 1:R
    Pop_Total_Adults(r,1) = sum(Pop_Matrix(r,8:14));
end
for r = 1:R
    Pop_Total_Seniors(r,1) = sum(Pop_Matrix(r,15:19));
end

%% Population matrix creation
for r = 2:19
    Pop_Under1(:,r) = zeros(R,1);
end
for r = 1:6
    Pop_Over25(:,r) = zeros(R,1);
end
for r = 1:7
    Pop_Over30(:,r) = zeros(R,1);
end
for r = 1:14
    Pop_Over65(:,r) = zeros(R,1);
end

%% Working matrices
One = ones(1,19);
One_Mat = ones(R,19);

%% end of script.