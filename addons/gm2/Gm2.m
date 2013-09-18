
BeginPackage["Gm2`", {"SARAH`", "TextFormatting`", "CConversion`", "WriteOut`"}];

MakeGm2::usage="Calculates g-2 and converts it to C++ code";

F1C;
F2C;
F1N;
F2N;

Print["*****************************************************"];
Print["G-2 addon version 0.0 for FlexibleSUSY ",
      Get[FileNameJoin[{Global`$flexiblesusyConfigDir,"version"}]]];
Print["*****************************************************"];
Print[""];

Begin["`Private`"];

CalculateGm2OneLoop[] :=
    Module[{result},
           result = 1 / (16 Pi^2) ( F1C[0.5] + F2C[0.2] );
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
                 "@Author@"      -> "Max Mustermann <Max.Mustermann@gmx.de>",
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
                      FileNameJoin[{Global`$addonOutputDir  , "gm2_1loop.cpp"}]}
                    }];

           Print["------------"];
           Print["g-2 finished"];
           Print["------------"];
          ];

End[];

EndPackage[];
