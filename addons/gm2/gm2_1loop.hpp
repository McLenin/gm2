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

#ifndef GM2_1LOOP_H
#define GM2_1LOOP_H

#include "MSSM_gm2_wrapper.hpp"
#include "ffunctions.hpp"
#include "wrappers.hpp"

// class DoubleVector;
// class DoubleMatrix;

namespace flexiblesusy {

template <class T> class MSSM;
class Two_scale;

namespace gm2 {

double amuWHnu(const MSSM_gm2_wrapper&);
double amuWHmuL(const MSSM_gm2_wrapper&);
double amuBHmuL(const MSSM_gm2_wrapper&);
double amuBHmuR(const MSSM_gm2_wrapper&);
double amuBmuLmuR(const MSSM_gm2_wrapper&);
double amu1Lapprox(const MSSM_gm2_wrapper&);

Eigen::Matrix<std::complex<double>,4,2> n_L(const MSSM_gm2_wrapper&);
Eigen::Matrix<std::complex<double>,4,2> n_R(const MSSM_gm2_wrapper&);

Eigen::Array<std::complex<double>,2,1> c_L(const MSSM_gm2_wrapper&);
Eigen::Array<std::complex<double>,2,1> c_R(const MSSM_gm2_wrapper&);

Eigen::Array<double,2,1> AAC(const MSSM_gm2_wrapper&);
Eigen::Matrix<double,4,2> AAN(const MSSM_gm2_wrapper&);
Eigen::Array<double,2,1> BBC(const MSSM_gm2_wrapper&);
Eigen::Matrix<double,4,2> BBN(const MSSM_gm2_wrapper&);

Eigen::Matrix<double,4,2> x_im(const MSSM_gm2_wrapper&);
Eigen::Array<double,2,1> x_k(const MSSM_gm2_wrapper&);

double amuChi0(const MSSM_gm2_wrapper&);
double amuChipm(const MSSM_gm2_wrapper&);
double calculate_gm2_1loop(const MSSM_gm2_wrapper&);

} // namespace gm2
} // namespace flexiblesusy

#endif
