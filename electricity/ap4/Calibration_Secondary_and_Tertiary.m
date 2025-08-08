
%% Primary PM2.5 Secondary/Tertiary Calibration

% Secondary Calibration: adjusts 5th percentile of counties, for which EPA
% AQS monitor pollution data are available, with the greatest absolute
% differences between modeled and monitored data

% Tertiary Calibration: adjusts counties adjacent to overpredicted and
% underpredicted counties addressed by the secondary calibration

PM25_Cal_base = PM25_Cal_base .* ones(1, 3108);

%% Secondary Calibration (38 Counties)
% Factor selected to minimize MFE between modeled and monitored data

% 2.5th Percentile: Overpredicted (15 Counties)
for i = [139 154 167 206 837 1035 1564 1825 2189 2194 2200 2925 ...
        2946 2989 3026]

    PM25_Cal_base(:, i) = PM25_Cal_base(:, i) .* 0.020;

end

% 2.5th - 5th Percentile: Overpredicted (11 Counties)
for i = [185 211 307 1488 1728 1818 2176 2183 2208 2922 2924]

    PM25_Cal_base(:, i) = PM25_Cal_base(:, i) .* 0.245;

end

% 2.5th Percentile: Underpredicted (4 Counties)
for i = [210 547 1591 1609]

    PM25_Cal_base(:, i) = PM25_Cal_base(:, i) .* 5.25;

end

% 2.5th - 5th Percentile: Overpredicted (8 Counties)
for i = [170 522 557 559 1611 2187 2190 2943]

    PM25_Cal_base(:, i) = PM25_Cal_base(:, i) .* 3.88;

end

%% Tertiary Calibration (165 Counties)
% Factor selected to minimize MFE between modeled and monitored data of
% counties adjacent to secondary calibration-adjusted counties; all adjacent
% counties (including those without monitors) are adjusted by the optimal
% factor

% Adjacent to overpredicted in the East (54 counties)
for i = [2 27 86 99 113 126 131 137 146 149 348 621 642 643 771 778 ...
        825 984 992 993 999 1014 1016 1061 1471 1478 1479 1504 1533 ...
        1545 1561 1742 1749 1797 1818 1825 1835 1837 2098 2137 2142 ...
        2236 2240 2983 2997 3004 3010 3024 3027 3036 3038 3041 3067 3070]

    PM25_Cal_base(:, i) = PM25_Cal_base(:, i) .* 0.735;

end

% Adjacent to overpredicted in the West (61 counties)
for i = [164 167 171 172 173 174 175 177 178 181 182 183 184 185 186 ...
        188 192 203 205 206 211 214 1714 1723 1726 1727 1730 2176 2177 ...
        2178 2179 2184 2187 2188 2190 2191 2192 2194 2195 2199 2200 ...
        2201 2203 2204 2208 2210 2925 2927 2930 2935 2936 2937 2938 ...
        2939 2940 2942 2947 2949 2953 2955 2958]

    PM25_Cal_base(:, i) = PM25_Cal_base(:, i) .* 0.886;

end

% Adjacent to underpredicted (50 counties)
for i = [74 82 169 190 194 202 209 522 526 528 529 533 534 535 536 537 ...
        541 542 544 545 546 554 557 560 1565 1576 1579 1586 1588 1591 ...
        1593 1595 1596 1605 1609 1717 1728 2186 2197 2198 2207 2209 ...
        2923 2928 2929 2941 2948 2951 2956 2957]

    PM25_Cal_base(:, i) = PM25_Cal_base(:, i) .* 1.44;

end

clear i
%% end of script.