#ifndef SM_H
#define SM_H


#include "mathdefs.hpp"


const Real modVub_cent  = 4.31e-3; // PDG 2007

CM33 standard_unitary_matrix(Real s12, Real s13, Real s23, Real delta);
CM33 standard_VCKM(Real gamma, Real Vub);
CM33 standard_VCKM(Real gamma);


#endif // SM_H