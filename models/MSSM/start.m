$flexiblesusyOutputDir   = "models/MSSM";
$flexiblesusyConfigDir   = FileNameJoin[{Directory[], "config"}];
$flexiblesusyMetaDir     = FileNameJoin[{Directory[], "meta"}];
$flexiblesusyTemplateDir = FileNameJoin[{Directory[], "templates"}];
AppendTo[$Path, $flexiblesusyMetaDir];

Needs["SARAH`"];
Needs["FlexibleSUSY`", FileNameJoin[{$flexiblesusyMetaDir, "FlexibleSUSY.m"}]];

workingDirectory = Directory[];
$sarahOutputDir = FileNameJoin[{workingDirectory, "Output"}];
SARAH`SARAH[InputDirectories] = {
    ToFileName[{$sarahDir, "Models"}],
    FileNameJoin[{workingDirectory, "sarah"}]
};

Print["Current working directory: ", workingDirectory];
Print["SARAH output directory: ", $sarahOutputDir];
Print["Starting model: ", ToString[HoldForm[Start["MSSM"]]]];

Start["MSSM"];

MakeFlexibleSUSY[Eigenstates -> SARAH`EWSB,
                 InputFile -> FileNameJoin[{"models/MSSM","FlexibleSUSY.m"}],
                 DefaultDiagonalizationPrecision -> MediumPrecision,
                 HighDiagonalizationPrecision -> {hh, Ah, Hpm},
                 MediumDiagonalizationPrecision -> {},
                 LowDiagonalizationPrecision -> {},
                 EnablePoleMassThreads -> True
                ];
