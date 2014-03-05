// ====================================================================
// This file is part of FlexibleSUSY.
//
// FlexibleSUSY is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published
// by the Free Software Foundation, either version 3 of the License,
// or (at your option) any later version.
//
// FlexibleSUSY is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with FlexibleSUSY.  If not, see
// <http://www.gnu.org/licenses/>.
// ====================================================================

// File generated at Mon 3 Mar 2014 16:11:40

#ifndef MSSM_INPUT_PARAMETERS_H
#define MSSM_INPUT_PARAMETERS_H

#include <complex>
#include <Eigen/Core>

namespace flexiblesusy {

struct MSSM_input_parameters {
   double m0;
   double m12;
   double TanBeta;
   int SignMu;
   double Azero;

   MSSM_input_parameters()
      : m0(125), m12(500), TanBeta(10), SignMu(1), Azero(0)

   {}
};

} // namespace flexiblesusy

#endif
