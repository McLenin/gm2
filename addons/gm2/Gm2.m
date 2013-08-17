
BeginPackage["Gm2`", {"SARAH`", "TextFormatting`", "CConversion`", "WriteOut`"}];

MakeGm2::usage="Calculates g-2 and converts it to C++ code";

Print["*****************************************************"];
Print["G-2 addon version 0.0 for FlexibleSUSY ",
      Get[FileNameJoin[{Global`$flexiblesusyConfigDir,"version"}]]];
Print["*****************************************************"];
Print[""];

Begin["Private`"];

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
           gm2oneLoop = 0;
           gm2twoLoop = 0;

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
