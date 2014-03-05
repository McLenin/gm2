#include "test.h"
#include "test_gm2_1loop.hpp"
#include "MSSM_gm2_wrapper.hpp"
#include "gm2_2loop.hpp"

namespace flexiblesusy {
namespace gm2{

void setup_SPS1b(gm2::MSSM_gm2_wrapper& model) {
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
   double MT = 173.2;
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

   Mu = 495.6;
   TB = 30.;
   MW = 80.385;
   MZ = 91.1876;
   EL = 0.308274; // 0.31218 corresponding to alpha(MZ)
   g3 = 1.06459;

   // soft parameters
   Ae << 1., 0., 0.,
         0., 1., 0.,
         0., 0., -195.8;

   Au << 1., 0., 0.,
         0., 1., 0.,
         0., 0., -729.3;

   Ad << 1., 0., 0.,
         0., 1., 0.,
         0., 0., -987.4;

   TYu << -0.0144387,        0,        0,
                   0, -7.64037,        0,
                   0,        0, -759.305;

   TYd << -0.336207,        0,        0,
                  0, -7.36109,        0,
                  0,        0, -250.124;

   TYe << -0.00825134,        0,        0,
                    0, -1.70609,        0,
                    0,        0, -29.4466;

   BMu = 9194.792;

   mq2 << sqr(836.2),           0,           0,
                    0, sqr(836.2),           0,
                    0,           0,      sqr(762.5);

   ml2 << sqr(334.),      0,      0,
               0, sqr(334.),      0,
               0,      0, sqr(323.8);

   mHd2 =  92436.9; // m_1^2
   mHu2 = -380337.; // m_2^2

   md2 << sqr(803.9),          0,          0,
                   0, sqr(803.9),          0,
                   0,          0, sqr(780.3);

   mu2 << sqr(807.5),      0,      0,
               0, sqr(807.5),      0,
               0,      0, sqr(670.7);

   me2 << sqr(248.3),       0,       0,
                0, sqr(248.3),       0,
                0,       0, sqr(218.6);

   MassB =   162.8; // M_1
   MassWB =  310.9; // M_2
   MassG = 1114.45; // M_3

   MUDIM = 706.9;
   MA0 = 525.5;

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
   setup_SPS1b(model);

   double gm2_1loop = calculate_gm2_1loop(model);
   double amuphotonic = amuChipmPhotonic(model) + amuChi0Photonic(model);

   TEST_CLOSE(amua2LSferm(model), 0.044e-10, 1.e-13);
   TEST_CLOSE(amua2LCha(model), 0.273e-10, 1.e-13);
   TEST_CLOSE(gm2_1loop, 33.3412e-10, 1.e-13);
   TEST_CLOSE(amuphotonic, -2.58408e-10, 1.e-13);

   return gErrors;
}
