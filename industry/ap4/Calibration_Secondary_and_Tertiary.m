
%% Primary PM2.5 Secondary/Tertiary Calibration

% Secondary Calibration: adjusts 5th percentile of counties -- for which
% EPA AQS monitor pollution data are available -- with the greatest
% absolute difference between modeled and monitored data

% Tertiary Calibration: adjusts adjacent counties to overpredicted and 
% underpredicted counties addressed by the secondary calibration

PMP_Cal_base = PMP_Cal_base .* ones(1, 3108); 
VOC_Cal_base = VOC_Cal_base .* ones(1, 3108); 


%% Secondary Calibration (38 Counties)
% Factor selected to minimize MFE between modeled and monitored data

% 2.5th Percentile: Overpredicted (13 Counties)
for i = [158  161  167  177  185  200  201  202  207   251  2176  2177  2184  2194  2196  2198  2200  2208  2925]  
    PMP_Cal_base(:, i) = PMP_Cal_base(:, i) .* 0.0557;
end

% 2.5th Percentile: Underpredicted (6 Counties)
% for i =  
%     PMP_Cal_base(:, i) = PMP_Cal_base(:, i) .* 1;
% end

% 2.5th - 5th Percentile: Overpredicted (8 Counties)
for i = [154  163  168  181  192  195  196  198  205   206   208   209   211   327   837  2179  2189  3026]
    PMP_Cal_base(:, i) = PMP_Cal_base(:, i) .* 0.3292;
end

% 2.5th - 5th Percentile: Overpredicted (11 Counties)
for i = 19
    PMP_Cal_base(:, i) = PMP_Cal_base(:, i) .* 4.4188;
end

%% Secondary Calibration (38 Counties)
% Factor selected to minimize MFE between modeled and monitored data

% 2.5th Percentile: Overpredicted (13 Counties)
for i = [158  161  167  177  185  200  201  202  207   251  2176  2177  2184  2194  2196  2198  2200  2208  2925]  
    VOC_Cal_base(:, i) = VOC_Cal_base(:, i) .* 0.5269;
end

% 2.5th Percentile: Underpredicted (6 Counties)
% for i =  
%     VOC_Cal_base(:, i) = VOC_Cal_base(:, i) .* 1;
% end

% 2.5th - 5th Percentile: Overpredicted (8 Counties)
for i = [154  163  168  181  192  195  196  198  205   206   208   209   211   327   837  2179  2189  3026]
    VOC_Cal_base(:, i) = VOC_Cal_base(:, i) .* 0.2954;
end

% 2.5th - 5th Percentile: Overpredicted (11 Counties)
for i = 19
    VOC_Cal_base(:, i) = VOC_Cal_base(:, i) .* 2.3055;
end

% % Dealing with the outlier
% % 8.8 mean of 97.5% VOC readings
% % 37.8 outlier
ratio = 8.8/37.8;
SR_Matrices_Ground{5,1}(:, 2194)= ratio.* SR_Matrices_Ground{5,1}(:, 2194);

%% Tertiary Calibration (158 Counties)
% Factor selected to minimize MFE between modeled and monitored data of the
% adjacent counties with AQS data. All adjacent counties adjusted. Address
% counties in the East and West differently, due to size.

% West: Arizona, California, Colorado, Idaho, Montana, Nevada, New Mexico,
% Oregon, Utah, Washington, Wyoming

% Adjacent to overpredicted in the East (61 counties)
for i = [86   99  126  310  323  329  356  423  494   642   771 ...
        778   825  2098  3024  3027  3036  3038  3041  3067  3070]
    PMP_Cal_base(:, i) = PMP_Cal_base(:, i) .* 1.160;
end

% Adjacent to overpredicted in the West (41 counties)
for i = [162  164  172  173  175  178  179  180  182   184   188 ...
        189   191   196   204   210   214   215   222   241   245 ...
        278  2178  2180  2182  2183  2188  2190  2191  2192  2195 ...
        2201  2203  2207  2210  2927  2949  2954  3086  3096]
    PMP_Cal_base(:, i) = PMP_Cal_base(:, i) .*  0.406;
end

% Adjacent to underpredicted (56 counties)
% All underpredicted counties are in the West
for i = [159 1716 1718 1723 1724]
    PMP_Cal_base(:, i) = PMP_Cal_base(:, i) .* 0.613;
end

clear i
%% end of script.