DIR          := models/MSSM
MODNAME      := libMSSM
SARAH_MODEL  := MSSM

LIBMSSM_SRC :=
EXEMSSM_SRC :=

ifneq ($(findstring two_scale,$(ALGORITHMS)),)
LIBMSSM_SRC += \
		$(DIR)/MSSM_info.cpp \
		$(DIR)/MSSM_slha_io.cpp \
		$(DIR)/MSSM_physical.cpp \
		$(DIR)/MSSM_utilities.cpp \
		$(DIR)/MSSM_two_scale_convergence_tester.cpp \
		$(DIR)/MSSM_two_scale_high_scale_constraint.cpp \
		$(DIR)/MSSM_two_scale_initial_guesser.cpp \
		$(DIR)/MSSM_two_scale_low_scale_constraint.cpp \
		$(DIR)/MSSM_two_scale_model.cpp \
		$(DIR)/MSSM_two_scale_susy_parameters.cpp \
		$(DIR)/MSSM_two_scale_soft_parameters.cpp \
		$(DIR)/MSSM_two_scale_susy_scale_constraint.cpp
EXEMSSM_SRC += \
		$(DIR)/run_MSSM.cpp \
		$(DIR)/scan_MSSM.cpp

ifneq ($(MAKECMDGOALS),showbuild)
ifneq ($(MAKECMDGOALS),tag)
ifneq ($(MAKECMDGOALS),release)
ifneq ($(MAKECMDGOALS),doc)
-include $(DIR)/two_scale_susy.mk
-include $(DIR)/two_scale_soft.mk
ifneq ($(MAKECMDGOALS),clean)
ifneq ($(MAKECMDGOALS),distclean)
ifeq ($(findstring clean-,$(MAKECMDGOALS)),)
ifeq ($(findstring distclean-,$(MAKECMDGOALS)),)
ifeq ($(findstring doc-,$(MAKECMDGOALS)),)
$(DIR)/two_scale_susy.mk: run-metacode-$(MODNAME)
		@true
$(DIR)/two_scale_soft.mk: run-metacode-$(MODNAME)
		@true
endif
endif
endif
endif
endif
endif
endif
endif
endif

endif

ifneq ($(findstring lattice,$(ALGORITHMS)),)
LIBMSSM_SRC += \
		$(DIR)/MSSM_info.cpp \
		$(DIR)/MSSM_slha_io.cpp \
		$(DIR)/MSSM_physical.cpp \
		$(DIR)/MSSM_utilities.cpp \
		$(DIR)/MSSM_lattice_convergence_tester.cpp \
		$(DIR)/MSSM_lattice_high_scale_constraint.cpp \
		$(DIR)/MSSM_lattice_initial_guesser.cpp \
		$(DIR)/MSSM_lattice_low_scale_constraint.cpp \
		$(DIR)/MSSM_lattice_model.cpp \
		$(DIR)/MSSM_lattice_susy_scale_constraint.cpp
EXEMSSM_SRC += \
		$(DIR)/run_MSSM.cpp \
		$(DIR)/scan_MSSM.cpp
endif

# remove duplicates in case all algorithms are used
LIBMSSM_SRC := $(sort $(LIBMSSM_SRC))
EXEMSSM_SRC := $(sort $(EXEMSSM_SRC))

LIBMSSM_OBJ := \
		$(patsubst %.cpp, %.o, $(filter %.cpp, $(LIBMSSM_SRC))) \
		$(patsubst %.f, %.o, $(filter %.f, $(LIBMSSM_SRC)))

EXEMSSM_OBJ := \
		$(patsubst %.cpp, %.o, $(filter %.cpp, $(EXEMSSM_SRC))) \
		$(patsubst %.f, %.o, $(filter %.f, $(EXEMSSM_SRC)))

LIBMSSM_DEP := \
		$(LIBMSSM_OBJ:.o=.d)

EXEMSSM_DEP := \
		$(EXEMSSM_OBJ:.o=.d)

LIBMSSM     := $(DIR)/$(MODNAME)$(LIBEXT)

RUN_MSSM_OBJ := $(DIR)/run_MSSM.o
RUN_MSSM_EXE := $(DIR)/run_MSSM.x

SCAN_MSSM_OBJ := $(DIR)/scan_MSSM.o
SCAN_MSSM_EXE := $(DIR)/scan_MSSM.x

METACODE_STAMP_MSSM := $(DIR)/00_DELETE_ME_TO_RERUN_METACODE

SARAH_MODEL_FILES_MSSM := \
		$(shell $(SARAH_DEP_GEN) $(SARAH_MODEL))

.PHONY:         all-$(MODNAME) clean-$(MODNAME) clean-$(MODNAME)-src \
		distclean-$(MODNAME) run-metacode-$(MODNAME)

all-$(MODNAME): $(LIBMSSM)

clean-$(MODNAME):
		-rm -f $(LIBMSSM_OBJ)
		-rm -f $(EXEMSSM_OBJ)

clean-$(MODNAME)-src:
		-rm -f $(LIBMSSM_SRC)
		-rm -f $(EXEMSSM_SRC)
		-rm -f $(METACODE_STAMP_MSSM)

