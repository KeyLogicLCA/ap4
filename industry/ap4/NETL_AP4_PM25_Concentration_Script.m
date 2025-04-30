
%% Initialize Cell Array for Emissions Vectors
% {13,5}: 13 industries, 5 pollutants.
Industrial_Source_Emissions = cell(13,5);

% NOTE: Each vector was originally initialized as zeros.
%       This produced all zero results.
%       Swapped to ones.
%       I think the units are in short tons (2000 lb).

%% 322110

Industrial_Source_Emissions{1,1} = ones(19,1);
Industrial_Source_Emissions{1,2} = ones(23,1);
Industrial_Source_Emissions{1,3} = ones(22,1);
Industrial_Source_Emissions{1,4} = ones(22,1);
Industrial_Source_Emissions{1,5} = ones(22,1);

NH3(:,1)    = (Industrial_Source_Emissions{1,1}(:,1)'*NAICS_322110{1,1});
HNO3(:,1)   = (Industrial_Source_Emissions{1,2}(:,1)'*NAICS_322110{2,1});
PMP(:,1)    = (Industrial_Source_Emissions{1,3}(:,1)'*NAICS_322110{3,1});
SO4(:,1)    = (Industrial_Source_Emissions{1,4}(:,1)'*NAICS_322110{4,1});
VOC(:,1)    = (Industrial_Source_Emissions{1,5}(:,1)'*NAICS_322110{5,1});


%% 322120

Industrial_Source_Emissions{13,1} = ones(81,1);
Industrial_Source_Emissions{13,2} = ones(117,1);
Industrial_Source_Emissions{13,3} = ones(114,1);
Industrial_Source_Emissions{13,4} = ones(106,1);
Industrial_Source_Emissions{13,5} = ones(120,1);

NH3(:,13)    = (Industrial_Source_Emissions{13,1}(:,1)'*NAICS_3221201{1,1});
HNO3(:,13)   = (Industrial_Source_Emissions{13,2}(:,1)'*NAICS_3221201{2,1});
PMP(:,13)    = (Industrial_Source_Emissions{13,3}(:,1)'*NAICS_3221201{3,1});
SO4(:,13)    = (Industrial_Source_Emissions{13,4}(:,1)'*NAICS_3221201{4,1});
VOC(:,13)    = (Industrial_Source_Emissions{13,5}(:,1)'*NAICS_3221201{5,1});

%% 322130

Industrial_Source_Emissions{2,1} = ones(46,1);
Industrial_Source_Emissions{2,2} = ones(59,1);
Industrial_Source_Emissions{2,3} = ones(56,1);
Industrial_Source_Emissions{2,4} = ones(56,1);
Industrial_Source_Emissions{2,5} = ones(63,1);

NH3(:,2)    = (Industrial_Source_Emissions{2,1}(:,1)'*NAICS_322130{1,1});
HNO3(:,2)   = (Industrial_Source_Emissions{2,2}(:,1)'*NAICS_322130{2,1});
PMP(:,2)    = (Industrial_Source_Emissions{2,3}(:,1)'*NAICS_322130{3,1});
SO4(:,2)    = (Industrial_Source_Emissions{2,4}(:,1)'*NAICS_322130{4,1});
VOC(:,2)    = (Industrial_Source_Emissions{2,5}(:,1)'*NAICS_322130{5,1});

%% 322120

Industrial_Source_Emissions{3,1} = ones(41,1);
Industrial_Source_Emissions{3,2} = ones(51,1);
Industrial_Source_Emissions{3,3} = ones(51,1);
Industrial_Source_Emissions{3,4} = ones(50,1);
Industrial_Source_Emissions{3,5} = ones(55,1);

NH3(:,3)    = (Industrial_Source_Emissions{3,1}(:,1)'*NAICS_325120{1,1});
HNO3(:,3)   = (Industrial_Source_Emissions{3,2}(:,1)'*NAICS_325120{2,1});
PMP(:,3)    = (Industrial_Source_Emissions{3,3}(:,1)'*NAICS_325120{3,1});
SO4(:,3)    = (Industrial_Source_Emissions{3,4}(:,1)'*NAICS_325120{4,1});
VOC(:,3)    = (Industrial_Source_Emissions{3,5}(:,1)'*NAICS_325120{5,1});

%% 322180

Industrial_Source_Emissions{4,1} = ones(71,1);
Industrial_Source_Emissions{4,2} = ones(134,1);
Industrial_Source_Emissions{4,3} = ones(144,1);
Industrial_Source_Emissions{4,4} = ones(134,1);
Industrial_Source_Emissions{4,5} = ones(137,1);

NH3(:,4)    = (Industrial_Source_Emissions{4,1}(:,1)'*NAICS_325180{1,1});
HNO3(:,4)   = (Industrial_Source_Emissions{4,2}(:,1)'*NAICS_325180{2,1});
PMP(:,4)    = (Industrial_Source_Emissions{4,3}(:,1)'*NAICS_325180{3,1});
SO4(:,4)    = (Industrial_Source_Emissions{4,4}(:,1)'*NAICS_325180{4,1});
VOC(:,4)    = (Industrial_Source_Emissions{4,5}(:,1)'*NAICS_325180{5,1});

%% 325193

Industrial_Source_Emissions{5,1} = ones(91,1);
Industrial_Source_Emissions{5,2} = ones(137,1);
Industrial_Source_Emissions{5,3} = ones(137,1);
Industrial_Source_Emissions{5,4} = ones(128,1);
Industrial_Source_Emissions{5,5} = ones(138,1);

NH3(:,5)    = (Industrial_Source_Emissions{5,1}(:,1)'*NAICS_325193{1,1});
HNO3(:,5)   = (Industrial_Source_Emissions{5,2}(:,1)'*NAICS_325193{2,1});
PMP(:,5)    = (Industrial_Source_Emissions{5,3}(:,1)'*NAICS_325193{3,1});
SO4(:,5)    = (Industrial_Source_Emissions{5,4}(:,1)'*NAICS_325193{4,1});
VOC(:,5)    = (Industrial_Source_Emissions{5,5}(:,1)'*NAICS_325193{5,1});

%% 325311

Industrial_Source_Emissions{6,1} = ones(44,1);
Industrial_Source_Emissions{6,2} = ones(36,1);
Industrial_Source_Emissions{6,3} = ones(36,1);
Industrial_Source_Emissions{6,4} = ones(33,1);
Industrial_Source_Emissions{6,5} = ones(33,1);

NH3(:,6)    = (Industrial_Source_Emissions{6,1}(:,1)'*NAICS_325311{1,1});
HNO3(:,6)   = (Industrial_Source_Emissions{6,2}(:,1)'*NAICS_325311{2,1});
PMP(:,6)    = (Industrial_Source_Emissions{6,3}(:,1)'*NAICS_325311{3,1});
SO4(:,6)    = (Industrial_Source_Emissions{6,4}(:,1)'*NAICS_325311{4,1});
VOC(:,6)    = (Industrial_Source_Emissions{6,5}(:,1)'*NAICS_325311{5,1});

%% 327310

Industrial_Source_Emissions{7,1} = ones(67,1);
Industrial_Source_Emissions{7,2} = ones(81,1);
Industrial_Source_Emissions{7,3} = ones(89,1);
Industrial_Source_Emissions{7,4} = ones(81,1);
Industrial_Source_Emissions{7,5} = ones(80,1);

NH3(:,7)    = (Industrial_Source_Emissions{7,1}(:,1)'*NAICS_327310{1,1});
HNO3(:,7)   = (Industrial_Source_Emissions{7,2}(:,1)'*NAICS_327310{2,1});
PMP(:,7)    = (Industrial_Source_Emissions{7,3}(:,1)'*NAICS_327310{3,1});
SO4(:,7)    = (Industrial_Source_Emissions{7,4}(:,1)'*NAICS_327310{4,1});
VOC(:,7)    = (Industrial_Source_Emissions{7,5}(:,1)'*NAICS_327310{5,1});

%% 331110

Industrial_Source_Emissions{8,1} = ones(68,1);
Industrial_Source_Emissions{8,2} = ones(111,1);
Industrial_Source_Emissions{8,3} = ones(117,1);
Industrial_Source_Emissions{8,4} = ones(111,1);
Industrial_Source_Emissions{8,5} = ones(110,1);

NH3(:,8)    = (Industrial_Source_Emissions{8,1}(:,1)'*NAICS_331110{1,1});
HNO3(:,8)   = (Industrial_Source_Emissions{8,2}(:,1)'*NAICS_331110{2,1});
PMP(:,8)    = (Industrial_Source_Emissions{8,3}(:,1)'*NAICS_331110{3,1});
SO4(:,8)    = (Industrial_Source_Emissions{8,4}(:,1)'*NAICS_331110{4,1});
VOC(:,8)    = (Industrial_Source_Emissions{8,5}(:,1)'*NAICS_331110{5,1});

%% 331511

Industrial_Source_Emissions{9,1} = ones(47,1);
Industrial_Source_Emissions{9,2} = ones(108,1);
Industrial_Source_Emissions{9,3} = ones(143,1);
Industrial_Source_Emissions{9,4} = ones(99,1);
Industrial_Source_Emissions{9,5} = ones(131,1);

NH3(:,9)    = (Industrial_Source_Emissions{9,1}(:,1)'*NAICS_331511{1,1});
HNO3(:,9)   = (Industrial_Source_Emissions{9,2}(:,1)'*NAICS_331511{2,1});
PMP(:,9)    = (Industrial_Source_Emissions{9,3}(:,1)'*NAICS_331511{3,1});
SO4(:,9)    = (Industrial_Source_Emissions{9,4}(:,1)'*NAICS_331511{4,1});
VOC(:,9)    = (Industrial_Source_Emissions{9,5}(:,1)'*NAICS_331511{5,1});

%% 331512

Industrial_Source_Emissions{10,1} = ones(2,1);
Industrial_Source_Emissions{10,2} = ones(4,1);
Industrial_Source_Emissions{10,3} = ones(4,1);
Industrial_Source_Emissions{10,4} = ones(3,1);
Industrial_Source_Emissions{10,5} = ones(3,1);

NH3(:,10)    = (Industrial_Source_Emissions{10,1}(:,1)'*NAICS_331512{1,1});
HNO3(:,10)   = (Industrial_Source_Emissions{10,2}(:,1)'*NAICS_331512{2,1});
PMP(:,10)    = (Industrial_Source_Emissions{10,3}(:,1)'*NAICS_331512{3,1});
SO4(:,10)    = (Industrial_Source_Emissions{10,4}(:,1)'*NAICS_331512{4,1});
VOC(:,10)    = (Industrial_Source_Emissions{10,5}(:,1)'*NAICS_331512{5,1});

%% 331513

Industrial_Source_Emissions{11,1} = ones(12,1);
Industrial_Source_Emissions{11,2} = ones(36,1);
Industrial_Source_Emissions{11,3} = ones(43,1);
Industrial_Source_Emissions{11,4} = ones(31,1);
Industrial_Source_Emissions{11,5} = ones(41,1);

NH3(:,11)    = (Industrial_Source_Emissions{11,1}(:,1)'*NAICS_331513{1,1});
HNO3(:,11)   = (Industrial_Source_Emissions{11,2}(:,1)'*NAICS_331513{2,1});
PMP(:,11)    = (Industrial_Source_Emissions{11,3}(:,1)'*NAICS_331513{3,1});
SO4(:,11)    = (Industrial_Source_Emissions{11,4}(:,1)'*NAICS_331513{4,1});
VOC(:,11)    = (Industrial_Source_Emissions{11,5}(:,1)'*NAICS_331513{5,1});

%% Natural Gas

Industrial_Source_Emissions{12,1} = ones(41,1);
Industrial_Source_Emissions{12,2} = ones(239,1);
Industrial_Source_Emissions{12,3} = ones(238,1);
Industrial_Source_Emissions{12,4} = ones(224,1);
Industrial_Source_Emissions{12,5} = ones(244,1);

NH3(:,12)    = (Industrial_Source_Emissions{12,1}(:,1)'*NAICS_NG{1,1});
HNO3(:,12)   = (Industrial_Source_Emissions{12,2}(:,1)'*NAICS_NG{2,1});
PMP(:,12)    = (Industrial_Source_Emissions{12,3}(:,1)'*NAICS_NG{3,1});
SO4(:,12)    = (Industrial_Source_Emissions{12,4}(:,1)'*NAICS_NG{4,1});
VOC(:,12)    = (Industrial_Source_Emissions{12,5}(:,1)'*NAICS_NG{5,1});

%% Assemble Industrial Concentration COntributions

NH3_Industrial = (NH3(:,1)+NH3(:,2)+NH3(:,3)+NH3(:,4)+NH3(:,5)+NH3(:,6)+NH3(:,7)+NH3(:,8)+NH3(:,9)+NH3(:,10)+NH3(:,11)+NH3(:,12)+NH3(:,13));
VOC_Industrial = (VOC(:,1)+VOC(:,2)+VOC(:,3)+VOC(:,4)+VOC(:,5)+VOC(:,6)+VOC(:,7)+VOC(:,8)+VOC(:,9)+VOC(:,10)+VOC(:,11)+VOC(:,12)+VOC(:,13));
SO4_Industrial = (SO4(:,1)+SO4(:,2)+SO4(:,3)+SO4(:,4)+SO4(:,5)+SO4(:,6)+SO4(:,7)+SO4(:,8)+SO4(:,9)+SO4(:,10)+SO4(:,11)+SO4(:,12)+SO4(:,13));
HNO3_Industrial = (HNO3(:,1)+HNO3(:,2)+HNO3(:,3)+HNO3(:,4)+HNO3(:,5)+HNO3(:,6)+HNO3(:,7)+HNO3(:,8)+HNO3(:,9)+HNO3(:,10)+HNO3(:,11)+HNO3(:,12)+HNO3(:,13));
PMP_Industrial = (PMP(:,1)+PMP(:,2)+PMP(:,3)+PMP(:,4)+PMP(:,5)+PMP(:,6)+PMP(:,7)+PMP(:,8)+PMP(:,9)+PMP(:,10)+PMP(:,11)+PMP(:,12)+PMP(:,13));

%% Run AP4 Chemistry Module

run NETL_AP4_Nitrate_Sulfate_Ammonium_Update
