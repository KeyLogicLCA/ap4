% tractOutputF1.m
% Write to CSV file marginal concentrations per short ton of source pollutant.
% Redesigned to allow the removal of redundant F2 function.
% Args:
% - fc (1x1 doulbe), FIPS code
% - b (1x1 double), index for bin level
% - p (1x1 double), index for pollutant
% - d (char), model designation
%   (e.g., 'MC' for marginal concentration, 'MM' for marginal mortality)
% - out_dir (char), output directory path
% - data, results data matrix
% - cf, metric ton to short ton conversion factor
% - to_zip, (boolean), whether to save output file as gzip
function tractOutputF1(fc, b, p, d, out_dir, data, cf, to_zip)
    ap4_bins = cell(1,2);
    ap4_bins{1,1} = 'Ground';
    ap4_bins{1,2} = 'Point';

    ap4_pollutes = cell(1,5);
    ap4_pollutes{1,1} = 'NH3';
    ap4_pollutes{1,2} = 'NOx';
    ap4_pollutes{1,3} = 'PMP';
    ap4_pollutes{1,4} = 'SO2';
    ap4_pollutes{1,5} = 'VOC';

    out_file = [out_dir 'AP4_Tract_' ap4_bins{1,b} ...
        '_' ap4_pollutes{1,p} '_' d '_' ...
        num2str(fc,'%05.f') '.csv'];

    dlmwrite(out_file, data{b,p}*cf, 'precision', 12)
    if to_zip
        gzip(out_file);
        unlink(out_file);
    endif
endfunction