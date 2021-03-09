#!/usr/bin/make -f
# Makefile for LDPF Plugin    #
# --------------------------- #
# Initially created by falkTX
#
# --------------------------------------------------------------
# Project name (used for binaries) has to be specified in the
# variable NAME in the file info.mk within this directory.
# --------------------------------------------------------------

# --------------------------------------------------------------
# This Makefile for dependencies (see below)
THIS_MAKEFILE := ./Makefile


# --------------------------------------------------------------
# Parameters for DPF
# --------------------------------------------------------------

# Files to build

FILES_DSP = \
	Example02Plugin.cpp

FILES_UI = \
	Example02UI.cpp

# --------------------------------------------------------------
# Pparameters for LDPF
# --------------------------------------------------------------

# Path to the root directory, where dpf and ldpf subdirectories
# are located:
LDPF_ROOT_PATH  := ../..

ifeq ($(DEBUG),true)
# Lua modules path for overriding builtin Lua modules for debugging purposes.
LDPF_UI_FLAGS += -D'LDPF_EXAMPLE02_LUA_PATH="$(shell pwd)/lua/?.lua;$(shell pwd)/lua/?/init.lua"'
endif

# List of needed LDPF components:
LDPF_COMPONENTS := $(LDPF_ROOT_PATH)/ldpf/components/lpugl        \
                   $(LDPF_ROOT_PATH)/ldpf/components/lpugl_opengl \
                   $(LDPF_ROOT_PATH)/ldpf/components/nvg

# Path to plugin's lua source modules root directory. Non *.lua files in
# this directory are handled as resource files and will also be 
# included in the plugin.
LDPF_LUA_SOURCE_PATH := lua

# For dependencies: if definitions in this Makefile are changed, the 
# compiled-in components and modules lists will be re-generated.
LDPF_PLUGIN_DEFINITION_DEPENDENCIES := $(THIS_MAKEFILE)

# --------------------------------------------------------------
# Do some magic

include $(LDPF_ROOT_PATH)/ldpf/Makefile.plugins.mk


# --------------------------------------------------------------
# Recompile for definition changes in this Makefile
$(BUILD_DIR)/Example02UI.cpp.o: $(THIS_MAKEFILE)


# --------------------------------------------------------------
# Enable all possible plugin types

ifeq ($(HAVE_JACK),true)
ifeq ($(HAVE_OPENGL),true)
TARGETS += jack
endif
endif

ifneq ($(MACOS_OR_WINDOWS),true)
ifeq ($(HAVE_OPENGL),true)
ifeq ($(HAVE_LIBLO),true)
TARGETS += dssi
endif
endif
endif

ifeq ($(HAVE_OPENGL),true)
TARGETS += lv2_sep
else
TARGETS += lv2_dsp
endif

TARGETS += vst

all: $(TARGETS)

# --------------------------------------------------------------
