
BeginPackage["Gm2`", {"SARAH`", "TextFormatting`", "CConversion`", "WriteOut`"}];

MakeGm2::usage="Calculates g-2 and converts it to C++ code";

F1C;
F2C;
F1N;
F2N;
MM;
EL;
ELGmu;
MCha;
MNeu;
MSf;
AAN;
AAC;
BBN;
BBC;


Print["*****************************************************"];
Print["G-2 addon version 0.0 for FlexibleSUSY ",
      Get[FileNameJoin[{Global`$flexiblesusyConfigDir,"version"}]]];
Print["*****************************************************"];
Print[""];

Begin["`Private`"];

CalculateGm2OneLoop[] :=
    Module[{result,i,m,k,x0,xpm},

           amuChipm[k_] = ELGmu^2 / EL^2 * 1 / (16Pi^2) MM^2 / MSf[1,1,2]^2
                          * (1/12 AAC F1C[xpm]  +  2 MCha[k] / 3 BBC F2C[xpm]);

           amuChi0[i_,m_] = ELGmu^2 / EL^2 * 1 / (16Pi^2) MM^2 / MSf[m,2,2]^2
                            * (- 1 / 12 AAN F1N[x0] + MNeu[i] / 3 BBN F2N[x0]);

           result = amuChipm[k_] + amuChi0[i_,m_];
           Return[result];
          ];

CalculateGm2TwoLoop[] :=
    Module[{result},
           result = 1 / (16 Pi^2)^2;
           Return[result];
          ];

WriteGm2[gm2_List, files_List] :=
    Module[{gm2Str},
           (* converting g-2 expressions to C++ r-values *)
           gm2Str = CConversion`RValueToCFormString /@ gm2;

           (* replace tokens in C++ template files *)
           WriteOut`ReplaceInFiles[files,
               { "@DateAndTime@" -> DateString[],
                 "@Author@"      -> "Robert Greifenhagen <robert.greifenhagen@tu-dresden.de>",
                 "@ModelName@"   -> FlexibleSUSY`FSModelName,
                 "@gm2_1l@"      -> gm2Str[[1]],
                 "@gm2_2l@"      -> gm2Str[[2]]
               } ];
          ];

MakeGm2[] :=
    Module[{gm2oneLoop, gm2twoLoop},
           Print["---------------"];
           Print["Calculating g-2"];
           Print["---------------"];
           (* calculation comes here *)
           gm2oneLoop = CalculateGm2OneLoop[];
           gm2twoLoop = CalculateGm2TwoLoop[];

           Print["------------------------"];
           Print["Creating C++ source code"];
           Print["------------------------"];

           WriteGm2[{gm2oneLoop, gm2twoLoop},
                    {{FileNameJoin[{Global`$addonTemplateDir, "gm2.hpp.in"}],
                      FileNameJoin[{Global`$addonOutputDir  , "gm2.hpp"}]},
                     {FileNameJoin[{Global`$addonTemplateDir, "gm2.cpp.in"}],
                      FileNameJoin[{Global`$addonOutputDir  , "gm2.cpp"}]},
                     {FileNameJoin[{Global`$addonTemplateDir, "gm2_1loop.hpp.in"}],
                      FileNameJoin[{Global`$addonOutputDir  , "gm2_1loop.hpp"}]},
                     {FileNameJoin[{Global`$addonTemplateDir, "gm2_1loop.cpp.in"}],
                      FileNameJoin[{Global`$addonOutputDir  , "gm2_1loop.cpp"}]},
                     {FileNameJoin[{Global`$addonTemplateDir, "gm2_2loop.hpp.in"}],
                      FileNameJoin[{Global`$addonOutputDir  , "gm2_2loop.hpp"}]},
                     {FileNameJoin[{Global`$addonTemplateDir, "gm2_2loop.cpp.in"}],
                      FileNameJoin[{Global`$addonOutputDir  , "gm2_2loop.cpp"}]},
                     {FileNameJoin[{Global`$addonTemplateDir, "MSSM_gm2_wrapper.cpp.in"}],
                      FileNameJoin[{Global`$addonOutputDir  , "MSSM_gm2_wrapper.cpp"}]},
                     {FileNameJoin[{Global`$addonTemplateDir, "MSSM_gm2_wrapper.hpp.in"}],
                      FileNameJoin[{Global`$addonOutputDir  , "MSSM_gm2_wrapper.hpp"}]},
                     {FileNameJoin[{Global`$addonTemplateDir, "test_gm2_1loop.cpp.in"}],
                      FileNameJoin[{Global`$addonOutputDir  , "test_gm2_1loop.cpp"}]},
                     {FileNameJoin[{Global`$addonTemplateDir, "test_gm2_1loop.hpp.in"}],
                      FileNameJoin[{Global`$addonOutputDir  , "test_gm2_1loop.hpp"}]}
                    }];

           Print["------------"];
           Print["g-2 finished"];
           Print["------------"];
          ];

End[];

EndPackage[];
