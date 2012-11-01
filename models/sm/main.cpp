// ====================================================================
//
// File:        main.cpp
// Author:      Alexander Voigt
// Description: main() routine
//
// This file is part of FlexibleSUSY.
//
// FlexibleSUSY is free software: you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public License
// as published by the Free Software Foundation, either version 3 of
// the License, or (at your option) any later version.
//
// FlexibleSUSY is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with FlexibleSUSY.  If not, see
// <http://www.gnu.org/licenses/>.
// ====================================================================

#include "two_scale_solver.hpp"
#include "sm.hpp"

int main()
{
   const double vev = 246;
   const double root2 = sqrt(2.0);
   const double mtoprun = 165;
   const double mbrun = 2.9;
   const double mtau = 1.77699;
   const double yt = mtoprun * root2 / vev;
   const double yb = mbrun * root2 / vev;
   const double ytau = mtau * root2 / vev;

   const double MZ = 91.1876;
   const double aem = 1.0 / 127.918; // at MZ
   const double sinthWsq = 0.23122;
   const double alpha1 = 5.0 * aem / (3.0 * (1.0 - sinthWsq));
   const double alpha2 = aem / sinthWsq;
   const double alpha3 = 0.1187; // at MZ

   StandardModel* sm = new StandardModel();
   sm->setMu(MZ);
   sm->setYukawaElement(StandardModel::YU, 3, 3, yt);
   sm->setYukawaElement(StandardModel::YD, 3, 3, yb);
   sm->setYukawaElement(StandardModel::YE, 3, 3, ytau);
   sm->setGaugeCoupling(1, sqrt(4 * PI * alpha1));
   sm->setGaugeCoupling(2, sqrt(4 * PI * alpha2));
   sm->setGaugeCoupling(3, sqrt(4 * PI * alpha3));

   Two_scale_solver ds(sm);
   ds.solve();

   delete sm;

   return 0;
}