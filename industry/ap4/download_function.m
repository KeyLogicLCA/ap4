% downloading function
function download_function(resource_id, api_key, local_filename, info_dir)

  save_path = fullfile(info_dir, local_filename);
  url = sprintf("https://edx.netl.doe.gov/resource/%s/download", resource_id);
  cmd = sprintf('curl -L -H "EDX-API-Key: %s" "%s" -o "%s"', api_key, url, save_path);

  if (exist(save_path, 'file'))
    printf("The file '%s' exists.\n", filename);
  else
    [status, result] = system(cmd);
    printf("Saving to: %s\n", save_path);
    if (status == 0)
      printf("Downloaded resource %s to %s\n", resource_id, save_path);
    else
      fprintf(stderr, "Failed to download %s: %s\n", resource_id, result);
    end
  end
  % end of file existence check
end

% NOTE: not exactly sure what happens if the file already exists. can add a line to fix that
%testing a single value
%curl -H api_key https://edx.netl.doe.gov/resource/YOUR_RESOURCE_ID/download -o output_file.dat
%[status, result] = system('curl -H api_key https://edx.netl.doe.gov/resource/97d6786c-f16f-4aee-964d-aec71a0fcfc2/download -o output_file.dat');

