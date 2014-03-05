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

// File generated at Mon 3 Mar 2014 16:11:43

#include "MSSM_lattice_susy_scale_constraint.hpp"
#include "MSSM_lattice_model.hpp"

namespace flexiblesusy {

MSSM_susy_scale_constraint<Lattice>::MSSM_susy_scale_constraint()
   : Constraint<Lattice>()
{
}

MSSM_susy_scale_constraint<Lattice>::MSSM_susy_scale_constraint(const MSSM_input_parameters&)
   : Constraint<Lattice>()
{
}

MSSM_susy_scale_constraint<Lattice>::~MSSM_susy_scale_constraint()
{
}

double MSSM_susy_scale_constraint<Lattice>::get_scale() const
{
   return 0.;
}

} // namespace flexiblesusy
