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

// File generated at Mon 3 Mar 2014 16:11:41

#ifndef MSSM_INFO_H
#define MSSM_INFO_H

namespace flexiblesusy {

namespace MSSM_info {
   enum Particles : unsigned {VG, Glu, Fv, VP, VZ, Sd, Sv, Su, Se, hh, Ah, Hpm,
      Chi, Cha, Fe, Fd, Fu, VWm, NUMBER_OF_PARTICLES};

   enum Parameters : unsigned {Yd00, Yd01, Yd02, Yd10, Yd11, Yd12, Yd20, Yd21,
      Yd22, Ye00, Ye01, Ye02, Ye10, Ye11, Ye12, Ye20, Ye21, Ye22, Yu00, Yu01, Yu02
      , Yu10, Yu11, Yu12, Yu20, Yu21, Yu22, Mu, g1, g2, g3, vd, vu, TYd00, TYd01,
      TYd02, TYd10, TYd11, TYd12, TYd20, TYd21, TYd22, TYe00, TYe01, TYe02, TYe10,
      TYe11, TYe12, TYe20, TYe21, TYe22, TYu00, TYu01, TYu02, TYu10, TYu11, TYu12
      , TYu20, TYu21, TYu22, BMu, mq200, mq201, mq202, mq210, mq211, mq212, mq220,
      mq221, mq222, ml200, ml201, ml202, ml210, ml211, ml212, ml220, ml221, ml222
      , mHd2, mHu2, md200, md201, md202, md210, md211, md212, md220, md221, md222,
      mu200, mu201, mu202, mu210, mu211, mu212, mu220, mu221, mu222, me200, me201
      , me202, me210, me211, me212, me220, me221, me222, MassB, MassWB, MassG,
      NUMBER_OF_PARAMETERS};

   extern const unsigned particle_multiplicities[NUMBER_OF_PARTICLES];
   extern const char* particle_names[NUMBER_OF_PARTICLES];
   extern const char* particle_latex_names[NUMBER_OF_PARTICLES];
   extern const char* parameter_names[NUMBER_OF_PARAMETERS];
}

} // namespace flexiblesusy

#endif
