%% Read the resource IDs and resource names from CSV

% USER_INPUTS
% api_key = YOUR_EDX_API_KEY
% info_dir = YOUR_DIRECTORY % location of git files..?
% file_id = fopen([info_dir, 'info_matrix.csv'], "r");

if (isempty(strtrim(api_key)))
  api_key = input("Enter your API key (enter to skip): ", "s");
end
disp(["API Key: ", api_key]);

info_dir1 = 'AP4_Inputs/';
file_id1 = fopen([info_dir1 'edx.csv'], "r");
header = fgetl(file_id1); % Read the header row (and discard it)

% Read data rows: resource_IDs --> data1; resource_names-->data2
data1 = {};
while (!feof(file_id1))
  line1 = fgetl(file_id1);
  if (ischar(line1))
    row1 = strsplit(line1, ",");
    data1 = [data1; row1];
  end
end
fclose(file_id1); #closes open file

% Construct the CSVs
% Runs the function 'download_edx_files' - sequence of inputs:(resource_id, api_key, local_filename, info_dir)
for i = 1:rows(data1)
   download_function(data1{i,1}, api_key, data1{i,2}, info_dir1);
end

% Cleanup step
clear data1 file_id1 info_dir1 line1 row1
clear header i