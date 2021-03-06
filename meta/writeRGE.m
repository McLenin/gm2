<< meta/Format.m

fortranAssign[lhs_, rhs_, arrays_] := ToString[
  FortranAssign[lhs, rhs /. { Im -> aimag },
    AssignOptimize -> False,
    AssignMaxSize -> Infinity,
    AssignToArray -> arrays]] <> "\n";

fortranAssign[lhs_, rhs_] := fortranAssign[lhs, rhs, {}];

splitLongLine[l_] := Block[{
    str = l, i
  },
  For[i = Floor[(StringLength[l]-6)/66], i > 0, i--,
    str = StringInsert[str, "\n     &", 66 i + 7]
  ];
  str
];

gotoStatement[nxs_] :=
  splitLongLine["        go to (" <> StringDrop[StringJoin[
      Table[ToString[i] <> ",",{i,nxs}]], -1] <> ") i+1"];

putLabel[label_, stmt_] :=
  StringReplacePart[stmt,
		    StringTake["     " <> ToString[label], -5], {1,5}];

listTogether[l_] := (PolynomialLCM @@ (Denominator@Together@#& /@ l)) l;

writeRGESubroutines[filename_, name_, params_, pdecls_, arrays_, nxs_] :=
Block[{
    deriv, stmt, i, j, labelled = False
  },
WriteString[filename,
  "C\n",
  "C  generated by\n",
  "C  writeRGESubroutines[",InputForm[filename],", ",
	    InputForm[name],", ...]\n",
  "C\n",
  "\n",
  "      double precision function dx",name,"(\n",
  "     &",params,
  "     &x,i)\n",
  pdecls,
  "      double precision x(",nxs,")\n",
  "      integer i\n",
  "\n",
  gotoStatement[nxs],
  "\n",
  "        stop 'dx'\n"];
Do[WriteString[filename,
  stmt = fortranAssign[Symbol["dx" <> name], HornerForm[dx[i]], arrays];
  putLabel[i, stmt],
  "        return\n"],
  {i,nxs}];
WriteString[filename,
  "      end function\n",
  "\n",
  "\n",
  "      subroutine ddx",name,"(\n",
  "     &",params,
  "     &x,i,ddx)\n",
  pdecls,
  "      double precision x(",nxs,"),ddx(",nxs,")\n",
  "      integer i\n",
  "\n",
  "        call zero_double_array(ddx,",nxs,")\n",
  gotoStatement[nxs],
  "\n",
  "        stop 'ddx'\n"];
Do[Do[deriv = D[dx[i],x[j]];
      If[!PossibleZeroQ[deriv], WriteString[filename,
         stmt = fortranAssign[ddx[j], HornerForm[deriv], arrays];
         If[labelled, stmt, labelled = True; putLabel[i, stmt]]]],
      {j,nxs}];
  stmt = "        return\n";
  WriteString[filename, If[labelled, stmt, putLabel[i, stmt]]];
  labelled = False, {i,nxs}];
WriteString[filename,
  "      end subroutine\n",
  "\n",
  "\n"];
];

(*
declareRGEs[rgeList_] := Block[{
    offset = 0,
    mappings,
    wilsonRules,
    dWilsonRules,
    dxSol
  },

  mappings = createMap /@ rgeList;
  wilsonRules = Prepend[mappings[[All,1]], U -> IdentityMatrix[3]];
  dWilsonRules = wilsonRules /. x -> dx;

  eqs = Thread[ComplexExpand[
      Flatten[{Re[#],Im[#]}& /@
	      Flatten[mappings[[All,1,1]] /. dWilsonRules]]] ==
	       ComplexExpand[
		   Flatten[{Re[#],Im[#]}& /@
			   Flatten[mappings[[All,2]] /. wilsonRules]]]];
];
*)

writeRGEs[filename_, name_, params_, pdecls_, rgeList_] := Block[{
    dxEqs,
    dmy, nPars,
    dx, dxSols
  },
  dxEqs = ComplexExpand[
      Flatten[{Re[#]==0,Im[#]==0}& /@
	      Flatten[rgeList[[All,2]] - (rgeList[[All,1]] /. x -> dmy)]]];
  nPars = Max[Cases[dxEqs, x[i_] :> i, Infinity]];
  dxSols = Solve[dxEqs, Table[dmy[i], {i,nPars}]];
  dx[i_] := dx[i] = (dmy[i] /. First[dxSols]);

  writeRGESubroutines[filename, name, params, pdecls, {x}, nPars];
];

(*
writeRGEs[filename_, name_, params_, pdecls_, rgeList_] := Block[{
    dxEqs,
    dmy, nPars,
    dx, dxSols
  },
  dxEqs = Thread[
      ComplexExpand[
	  Flatten[{Re[#],Im[#]}& /@ Flatten[rgeList[[All,1]] /. x -> dmy]]] ==
      ComplexExpand[
	  Flatten[{Re[#],Im[#]}& /@ Flatten[rgeList[[All,2]]]]]];
  nPars = Max[Cases[dxEqs, x[i_] :> i, Infinity]];
  dxSols = Solve[dxEqs, Table[dmy[i], {i,nPars}]];
  dx[i_] := dx[i] = (dmy[i] /. First[dxSols]);

  writeRGESubroutines[filename, name, params, pdecls, {x}, nPars];
];
*)

writeBCSubroutine[filename_, name_, params_, pdecls_, arrays_, complexVars_,
		  nxs_, BCs_] :=
Block[{
    realBCs = ComplexExpand[
	Flatten[{Re[#],Im[#]}& /@ Flatten[{BCs}]], complexVars],
    nBCs,
    pars = Table[x[i], {i,nxs}],
    mArrays = Join[arrays, {x, row}],
    derivs, BC0s, mat, labelled = False,
    stmt
  },
derivs = D[realBCs, #]& /@ pars;
BC0s = realBCs - pars.derivs;
mat = Transpose[listTogether /@
		Cases[RowReduce[Transpose[Append[derivs, BC0s]]],
		      Except[{___?PossibleZeroQ}]]];
derivs = Drop[mat, -1];
BC0s = Last[mat];
nBCs = Length[BC0s];
WriteString[filename,
  "C\n",
  "C  generated by\n",
  "C  writeBCSubroutine[",InputForm[filename],", ",InputForm[name],", ...]\n",
  "C\n",
  "\n",
  "      subroutine ",name,"(\n",
  "     &",params,
  "     &scale0,x,i,row,rhs)\n",
  pdecls,
  "      double precision scale0,x(",nxs,"),row(",nxs,"),rhs\n",
  "      integer i\n",
  "\n",
  "        call zero_double_array(row,",nxs,")\n",
  gotoStatement[nBCs],
  "\n",
  "        stop 'BC'\n"];
Do[Do[If[!PossibleZeroQ[derivs[[j,i]]], WriteString[filename,
       stmt = fortranAssign[row[j], HornerForm[derivs[[j,i]]], mArrays];
       If[labelled, stmt, labelled = True; putLabel[i, stmt]]]],
     {j,nxs}];
     WriteString[filename,
       fortranAssign[rhs, HornerForm[-BC0s[[i]]], mArrays],
       "        return\n"];
   labelled = False, {i,nBCs}];
WriteString[filename,
  "      end subroutine\n",
  "\n",
  "\n"];
];

writeBCs[filename_, params_, pdecls_, arrays_, complexVars_, BCs_] := Block[{
    nxs = Max[Cases[BCs[[All,2]], x[i_] :> i, Infinity]]
  },
  writeBCSubroutine[filename, #[[1]], params, pdecls, arrays, complexVars,
		    nxs, #[[2]]]& /@ BCs;
];

writeMCSubroutine[filename_, name_, params_, pdecls_, arrays_, complexVars_,
		  nws_, nxs_, MCs_] :=
Block[{
    realMCs = ComplexExpand[
	Flatten[{Re[#],Im[#]}& /@ Flatten[{MCs}]], complexVars],
    nMCs,
    pars = Join[Table[w[i], {i,nws}], Table[x[i], {i,nxs}]],
    npars = nws + nxs,
    mArrays = Join[arrays, {w, x, row}],
    derivs, MC0s, mat, labelled = False,
    stmt
  },
derivs = D[realMCs, #]& /@ pars;
MC0s = realMCs - pars.derivs;
mat = Transpose[listTogether /@
		Cases[RowReduce[Transpose[Append[derivs, MC0s]]],
		      Except[{___?PossibleZeroQ}]]];
derivs = Drop[mat, -1];
MC0s = Last[mat];
nMCs = Length[MC0s];
WriteString[filename,
  "C\n",
  "C  generated by\n",
  "C  writeMCSubroutine[",InputForm[filename],", ",InputForm[name],", ...]\n",
  "C\n",
  "\n",
  "      subroutine ",name,"(\n",
  "     &",params,
  "     &scale0,w,x,i,row,rhs)\n",
  pdecls,
  "      double precision scale0,w(",nws,"),x(",nxs,"),row(",npars,"),rhs\n",
  "      integer i\n",
  "\n",
  "        call zero_double_array(row,",npars,")\n",
  gotoStatement[nMCs],
  "\n",
  "        stop 'MC'\n"];
Do[Do[If[!PossibleZeroQ[derivs[[j,i]]], WriteString[filename,
       stmt = fortranAssign[row[j], HornerForm[derivs[[j,i]]], mArrays];
       If[labelled, stmt, labelled = True; putLabel[i, stmt]]]],
     {j,npars}];
     WriteString[filename,
       fortranAssign[rhs, HornerForm[-MC0s[[i]]], mArrays],
       "        return\n"];
   labelled = False, {i,nMCs}];
WriteString[filename,
  "      end subroutine\n",
  "\n",
  "\n"];
];

writeMCs[filename_, params_, pdecls_, arrays_, cplxVars_, MCs_, otherVars_] :=
Block[{
    variables = Join[MCs[[All,2]],otherVars],
    nws, nxs
  },
  nws = Max[Cases[variables, w[i_] :> i, Infinity]];
  nxs = Max[Cases[variables, x[i_] :> i, Infinity]];
  writeMCSubroutine[filename, #[[1]], params, pdecls, arrays, cplxVars,
		    nws, nxs, #[[2]]]& /@ MCs;
];


mapVarsOfType[real[v__]] := With[{
    par = x[++offset]
  },
  Sow[Hold[#]];
  # := par]& /@ {v};

mapVarsOfType[comp[v__]] := With[{
    par = x[offset+1] + I x[offset+2]
  },
  offset += 2;
  Sow[Hold[#]];
  # := par]& /@ {v};

mapVarsOfType[rmat[nr_,nc_,v__]] := With[{
    par = Table[x[offset + nc(i-1)+j], {i,nr}, {j,nr}]
  },
  offset += nc nr;
  Sow[Hold[#]];
  # := par]& /@ {v};

mapVarsOfType[cmat[nr_,nc_,v__]] := With[{
    par = Table[x[offset + 2(nc(i-1)+j)-1] + I x[offset + 2(nc(i-1)+j)],
		{i,nr}, {j,nc}]
  },
  offset += 2 nc nr;
  Sow[Hold[#]];
  # := par]& /@ {v};

mapVarsOfType[hmat[nr_,v__]] := With[{
    par = Table[If[i > j, x[offset + (i-1)i/2+j], x[offset + (j-1)j/2+i]],
		{i,nr}, {j,nr}] +
	  Table[Which[i===j, 0,
		      i > j, x[offset + (i-2)(i-1)/2+j+nr(nr+1)/2],
		      i < j,-x[offset + (j-2)(j-1)/2+i+nr(nr+1)/2]],
		{i,nr}, {j,nr}] I
  },
  offset += nr^2;
  Sow[Hold[#]];
  # := par]& /@ {v};

SetAttributes[mapVars, HoldAll];

mapVars[varList_] := Block[{
    offset = 0
  },
  If[ValueQ[mappedVars], mappedVars /. Hold -> Clear];
  mappedVars = Reap[mapVarsOfType /@ Unevaluated[varList]][[2,1]]
];

isReal[rep_] := Cases[rep, Complex[_,_], {0, Infinity}] === {};

typeString[True] := "double";
typeString[False] := "std::complex<double>";

cString[ex_] := ToString[CForm[ex /. x[i_] :> u[i-1] y[i-1]]];

getStatement[ex_?isReal, _] := "return " <> cString[ex] <> ";";

getStatement[ex_, nl_] := Block[{re, im},
  {re, im} = ComplexExpand[{Re[ex],Im[ex]}];
  "return std::complex<double>" <> nl <>
  "(" <> cString[re] <> ", " <> cString[im] <> ");"];

getStatement[ex_] := getStatement[ex, ""];

setPartStatement[ex_, input_] := Block[{
    exy = ex /. x[i_] :> u[i-1] y[i-1],
    vars, var, sol
  },
  vars = Cases[exy, y[_], {0, Infinity}];
  If[vars === {}, "",
     var = First[vars];
     sol = Solve[input == exy, var];
     ToString[CForm[var]] <> " = " <> ToString[CForm[sol[[1,1,2]]]] <> ";"]];

setStatement[ex_?isReal, True] := setPartStatement[ex, x];
setStatement[ex_?isReal, False] := setPartStatement[ex, real[x]];
setStatement[ex_, True] := Abort[];
setStatement[ex_, False] := Block[{re, im},
  {re, im} = ComplexExpand[{Re[ex],Im[ex]}];
  setPartStatement[re, real[x]] <> " " <>
  setPartStatement[im, imag[x]]];

SetAttributes[writeMapOf, HoldFirst];
SetAttributes[writePart, HoldFirst];
SetAttributes[writeParts, HoldFirst];
SetAttributes[writeMatrix, HoldFirst];

writeMatrix[v_, filename_, rep_] := Block[{
    reality = isReal[rep],
    type
  },
  type = typeString[reality];
WriteString[filename,
  "    Var<",type,"> ",Unevaluated[v],"(size_t i, size_t j) {\n",
  "        switch(i) {\n"];
Do[WriteString[filename,
  "        case ",i-1,":\n",
  "            switch(j) {\n"];
Do[WriteString[filename,
  "            case ",j-1,": return Var<",type,">(\n",
  "                [=]{ ",
  getStatement[rep[[i,j]],"\n                        "]," },\n",
  "                [=](",type," x)",If[reality, "", "\n                "],
  "{ ",setStatement[rep[[i,j]],reality],
  " });\n"],
  {j,Length[First[rep]]}];
WriteString[filename,
  "            default: abort();\n",
  "            }\n"],
  {i,Length[rep]}];
WriteString[filename,
  "        default: abort();\n",
  "        }\n",
  "    }\n"];
];

writeMapOf[v_, filename_, rep:{__List}] := writeMatrix[v, filename, rep];

writeMapOf[v_, filename_, rep_] := Block[{
    reality = isReal[rep],
    type
  },
  type = typeString[reality];
WriteString[filename,
  "    Var<",type,"> ",Unevaluated[v],"() { return Var<",type,">(\n",
  "        [=]{ ",getStatement[rep,"\n                "]," },\n",
  "        [=](",type," x)",If[reality, "", "\n        "],
  "{ ",setStatement[rep, reality]," });\n",
  "    }\n"]];

writeMapOf[v_, filename_] := writeMapOf[v, filename, v];

writeMaps[filename_, name_] :=
    mappedVars /. Hold[v_] :> writeMapOf[v, filename];
