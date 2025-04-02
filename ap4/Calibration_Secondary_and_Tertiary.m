
%% Primary PM2.5 Secondary/Tertiary Calibration

% Secondary Calibration: adjusts 5th percentile of counties -- for which
% EPA AQS monitor pollution data are available -- with the greatest
% absolute difference between modeled and monitored data

% Tertiary Calibration: adjusts adjacent counties to overpredicted and 
% underpredicted counties addressed by the secondary calibration

PMP_Cal_base = PMP_Cal_base .* ones(1, 3108); 

%% Secondary Calibration (38 Counties)
% Factor selected to minimize MFE between modeled and monitored data

% 2.5th Percentile: Overpredicted (13 Counties)
for i = [139 154 167 206 837 1035 1564 1825 2194 2925 2946 2989 3026]  
    PMP_Cal_base(:, i) = PMP_Cal_base(:, i) .* 0.0606;
end

% 2.5th Percentile: Underpredicted (6 Counties)
for i = [189 210 547 1591 1609 2190] 
    PMP_Cal_base(:, i) = PMP_Cal_base(:, i) .* 4.89;
end

% 2.5th - 5th Percentile: Overpredicted (8 Counties)
for i = [185 327 1488 1728 2189 2200 2550 2924]
    PMP_Cal_base(:, i) = PMP_Cal_base(:, i) .* 0.242;
end

% 2.5th - 5th Percentile: Overpredicted (11 Counties)
for i = [80 170 199 522 557 559 1605 1611 2187 2520 2943] 
    PMP_Cal_base(:, i) = PMP_Cal_base(:, i) .* 5.31;
end

%% Tertiary Calibration (158 Counties)
% Factor selected to minimize MFE between modeled and monitored data of the
% adjacent counties with AQS data. All adjacent counties adjusted. Address
% counties in the East and West differently, due to size.

% West: Arizona, California, Colorado, Idaho, Montana, Nevada, New Mexico,
% Oregon, Utah, Washington, Wyoming

% Adjacent to overpredicted in the East (61 counties)
for i = [86 99 113 126 131 137 146 149 310 323 329 356 423 494 621 642 ...
        643 771 778 825 984 992 993 999 1014 1016 1061 1471 1478 1479 ...
        1504 1533 1545 1561 1742 1749 1797 1818 1835 2098 2137 2142 ...
        2236 2240 2532 2538 2546 2580 2709 2738 2983 2997 3004 3010 ...
        3024 3027 3036 3038 3041 3067 3070]
    PMP_Cal_base(:, i) = PMP_Cal_base(:, i) .* 0.616;
end

% Adjacent to overpredicted in the West (41 counties)
for i = [164 171 173 174 177 178 181 182 183 184 186 188 192 205 211 ...
        214 1714 1723 1726 1727 1730 2176 2177 2179 2184 2188 2191 2192 ...
        2195 2208 2927 2935 2936 2937 2938 2940 2942 2947 2949 2953 2958]
    PMP_Cal_base(:, i) = PMP_Cal_base(:, i) .* 0.977;
end

% Adjacent to underpredicted (56 counties)
% All underpredicted counties are in the West
for i = [69 74 78 82 161 169 172 190 194 197 202 209 213 215 526 528 ...
        529 533 534 535 536 537 541 542 544 545 546 554 560 1565 1576 ...
        1579 1584 1586 1588 1593 1595 1596 1717 2181 2186 2197 2198 ...
        2207 2209 2597 2734 2923 2928 2929 2932 2941 2948 2951 2956 2957]
    PMP_Cal_base(:, i) = PMP_Cal_base(:, i) .* 1.61;
end

clear i
%% end of script.