% NEW
function download_resource(resource_id, api_key, local_filename)
  """
  Downloads a resource from the edX API to a local file.

  Args:
    resource_id: The ID of the resource to download.
    api_key: Your EDX API key.
    local_filename: The name of the file to save the downloaded content to.
  """
  url = sprintf("https://edx.netl.doe.gov/resource/%s/download", resource_id);
  options = weboptions('HeaderFields', {'EDX-API-Key', api_key});

  try
    filename = urlwrite(url, local_filename, options);
    printf("Successfully downloaded resource %s to %s\n", resource_id, filename);
  catch err
    fprintf(stderr, "Error downloading resource %s: %s\n", resource_id, err.message);
  end
end

# Read the resource IDs and resource names from CSV
info_dir = 'Info_Matrices/';
mat_dir = 'Matrices/';

info_files = dlmread([info_dir 'info_matrix.csv'], ',');
matrix_files = dlmread([mat_dir 'matrix.csv'], ',');

file_id = fopen(info_files, "r");
if (file_id == -1)
  error("Could not open file: %s", filename);
end

% Read the header row (and discard it)
header = fgetl(file_id);

% Read the data rows
% TODO: parse resource IDs and resource names
data = {};
while (!feof(file_id))
  line = fgetl(file_id);
  if (ischar(line))
    row = strsplit(line, ",");
    data = [data; row];
  end
end

fclose(file_id);

api_key = "YOUR_EDX_API_KEY"; % Replace with your actual API key

% Construct the URLs
for i = 1:rows(data)
   % Double check what's in data
   download_resource(data[0], api_key, data[1])
end
