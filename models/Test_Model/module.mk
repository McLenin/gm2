DIR          := models/Test_Model
MODNAME      := libTest_Model

LIBTest_Model_SRC :=

ifneq ($(findstring two_scale,$(ALGORITHMS)),)
LIBTest_Model_SRC += \
		$(DIR)/run_Test_Model.cpp \
		$(DIR)/scan_Test_Model.cpp \
		$(DIR)/Test_Model_info.cpp \
		$(DIR)/Test_Model_slha_io.cpp \
		$(DIR)/Test_Model_physical.cpp \
		$(DIR)/Test_Model_utilities.cpp \
		$(DIR)/Test_Model_two_scale_convergence_tester.cpp \
		$(DIR)/Test_Model_two_scale_high_scale_constraint.cpp \
		$(DIR)/Test_Model_two_scale_initial_guesser.cpp \
		$(DIR)/Test_Model_two_scale_low_scale_constraint.cpp \
		$(DIR)/Test_Model_two_scale_model.cpp \
		$(DIR)/Test_Model_two_scale_susy_parameters.cpp \
		$(DIR)/Test_Model_two_scale_soft_parameters.cpp \
		$(DIR)/Test_Model_two_scale_susy_scale_constraint.cpp
endif

ifneq ($(findstring lattice,$(ALGORITHMS)),)
LIBTest_Model_SRC += \
		$(DIR)/run_Test_Model.cpp \
		$(DIR)/scan_Test_Model.cpp \
		$(DIR)/Test_Model_info.cpp \
		$(DIR)/Test_Model_slha_io.cpp \
		$(DIR)/Test_Model_physical.cpp \
		$(DIR)/Test_Model_utilities.cpp \
		$(DIR)/Test_Model_lattice_convergence_tester.cpp \
		$(DIR)/Test_Model_lattice_high_scale_constraint.cpp \
		$(DIR)/Test_Model_lattice_initial_guesser.cpp \
		$(DIR)/Test_Model_lattice_low_scale_constraint.cpp \
		$(DIR)/Test_Model_lattice_model.cpp \
		$(DIR)/Test_Model_lattice_susy_scale_constraint.cpp
endif

# remove duplicates in case all algorithms are used
LIBTest_Model_SRC := $(sort $(LIBTest_Model_SRC))

LIBTest_Model_OBJ := \
		$(patsubst %.cpp, %.o, $(filter %.cpp, $(LIBTest_Model_SRC))) \
		$(patsubst %.f, %.o, $(filter %.f, $(LIBTest_Model_SRC)))

LIBTest_Model_DEP := \
		$(LIBTest_Model_OBJ:.o=.d)

$(LIBTest_Model_DEP) $(LIBTest_Model_OBJ): CPPFLAGS += $(GSLFLAGS)

LIBTest_Model     := $(DIR)/$(MODNAME)$(LIBEXT)

RUN_Test_Model_EXE := $(DIR)/run_Test_Model.x

SCAN_Test_Model_EXE := $(DIR)/scan_Test_Model.x

.PHONY:         all-$(MODNAME) clean-$(MODNAME) distclean-$(MODNAME)

all-$(MODNAME): $(LIBTest_Model)

clean-$(MODNAME):
		rm -rf $(LIBTest_Model_OBJ)

distclean-$(MODNAME): clean-$(MODNAME)
		rm -rf $(LIBTest_Model_DEP)
		rm -rf $(LIBTest_Model)

clean::         clean-$(MODNAME)

distclean::     distclean-$(MODNAME)

$(DIR)/Test_Model_two_scale_susy_parameters.hpp: $(DIR)/start.m $(DIR)/FlexibleSUSY.m $(META_SRC) $(TEMPLATES)
	$(MATH) -run "Get[\"$<\"]; Quit[]"

$(DIR)/Test_Model_two_scale_susy_parameters.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_two_scale_soft_parameters.hpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_two_scale_soft_parameters.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/scan_Test_Model.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_slha_io.hpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_slha_io.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_physical.hpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_physical.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_model.hpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_lattice_model.hpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_lattice_model.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_two_scale_model.hpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_two_scale_model.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/run_Test_Model.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_high_scale_constraint.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_susy_scale_constraint.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_low_scale_constraint.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_lattice_high_scale_constraint.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_two_scale_high_scale_constraint.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_lattice_susy_scale_constraint.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_two_scale_susy_scale_constraint.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_lattice_low_scale_constraint.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_two_scale_low_scale_constraint.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_convergence_tester.hpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_lattice_convergence_tester.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_two_scale_convergence_tester.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_initial_guesser.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_lattice_initial_guesser.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_two_scale_initial_guesser.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_info.hpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_info.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_spectrum_generator.hpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_utilities.hpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(DIR)/Test_Model_utilities.cpp: $(DIR)/Test_Model_two_scale_susy_parameters.hpp
	@true

$(LIBTest_Model_DEP) $(LIBTest_Model_OBJ) $(DIR)/run_Test_Model.o $(DIR)/scan_Test_Model.o: CPPFLAGS += $(GSLFLAGS) $(EIGENFLAGS) $(BOOSTFLAGS)

$(LIBTest_Model): $(LIBTest_Model_OBJ)
		$(MAKELIB) $@ $^

ifeq ($(ENABLE_LOOPTOOLS),yes)
$(LIBTest_Model_OBJ) $(LIBTest_Model_DEP): CPPFLAGS += $(LOOPTOOLSFLAGS)
endif

$(RUN_Test_Model_EXE): $(DIR)/run_Test_Model.o $(LIBTest_Model) $(LIBFLEXI) $(LIBLEGACY)
		$(CXX) -o $@ $(abspath $^) $(GSLLIBS) $(BOOSTTHREADLIBS) $(LAPACKLIBS) $(FLIBS) $(LOOPTOOLSLIBS)

$(SCAN_Test_Model_EXE): $(DIR)/scan_Test_Model.o $(LIBTest_Model) $(LIBFLEXI) $(LIBLEGACY)
		$(CXX) -o $@ $(abspath $^) $(GSLLIBS) $(BOOSTTHREADLIBS) $(LAPACKLIBS) $(FLIBS) $(LOOPTOOLSLIBS)

ALLDEP += $(LIBTest_Model_DEP)
ALLLIB += $(LIBTest_Model)
ALLEXE += $(RUN_Test_Model_EXE) $(SCAN_Test_Model_EXE)
