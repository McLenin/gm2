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

// File generated at Mon 3 Mar 2014 16:14:11

#ifndef MSSM_LATTICE_H
#define MSSM_LATTICE_H

#include "MSSM_model.hpp"
#include "MSSM_input_parameters.hpp"

#include <iosfwd>

namespace flexiblesusy {

class Lattice;

template<>
class MSSM<Lattice> {
public:
   MSSM(const MSSM_input_parameters& input_ = MSSM_input_parameters());
   virtual ~MSSM();

   // interface functions
   virtual void calculate_spectrum();
   virtual void run_to(double);
   virtual void print(std::ostream&) const;
};

} // namespace flexiblesusy

#endif
