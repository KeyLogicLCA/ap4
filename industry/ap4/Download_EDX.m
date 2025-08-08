%% Read the resource IDs and resource names from CSV

% USER_INPUTS
% api_key = YOUR_EDX_API_KEY
% info_dir = YOUR_DIRECTORY % location of git files..?
% file_id = fopen([info_dir, 'info_matrix.csv'], "r");

%TODO
% load workspace called from AP control script-->PM2.5 base concentration-->load workspace-->call download edx
% Move API_key to control script.. give it empty string, use input fcn
%% USER_INPUT_CHANGES - Matrices

#api_key defined in NETL AP4 Control Script as empty string
if (isempty(strtrim(api_key)))
  api_key = input("Enter your API key: ", "s");
end
disp(["API Key: ", api_key]);

info_dir1 = 'Matrices/' %Location of git files... need help here??
file_id1 = fopen([info_dir1, 'matrix.csv'], "r");

#if (file_id1 == -1) <-- this isnt working for some reason... but the files seem to download fine e.g. file_id1 = 44 but code stopped
#  error("Could not open file: %s", [info_dir1, 'matrix.csv']); #updated name
#end

header = fgetl(file_id1); % Read the header row (and discard it)

% Read data rows: rescource_IDs --> data1; resource_names-->data2
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

%% USER_INPUT_CHANGES - Info_Matrices

info_dir2 = 'Info_Matrices/' %Location of git files... need help here??
file_id2 = fopen([info_dir2, 'info_matrix.csv'], "r");

header = fgetl(file_id2); % Read the header row (and discard it)

% Read data rows: prescource_IDs --> data1; resource_names-->data2
data2 = {};
while (!feof(file_id2))
  line2 = fgetl(file_id2);
  if (ischar(line2))
    row2 = strsplit(line2, ",");
    data2 = [data2; row2];
  end
end
fclose(file_id2); #closes open file

% Construct the CSVs
% sequence of inputs:(resource_id, api_key, local_filename, info_dir)
for i = 1:rows(data2)
   download_function(data2{i,1}, api_key, data2{i,2}, info_dir2);
end

% Cleanup step
clear data1 file_id1 info_dir1 line1 row1
clear data2 file_id2 info_dir2 line2 row2
clear header i