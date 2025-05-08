% tractOutputF3
% Args:
% - ft (char), title
% - p (1x1 double), pollutant index
% - d (char), model designation
%   (e.g., 'MC' for marginal concentration, 'MM' for marginal mortality)
% - out_dir (char), output directory path
% - data, marginal results matrix
% - cf (1x1 double), metric ton to short on conversion factor
% - to_zip, (boolean), whether to save output file as gzip
function tractOutputF3(ft, p, d, out_dir, data, cf, to_zip)
    ap4_pollutes = cell(1,5);
    ap4_pollutes{1,1} = 'NH3';
    ap4_pollutes{1,2} = 'NOx';
    ap4_pollutes{1,3} = 'PMP';
    ap4_pollutes{1,4} = 'SO2';
    ap4_pollutes{1,5} = 'VOC';
    pollutant = ap4_pollutes{1, p};

    out_file = [out_dir 'AP4_Tract_EGU_' pollutant '_' d '_' ft '.csv'];
    dlmwrite(out_file, data{1,p}*cf, 'precision', 12);
    if to_zip
        gzip(out_file);
        unlink(out_file);
    endif
endfunction