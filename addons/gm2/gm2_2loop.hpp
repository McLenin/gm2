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

// File generated at Wed 5 Mar 2014 14:17:07

#ifndef GM2_2LOOP_H
#define GM2_2LOOP_H

#include "ffunctions.hpp"
#include "wrappers.hpp"
#include "MSSM_gm2_wrapper.hpp"


// class DoubleVector;
// class DoubleMatrix;

namespace flexiblesusy {

template <class T> class MSSM;
class Two_scale;

namespace gm2 {
double LogNorm(const MSSM_gm2_wrapper&);

double tan_beta_cor(const MSSM_gm2_wrapper&);

double Deltag1(const MSSM_gm2_wrapper&);
double DeltaYukHiggsino(const MSSM_gm2_wrapper&);
double DeltaYukBinoHiggsino(const MSSM_gm2_wrapper&);
double Deltag2(const MSSM_gm2_wrapper&);
double DeltaYukWinoHiggsino(const MSSM_gm2_wrapper&);
double DeltaTanBeta(const MSSM_gm2_wrapper&);

double amuWHnu2L(const MSSM_gm2_wrapper&);
double amuWHmuL2L(const MSSM_gm2_wrapper&);
double amuBHmuL2L(const MSSM_gm2_wrapper&);
double amuBHmuR2L(const MSSM_gm2_wrapper&);
double amuBmuLmuR2L(const MSSM_gm2_wrapper&);
double amu2LFSfapprox(const MSSM_gm2_wrapper&);

double amuChipmPhotonic(const MSSM_gm2_wrapper&);
double amuChi0Photonic(const MSSM_gm2_wrapper&);

double tan_alpha(const MSSM_gm2_wrapper&);
Eigen::Matrix<std::complex<double>,3,3> lambda_mu_cha(const MSSM_gm2_wrapper&);
Eigen::Matrix<std::complex<double>,2,2> lambda_stop(const MSSM_gm2_wrapper&);
Eigen::Matrix<std::complex<double>,2,2> lambda_sbot(const MSSM_gm2_wrapper&);
Eigen::Matrix<std::complex<double>,2,2> lambda_stau(const MSSM_gm2_wrapper&);
double amua2LSferm(const MSSM_gm2_wrapper&);
double amua2LCha(const MSSM_gm2_wrapper&);

} // namespace gm2
} // namespace flexiblesusy

#endif