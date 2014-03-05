$flexiblesusyOutputDir   = "models/Test_Model";
$flexiblesusyConfigDir   = FileNameJoin[{Directory[], "config"}];
$flexiblesusyMetaDir     = FileNameJoin[{Directory[], "meta"}];
$flexiblesusyTemplateDir = FileNameJoin[{Directory[], "templates"}];
AppendTo[$Path, $flexiblesusyMetaDir];

Needs["SARAH`"];
Needs["FlexibleSUSY`", "FlexibleSUSY.m"];

workingDirectory = Directory[];
$sarahOutputDir = FileNameJoin[{workingDirectory, "Output"}];
Print["Current working directory: ", workingDirectory];
Print["SARAH output directory: ", $sarahOutputDir];

Start["Test_Model"];

MakeFlexibleSUSY[Eigenstates -> SARAH`EWSB,
                 InputFile -> FileNameJoin[{"models/Test_Model","FlexibleSUSY.m"}],
                 softSusyCompatibleRGEs -> True,
                 defaultDiagonalizationPrecision -> MediumPrecision,
                 highPrecision -> {hh, Ah, Hpm},
                 mediumPrecision -> {},
                 lowPrecision -> {},
                 EnablePoleMassThreads -> True
                ];
