
FSModelName = "Test_Model";

(* input parameters *)

MINPAR = { {1, m0},
           {2, m12},
           {3, TanBeta},
           {4, Sign[\[Mu]]},
           {5, Azero} };

DefaultParameterPoint = {
    {m0, 125},
    {m12, 500},
    {TanBeta, 10},
    {Sign[\[Mu]], 1},
    {Azero, 0}
};

ParametersToSolveTadpoles = { B[\[Mu]], \[Mu] };

SUSYScale = Sqrt[M[Su[1]]*M[Su[6]]];

SUSYScaleFirstGuess = Sqrt[m0^2 + 4 m12^2];

SUSYScaleInput = {};

HighScale = g1 == g2;

HighScaleFirstGuess = 1.0 10^14;

HighScaleInput={
   {T[Ye], Azero*Ye},
   {T[Yd], Azero*Yd},
   {T[Yu], Azero*Yu},
   {mHd2, m0^2},
   {mHu2, m0^2},
   {mq2, UNITMATRIX[3] m0^2},
   {ml2, UNITMATRIX[3] m0^2},
   {md2, UNITMATRIX[3] m0^2},
   {mu2, UNITMATRIX[3] m0^2},
   {me2, UNITMATRIX[3] m0^2},
   {MassB, m12},
   {MassWB,m12},
   {MassG,m12}
};

LowScale = SM[MZ];

LowScaleFirstGuess = SM[MZ];

LowScaleInput={
   {vd, 2 MZDRbar / Sqrt[GUTNormalization[g1]^2 g1^2 + g2^2] Cos[ArcTan[TanBeta]]},
   {vu, 2 MZDRbar / Sqrt[GUTNormalization[g1]^2 g1^2 + g2^2] Sin[ArcTan[TanBeta]]}
};

InitialGuessAtLowScale = {
   {vd, SM[vev] Cos[ArcTan[TanBeta]]},
   {vu, SM[vev] Sin[ArcTan[TanBeta]]},
   {\[Mu]   , SM[MZ]},
   {B[\[Mu]], SM[MZ]^2}
};

InitialGuessAtHighScale = {};
