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

#include "MSSM_lattice_initial_guesser.hpp"
#include "MSSM_lattice_model.hpp"

namespace flexiblesusy {

MSSM_initial_guesser<Lattice>::MSSM_initial_guesser(
   MSSM<Lattice>*,
   MSSM_input_parameters&,
   MSSM_low_scale_constraint<Lattice>&,
   MSSM_susy_scale_constraint<Lattice>&,
   MSSM_high_scale_constraint<Lattice>&
)
   : Initial_guesser<Lattice>()
{
}

MSSM_initial_guesser<Lattice>::~MSSM_initial_guesser()
{
}

} // namespace flexiblesusy
