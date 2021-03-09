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
	Example01Plugin.cpp

FILES_UI = \
	Example01UI.cpp


# --------------------------------------------------------------
# Parameters for LDPF
# --------------------------------------------------------------

# Path to the root directory, where dpf and ldpf subdirectories
# are located:
LDPF_ROOT_PATH  := ../..

ifeq ($(DEBUG),true)
# Lua modules path for overriding builtin Lua modules for debugging purposes.
LDPF_UI_FLAGS += -D'LDPF_EXAMPLE01_LUA_PATH="$(shell pwd)/lua/?.lua;$(shell pwd)/lua/?/init.lua"'
endif

# Path to plugin's lua source modules root directory. Non *.lua files in
# this directory are handled as resource files and will also be 
# included in the plugin.
LDPF_LUA_SOURCE_PATH := lua


# --------------------------------------------------------------
# Do some magic

include $(LDPF_ROOT_PATH)/ldpf/Makefile.plugins.mk


# --------------------------------------------------------------
# Recompile for definition changes in this Makefile

$(BUILD_DIR)/Example01UI.cpp.o: $(THIS_MAKEFILE)


# --------------------------------------------------------------
# Enable all possible plugin types

ifeq ($(HAVE_JACK),true)
TARGETS += jack
endif

ifneq ($(MACOS_OR_WINDOWS),true)
ifeq ($(HAVE_LIBLO),true)
TARGETS += dssi
endif
endif

TARGETS += lv2_sep

TARGETS += vst

all: $(TARGETS)

# --------------------------------------------------------------
