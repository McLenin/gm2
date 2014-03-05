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

#ifndef MSSM_TWO_SCALE_LOW_SCALE_CONSTRAINT_H
#define MSSM_TWO_SCALE_LOW_SCALE_CONSTRAINT_H

#include "MSSM_low_scale_constraint.hpp"
#include "MSSM_input_parameters.hpp"
#include "two_scale_constraint.hpp"
#include "lowe.h"
#include <Eigen/Core>

namespace flexiblesusy {

template <class T>
class MSSM;

class Two_scale;

template<>
class MSSM_low_scale_constraint<Two_scale> : public Constraint<Two_scale> {
public:
   MSSM_low_scale_constraint();
   MSSM_low_scale_constraint(const MSSM_input_parameters&, const QedQcd&);
   virtual ~MSSM_low_scale_constraint();
   virtual void apply();
   virtual double get_scale() const;
   virtual void set_model(Two_scale_model*);
   double get_initial_scale_guess() const;
   void set_input_parameters(const MSSM_input_parameters&);
   void set_sm_parameters(const QedQcd&);
   void reset(); ///< reset to initial state

private:
   double scale;
   double initial_scale_guess;
   MSSM<Two_scale>* model;
   MSSM_input_parameters inputPars;
   QedQcd oneset;
   double MZDRbar;
   double new_g1, new_g2, new_g3;
   Eigen::Matrix<double,3,3> new_Yu, new_Yd, new_Ye;

   void calculate_DRbar_gauge_couplings();
   void calculate_DRbar_yukawa_couplings();
   double calculate_delta_alpha_em(double) const;
   double calculate_delta_alpha_s(double) const;
   void update_scale();
};

} // namespace flexiblesusy

#endif
