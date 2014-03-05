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

#include "MSSM_input_parameters.hpp"
#include "MSSM_spectrum_generator.hpp"

#include "error.hpp"
#include "scan.hpp"
#include "stopwatch.hpp"
#include "lowe.h"

#include <iostream>

int main()
{
   using namespace flexiblesusy;
   using namespace softsusy;
   typedef Two_scale algorithm_type;

   Stopwatch stopwatch;
   MSSM_input_parameters input;
   QedQcd oneset;
   oneset.toMz();

   MSSM_spectrum_generator<algorithm_type> spectrum_generator;
   spectrum_generator.set_precision_goal(1.0e-4);
   spectrum_generator.set_max_iterations(0);         // 0 == automatic
   spectrum_generator.set_calculate_sm_masses(0);    // 0 == no
   spectrum_generator.set_parameter_output_scale(0); // 0 == susy scale
   spectrum_generator.set_pole_mass_loop_order(1);
   spectrum_generator.set_ewsb_loop_order(1);

   const std::vector<double> range(float_range(0., 100., 10));

   cout << "# "
        << std::setw(12) << std::left << "m0" << ' '
        << std::setw(12) << std::left << "Mhh(1)/GeV" << ' '
        << std::setw(12) << std::left << "error" << ' '
        << std::setw(12) << std::left << "time/s"
        << '\n';

   for (std::vector<double>::const_iterator it = range.begin(),
           end = range.end(); it != end; ++it) {
      input.m0 = *it;

      stopwatch.start();
      spectrum_generator.run(oneset, input);
      stopwatch.stop();

      const MSSM<algorithm_type>& model = spectrum_generator.get_model();
      const MSSM_physical& pole_masses = model.get_physical();
      const Problems<MSSM_info::NUMBER_OF_PARTICLES>& problems
         = spectrum_generator.get_problems();
      const double higgs = pole_masses.Mhh(0);
      const bool error = problems.have_serious_problem();

      cout << "  "
           << std::setw(12) << std::left << input.m0 << ' '
           << std::setw(12) << std::left << higgs << ' '
           << std::setw(12) << std::left << error << ' '
           << std::setw(12) << std::left << stopwatch.get_time_in_seconds();
      if (error) {
         cout << "\t# " << problems;
      }
      cout << '\n';
   }

   return 0;
}
