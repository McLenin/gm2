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

// File generated at Mon 3 Mar 2014 16:11:44

#ifndef MSSM_LATTICE_LOW_SCALE_CONSTRAINT_H
#define MSSM_LATTICE_LOW_SCALE_CONSTRAINT_H

#include "MSSM_low_scale_constraint.hpp"
#include "MSSM_input_parameters.hpp"
#include "lattice_constraint.hpp"

namespace flexiblesusy {

template <class T>
class MSSM;

class Lattice;

template<>
class MSSM_low_scale_constraint<Lattice> : public Constraint<Lattice> {
public:
   MSSM_low_scale_constraint();
   MSSM_low_scale_constraint(const MSSM_input_parameters&);
   virtual ~MSSM_low_scale_constraint();
   virtual double get_scale() const;
};

} // namespace flexiblesusy

#endif
