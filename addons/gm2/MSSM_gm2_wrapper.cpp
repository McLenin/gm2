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

#include "MSSM_gm2_wrapper.hpp"

namespace flexiblesusy {
namespace gm2 {

void MSSM_gm2_wrapper::convert_parameters_reverse() {
   set_TB(get_vu() / get_vd());
   double gY = get_gY();
   double g2 = get_g2();
   set_EL(gY * g2 / sqrt(sqr(gY) + sqr(g2)));
   double v = sqrt(sqr(get_vu()) + sqr(get_vd()));
   set_MZ(0.5 * sqrt(sqr(gY) + sqr(g2)) * v);
   set_MW(0.5 * g2 * v);
}


void MSSM_gm2_wrapper::convert_parameters() {
   set_g1(sqrt(5. / 3.) * EL * MZ / MW);
   set_g2(EL / sqrt(1. - sqr(MW / MZ)));
   double v = 2. * MW / get_g2();
   set_vu(v / sqrt(1. + 1. / sqr(TB)));
   set_vd(get_vu() / TB);
   Eigen::Matrix<double,3,3> Ye_neu(get_Ye());
   Ye_neu(0, 0) = sqrt(2.) * ME / get_vd();
   Ye_neu(1, 1) = sqrt(2.) * MM / get_vd();
   Ye_neu(2, 2) = sqrt(2.) * ML / get_vd();
   set_Ye(Ye_neu);
   Eigen::Matrix<double,3,3> Yu_neu(get_Yu());
   Yu_neu(0, 0) = sqrt(2.) * MU / get_vu();
   Yu_neu(1, 1) = sqrt(2.) * MC / get_vu();
   Yu_neu(2, 2) = sqrt(2.) * MT / get_vu();
   set_Yu(Yu_neu);
   Eigen::Matrix<double,3,3> Yd_neu(get_Yd());
   Yd_neu(0, 0) = sqrt(2.) * MD / get_vd();
   Yd_neu(1, 1) = sqrt(2.) * MS / get_vd();
   Yd_neu(2, 2) = sqrt(2.) * MB / get_vd();
   set_Yd(Yd_neu);
   set_TYe(Ye_neu * Ae);
   set_TYu(Yu_neu * Au);
   set_TYd(Yd_neu * Ad);
   double tan2b = 2. * TB / (1. - sqr(TB));
   set_BMu(0.5 * sqr(MA0) * (tan2b / sqrt(1. + sqr(tan2b))));
}

void MSSM_gm2_wrapper::calculate_DRbar_parameters() {
   convert_parameters();
   MSSM<Two_scale>::calculate_DRbar_parameters();
   Eigen::Matrix<double,6,6> mass_matrix_6x6(get_mass_matrix_Se());
   Eigen::Matrix<double,2,2> mass_matrix_2x2;
   mass_matrix_2x2(0,0) = mass_matrix_6x6(1,1);
   mass_matrix_2x2(0,1) = mass_matrix_6x6(1,4);
   mass_matrix_2x2(1,0) = mass_matrix_6x6(4,1);
   mass_matrix_2x2(1,1) = mass_matrix_6x6(4,4);

   fs_diagonalize_hermitian(mass_matrix_2x2, MSmu, USmu);

//   if (MSmu.min() < 0.)
//      ERROR("SMuon is a Tachyon");

   MSmu = AbsSqrt(MSmu);

   mass_matrix_2x2(0,0) = mass_matrix_6x6(2,2);
   mass_matrix_2x2(0,1) = mass_matrix_6x6(2,5);
   mass_matrix_2x2(1,0) = mass_matrix_6x6(5,2);
   mass_matrix_2x2(1,1) = mass_matrix_6x6(5,5);

   fs_diagonalize_hermitian(mass_matrix_2x2, MStau, UStau);

//   if (MStau.min() < 0.)
//      ERROR("STauon is a Tachyon");

   MStau = AbsSqrt(MStau);

   mass_matrix_6x6 = get_mass_matrix_Sd();
   mass_matrix_2x2(0,0) = mass_matrix_6x6(2,2);
   mass_matrix_2x2(0,1) = mass_matrix_6x6(2,5);
   mass_matrix_2x2(1,0) = mass_matrix_6x6(5,2);
   mass_matrix_2x2(1,1) = mass_matrix_6x6(5,5);

   fs_diagonalize_hermitian(mass_matrix_2x2, MSbot, USbot);

//   if (MSbot.min() < 0.)
//      ERROR("SBottem is a Tachyon");

   MSbot = AbsSqrt(MSbot);

   mass_matrix_6x6 = get_mass_matrix_Su();
   mass_matrix_2x2(0,0) = mass_matrix_6x6(2,2);
   mass_matrix_2x2(0,1) = mass_matrix_6x6(2,5);
   mass_matrix_2x2(1,0) = mass_matrix_6x6(5,2);
   mass_matrix_2x2(1,1) = mass_matrix_6x6(5,5);

   fs_diagonalize_hermitian(mass_matrix_2x2, MStop, UStop);

//   if (MStop.min() < 0.)
//      ERROR("STop is a Tachyon");

   MStop = AbsSqrt(MStop);
}

} // gm2
} // namespace flexiblesusy