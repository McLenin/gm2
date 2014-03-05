#include "test_gm2_2loop.hpp"
#include "MSSM_input_parameters.hpp"
#include "MSSM_slha_io.hpp"
#include "MSSM_spectrum_generator.hpp"
#include "program_options.hpp"
#include "lowe.h"
#include "test.h"
#include "MSSM_gm2_wrapper.hpp"

namespace flexiblesusy {
namespace gm2{

void setup_bm1(gm2::MSSM_gm2_wrapper& model) {
   Eigen::Matrix<double,3,3> Yu;
   Eigen::Matrix<double,3,3> Yd;
   Eigen::Matrix<double,3,3> Ye;
   double Mu;
   double TB;
   double EL;
   double g3;
   double MW;
   double MZ;
   double ME = 0.00051;
   double MM = 0.105658;
   double ML = 1.777;
   double MU = 0.04151;
   double MC = 1.5;
   double MT = 173.5;
   double MD = 0.0415;
   double MS = 0.15;
   double MB = 3.;
   Eigen::Matrix<double,3,3> Ae;
   Eigen::Matrix<double,3,3> Au;
   Eigen::Matrix<double,3,3> Ad;
   Eigen::Matrix<double,3,3> TYu;
   Eigen::Matrix<double,3,3> TYd;
   Eigen::Matrix<double,3,3> TYe;
   double BMu;
   Eigen::Matrix<double,3,3> mq2;
   Eigen::Matrix<double,3,3> ml2;
   double mHd2;
   double mHu2;
   Eigen::Matrix<double,3,3> md2;
   Eigen::Matrix<double,3,3> mu2;
   Eigen::Matrix<double,3,3> me2;
   double MassB;
   double MassWB;
   double MassG;
   double MUDIM;
   double MA0;

   // susy parameters
   Yu << 1.26136e-05,          0,          0,
                   0, 0.00667469,          0,
                   0,          0,   0.857849;

   Yd << 0.000242026,          0,          0,
                   0, 0.00529911,          0,
                   0,          0,   0.193602;

   Ye << 2.84161e-05,          0,          0,
                   0, 0.00587557,          0,
                   0,          0,    0.10199;

   Mu = 350.;
   TB = 40.;
   MW = 80.385;
   MZ = 91.1876;
   EL = 0.313429;
   g3 = 1.06459;

   // soft parameters
   Ae << 0., 0., 0.,
         0., 0., 0.,
         0., 0., 0.;

   Au << 0., 0., 0.,
         0., 0., 0.,
         0., 0., 0.;

   Ad << 0., 0., 0.,
         0., 0., 0.,
         0., 0., 0.;

   TYu << -0.0144387,        0,        0,
                   0, -7.64037,        0,
                   0,        0, -759.305;

   TYd << -0.336207,        0,        0,
                  0, -7.36109,        0,
                  0,        0, -250.124;

   TYe << -0.00825134,        0,        0,
                    0, -1.70609,        0,
                    0,        0, -29.4466;

   BMu = 52140.8;

   mq2 << 49000000.,         0,          0,
                  0, 49000000.,          0,
                  0,         0,  49000000.;

   ml2 << 160000.,       0,        0,
                0, 160000.,        0,
                0,       0, 9000000.;

   mHd2 =  92436.9;
   mHu2 = -380337.;

   md2 << 49000000.,         0,         0,
                  0, 49000000.,         0,
                  0,         0, 49000000.;

   mu2 << 49000000.,         0,          0,
                  0, 49000000.,          0,
                  0,         0,  49000000.;

   me2 << 160001.,       0,        0,
                0, 160001.,        0,
                0,       0, 9000000.;

   MassB =    150.; //  M_1
   MassWB =   300.; // M_2
   MassG = 1114.45; // M_3

   MUDIM = 454.7;
   MA0 =   1500.;

   // set parameters
   model.set_TB(TB);
   model.set_MW(MW);
   model.set_MZ(MZ);
   model.set_EL(EL);
   model.set_Yu(Yu);
   model.set_Yd(Yd);
   model.set_Ye(Ye);
   model.set_Ae(Ae);
   model.set_Ad(Ad);
   model.set_Au(Au);
   model.set_ME(ME);
   model.set_MM(MM);
   model.set_ML(ML);
   model.set_MU(MU);
   model.set_MC(MC);
   model.set_MT(MT);
   model.set_MD(MD);
   model.set_MS(MS);
   model.set_MB(MB);
   model.set_Mu(Mu);
   model.set_g3(g3);
   model.set_TYu(TYu);
   model.set_TYd(TYd);
   model.set_TYe(TYe);
   model.set_BMu(BMu);
   model.set_mq2(mq2);
   model.set_ml2(ml2);
   model.set_mHd2(mHd2);
   model.set_mHu2(mHu2);
   model.set_md2(md2);
   model.set_mu2(mu2);
   model.set_me2(me2);
   model.set_MassB(MassB);
   model.set_MassWB(MassWB);
   model.set_MassG(MassG);
   model.set_MUDIM(MUDIM);
   model.set_MA0(MA0);

   // calculate tree-level masses
   model.calculate_DRbar_parameters();
}

} // gm2
} // flexiblesusy

using namespace flexiblesusy;
using namespace gm2;

int main() {
   MSSM_gm2_wrapper model;
   setup_bm1(model);

   TEST_CLOSE(amu1Lapprox(model), 45.05e-10, 5.e-13);
   double amu2Loopapprox = amu2LFSfapprox(model);
   model.set_EL(0.31218);
   model.calculate_DRbar_parameters();
   TEST_CLOSE(calculate_gm2_1loop(model), 44.0183e-10, 2.e-13);
   TEST_CLOSE(tan_beta_cor(model), 1.06945, 1.e-4);
   TEST_CLOSE(( (amuChi0Photonic(model) + amuChipmPhotonic(model))
                / calculate_gm2_1loop(model) ), -0.079836, 1.e-5);
   TEST_CLOSE(amu2Loopapprox / calculate_gm2_1loop(model), 0.040, 5.e-4);

   return gErrors;
}
