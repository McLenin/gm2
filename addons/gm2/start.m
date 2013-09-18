$addonMetaDir            = FileNameJoin[{Directory[], "addons", "gm2"}];
$addonOutputDir          = FileNameJoin[{Directory[], "addons", "gm2"}];
$addonTemplateDir        = FileNameJoin[{Directory[], "addons", "gm2"}];
$flexiblesusyConfigDir   = FileNameJoin[{Directory[], "config"}];
$flexiblesusyMetaDir     = FileNameJoin[{Directory[], "meta"}];
AppendTo[$Path, $flexiblesusyMetaDir];
AppendTo[$Path, $addonMetaDir];

Needs["SARAH`"];
Needs["Gm2`", "Gm2.m"];

Model`Name = "MSSM";
FlexibleSUSY`FSModelName = Model`Name;
workingDirectory = Directory[];
Print["Current working directory: ", workingDirectory];
Print["gm2 output directory: ", $addonOutputDir];

MakeGm2[];
