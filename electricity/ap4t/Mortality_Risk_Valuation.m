%% Willingness-to-pay (WTP) for mortality risk reductions
% USEPA's default vsl           = $7.4 million (2006 USD)
% Mrozek and Taylor (2002) vsl  = $2.0 million (1998 USD)

%% Reference year valuation in 2012 USD for selected VSL
% 1 for USEPA and 2 for Mrozek and Taylor (2002)
vsl = 1;
wtp_refyear_2012usd = WTP_Info(vsl,1)*WTP_Info(vsl,2);

%% Wealth effects adjustment
% USEPA "balanced" income elasticity estimate = 0.7
% Source: https://yosemite.epa.gov/sab/sabproduct.nsf/36a1ca3f683ae57a85256ce9006a32d0/0CA9E925C9A702F285257F380050C842/$File/Income+Elasticity+Technical+Memorandum_final_2_5_16_docx.pdf
elast = 0.7;

% Reference year income to analysis year income
ref_year = WTP_Info(vsl,3);
incA = GDP_Data(GDP_Data(:,1) == ref_year,2);
incB = GDP_Data(GDP_Data(:,1) == wtp_year,2);

% Hammitt and Robinson (2011)
wtp_2012usd = wtp_refyear_2012usd*(incB/incA)^elast;

%% Inflation adjustment (July 2012 to July valuation year)
wtp = wtp_2012usd*Infl_Data(Infl_Data(:,1) == usd_year,2);
clear vsl wtp_refyear_2012usd ref_year incA incB wtp_2012usd

%% end of script.