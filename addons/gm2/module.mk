DIR          := addons/gm2
MODNAME      := libgm2

LIBGM2_SRC := \
		$(DIR)/ffunctions.cpp \
		$(DIR)/gm2.cpp \
		$(DIR)/gm2_1loop.cpp

LIBGM2_OBJ := \
		$(patsubst %.cpp, %.o, $(filter %.cpp, $(LIBGM2_SRC)))

LIBGM2_DEP := \
		$(LIBGM2_OBJ:.o=.d)

LIBGM2     := $(DIR)/$(MODNAME)$(LIBEXT)

LIBGM2_META := \
		$(DIR)/Gm2.m

LIBGM2_TEMPLATES := \
		$(DIR)/gm2.cpp.in \
		$(DIR)/gm2.hpp.in \
		$(DIR)/gm2_1loop.cpp.in \
		$(DIR)/gm2_1loop.hpp.in

GM2_EXE    := $(DIR)/gm2.x

.PHONY:         all-$(MODNAME) clean-$(MODNAME) distclean-$(MODNAME)

all-$(MODNAME): $(LIBGM2)

clean-$(MODNAME):
		rm -rf $(LIBGM2_OBJ)

distclean-$(MODNAME): clean-$(MODNAME)
		rm -rf $(LIBGM2_DEP)
		rm -rf $(LIBGM2)

clean::         clean-$(MODNAME)

distclean::     distclean-$(MODNAME)

$(DIR)/gm2.cpp: $(DIR)/start.m $(LIBGM2_META) $(LIBGM2_TEMPLATES) $(META_SRC) $(TEMPLATES)
		$(MATH) -run "Get[\"$<\"]; Quit[]"

$(DIR)/gm2.hpp: $(DIR)/gm2.cpp
		@true

$(DIR)/gm2_1loop.cpp: $(DIR)/gm2.cpp
		@true

$(DIR)/gm2_1loop.hpp: $(DIR)/gm2.cpp
		@true

$(LIBGM2_DEP) $(LIBGM2_OBJ) $(DIR)/gm2.o: CPPFLAGS += $(EIGENFLAGS)

$(LIBGM2): $(LIBGM2_OBJ)
		$(MAKELIB) $@ $^

$(GM2_EXE): $(DIR)/gm2.o $(LIBGM2) $(LIBMSSM) $(LIBFLEXI) $(LIBLEGACY)
		$(CXX) -o $@ $(abspath $^) $(GSLLIBS) $(FLIBS)

ALLDEP += $(LIBGM2_DEP)
ALLLIB += $(LIBGM2)
ALLEXE += $(GM2_EXE)