distclean-$(MODNAME): clean-$(MODNAME)
		-rm -f $(LIBMSSM_DEP)
		-rm -f $(LIBMSSM)
		-rm -f $(EXEMSSM_DEP)
		-rm -f $(RUN_MSSM_EXE)
		-rm -f $(SCAN_MSSM_EXE)

clean::         clean-$(MODNAME)

distclean::     distclean-$(MODNAME)

$(DIR)/MSSM_two_scale_susy_parameters.hpp \
$(DIR)/MSSM_two_scale_susy_parameters.cpp \
$(DIR)/MSSM_two_scale_soft_parameters.hpp \
$(DIR)/MSSM_two_scale_soft_parameters.cpp \
$(DIR)/scan_MSSM.cpp \
$(DIR)/MSSM_slha_io.hpp \
$(DIR)/MSSM_slha_io.cpp \
$(DIR)/MSSM_physical.hpp \
$(DIR)/MSSM_physical.cpp \
$(DIR)/MSSM_model.hpp \
$(DIR)/MSSM_lattice_model.hpp \
$(DIR)/MSSM_lattice_model.cpp \
$(DIR)/MSSM_two_scale_model.hpp \
$(DIR)/MSSM_two_scale_model.cpp \
$(DIR)/run_MSSM.cpp \
$(DIR)/MSSM_high_scale_constraint.cpp \
$(DIR)/MSSM_susy_scale_constraint.cpp \
$(DIR)/MSSM_low_scale_constraint.cpp \
$(DIR)/MSSM_lattice_high_scale_constraint.cpp \
$(DIR)/MSSM_two_scale_high_scale_constraint.cpp \
$(DIR)/MSSM_lattice_susy_scale_constraint.cpp \
$(DIR)/MSSM_two_scale_susy_scale_constraint.cpp \
$(DIR)/MSSM_lattice_low_scale_constraint.cpp \
$(DIR)/MSSM_two_scale_low_scale_constraint.cpp \
$(DIR)/MSSM_convergence_tester.hpp \
$(DIR)/MSSM_lattice_convergence_tester.cpp \
$(DIR)/MSSM_two_scale_convergence_tester.cpp \
$(DIR)/MSSM_initial_guesser.cpp \
$(DIR)/MSSM_lattice_initial_guesser.cpp \
$(DIR)/MSSM_two_scale_initial_guesser.cpp \
$(DIR)/MSSM_info.hpp \
$(DIR)/MSSM_info.cpp \
$(DIR)/MSSM_spectrum_generator.hpp \
$(DIR)/MSSM_utilities.hpp \
$(DIR)/MSSM_utilities.cpp \
: run-metacode-$(MODNAME)
		@true

run-metacode-$(MODNAME): $(METACODE_STAMP_MSSM)
		@true

ifeq ($(ENABLE_META),yes)
$(METACODE_STAMP_MSSM): $(DIR)/start.m $(DIR)/FlexibleSUSY.m $(META_SRC) $(TEMPLATES) $(SARAH_MODEL_FILES_MSSM)
		$(MATH) -run "Get[\"$<\"]; Quit[]"
		@touch "$(METACODE_STAMP_MSSM)"
		@echo "Note: to regenerate MSSM source files," \
		      "please remove the file "
		@echo "\"$(METACODE_STAMP_MSSM)\" and run make"
		@echo "---------------------------------"
else
$(METACODE_STAMP_MSSM):
		@true
endif

$(LIBMSSM_DEP) $(EXEMSSM_DEP) $(LIBMSSM_OBJ) $(EXEMSSM_OBJ): CPPFLAGS += $(GSLFLAGS) $(EIGENFLAGS) $(BOOSTFLAGS)

ifeq ($(ENABLE_LOOPTOOLS),yes)
$(LIBMSSM_DEP) $(EXEMSSM_DEP) $(LIBMSSM_OBJ) $(EXEMSSM_OBJ): CPPFLAGS += $(LOOPTOOLSFLAGS)
endif

$(LIBMSSM): $(LIBMSSM_OBJ)
		$(MAKELIB) $@ $^

$(RUN_MSSM_EXE): $(RUN_MSSM_OBJ) $(LIBMSSM) $(LIBFLEXI) $(LIBLEGACY)
		$(CXX) -o $@ $(call abspathx,$^) $(GSLLIBS) $(BOOSTTHREADLIBS) $(THREADLIBS) $(LAPACKLIBS) $(FLIBS) $(LOOPTOOLSLIBS)

$(SCAN_MSSM_EXE): $(SCAN_MSSM_OBJ) $(LIBMSSM) $(LIBFLEXI) $(LIBLEGACY)
		$(CXX) -o $@ $(call abspathx,$^) $(GSLLIBS) $(BOOSTTHREADLIBS) $(THREADLIBS) $(LAPACKLIBS) $(FLIBS) $(LOOPTOOLSLIBS)

ALLDEP += $(LIBMSSM_DEP) $(EXEMSSM_DEP)
ALLSRC += $(LIBMSSM_SRC) $(EXEMSSM_SRC)
ALLLIB += $(LIBMSSM)
ALLEXE += $(RUN_MSSM_EXE) $(SCAN_MSSM_EXE)
