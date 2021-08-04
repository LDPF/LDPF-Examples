#!/usr/bin/make -f
# Makefile for LDPF Example Plugins #
# --------------------------------- #
#

# --------------------------------------------------------------

# Path to directory with subdirectories "dpf" and "ldpf" and 
# file "config.mk"
LDPF_ROOT_PATH   := .

# --------------------------------------------------------------

# List of plugin directories
LDPF_PLUGINS := plugins/example01 \
                plugins/example02 \
                plugins/example03


# --------------------------------------------------------------

include ldpf/Makefile.root.mk
