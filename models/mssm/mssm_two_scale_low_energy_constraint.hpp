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

#ifndef MSSM_LOW_ENERGY_CONSTRAINT_H
#define MSSM_LOW_ENERGY_CONSTRAINT_H

#include "two_scale_constraint.hpp"
#include "mssm_two_scale.hpp"

class Mssm_mz_constraint : public Constraint<Two_scale> {
public:
   Mssm_mz_constraint(Mssm<Two_scale>* mssm_,
                      double tanBeta_);
   virtual ~Mssm_mz_constraint();
   virtual void apply();
   virtual double get_scale() const;
   virtual void update_scale();

private:
   Mssm<Two_scale>* mssm;
   double tanBeta;
   double scale;
};

class Mssm_msusy_constraint : public Constraint<Two_scale> {
public:
   Mssm_msusy_constraint(Mssm<Two_scale>* mssm_, const DoubleVector& pars_,
                         double scale_, int sgnMu_);
   virtual ~Mssm_msusy_constraint();
   virtual void apply();
   virtual double get_scale() const;
   virtual void update_scale();

private:
   Mssm<Two_scale>* mssm;
   DoubleVector pars;
   double scale;
   int sgnMu;
};

#endif