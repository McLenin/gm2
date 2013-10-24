
BeginPackage["Gm2`", {"SARAH`", "TextFormatting`", "CConversion`", "WriteOut`"}];

MakeGm2::usage="Calculates g-2 and converts it to C++ code";

F1C;
F2C;
F1N;
F2N;
g2;
g1;
ymu;
VCha;
UCha;
ZNeu;
USf;
MM;
MW;
CB;
SW;
CW;
EL;
ELGmu;
MCha;
MNeu;
MSf;
i;
k;
m;



Print["*****************************************************"];
Print["G-2 addon version 0.0 for FlexibleSUSY ",
      Get[FileNameJoin[{Global`$flexiblesusyConfigDir,"version"}]]];
Print["*****************************************************"];
Print[""];

Begin["`Private`"];

CalculateGm2OneLoop[] :=
    Module[{result,cL,cR,nL,nR,ymu,g1,g2,AAC,AAN,BBC,BBN,xpm,x0},

           cL = - g2 VCha[k,1];
           cR = ymu  UCha[k,2];
           nL = 1 / Sqrt[2] ( g1 ZNeu[i,1] + g2 ZNeu[i,2] ) *
           Conjugate[ USf[2,2][m,1] ] - ymu ZNeu[i,3]  Conjugate[ USf[2,2][m,2] ];
           nR = Sqrt[2] g1 ZNeu[i,1]  USf[2,2][m,2]  + ymu ZNeu[i,3]  USf[2,2][m,1];

           ymu = MM g2 / (Sqrt[2] MW CB);
           g1  = g2 * SW/CW;
           g2  = EL / SW;

(* MyConjugate only works for exactly the expressions which appear here *)

           MyConjugate[expr_] :=expr/.{USf[ii__][jj__]->Conjugate[USf[ii][jj]],
                            ZNeu[ii__]     ->Conjugate[ZNeu[ii]],
                            VCha[ii__]     ->Conjugate[VCha[ii]],
                            UCha[ii__]     ->Conjugate[UCha[ii]]};

           AAC = MyConjugate[cL] cL + MyConjugate[cR] cR;
           AAN = MyConjugate[nL] nL + MyConjugate[nR] nR;
           BBC = (cL cR + MyConjugate[cL cR]) / ( 2 MM );
           BBN = (nL nR + MyConjugate[nL nR]) / ( 2 MM );

           xpm = MCha[k]^2 / MSf[1,1,2]^2;
           x0  = MNeu[i]^2 / MSf[m,2,2]^2;


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
