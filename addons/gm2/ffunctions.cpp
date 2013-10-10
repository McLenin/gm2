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

#include "ffunctions.hpp"
#include <cmath>

namespace flexiblesusy {

namespace {
inline double sqr(double x)  { return x*x; }
inline double cube(double x) { return x*x*x; }
inline double quad(double x) { return sqr(x)*sqr(x); }
}

namespace gm2 {

double F1C(double x){
   return 2. / quad(1. - x) * (2. + 3. * x - 6. * sqr(x)
                           + cube(x) + 6. * x * log(x));
}

double F2C(double x){
   return 3. / (2. * cube(1. - x)) * (- 3. + 4. * x - sqr(x) - 2. * log(x));
}

double F1N(double x){
   return 2. / quad(1. - x) * (1. - 6. * x + 3. * sqr(x)
                          + 2. * cube(x) - 6. * sqr(x) * log(x));
}

double F2N(double x){
   return 3. / cube(1. - x) * (1. - sqr(x) + 2. * x * log(x));
}

double Fa(double x, double y){
   return - (G3(x) - G3(y)) / (x - y);

}

double Fb(double x, double y){
   return - (G4(x) - G4(y)) / (x - y);

}

double G3(double x){
   return 1. / (2. * cube(x - 1.)) * ((x - 1.) * (x - 3.) + 2. * log(x));

}

double G4(double x){
   return 1. / (2. * cube(x - 1.)) * ((x - 1.) * (x + 1.) - 2. * x * log(x));

}

} // namespace gm2

} // namespace flexiblesusy
