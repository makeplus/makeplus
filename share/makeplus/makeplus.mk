SHELL := bash

# Make sure we are being run by GNU make:
ifneq ($(shell [[ `${MAKE} -v` =~ ^GNU ]] || echo fail),)
  $(error MakePlus must be run using GNU make)
endif

# Find MakePlus install prefix. Look for this makeplus.mk Makefile:
MAKEPLUS_ROOT := $(patsubst \
  %/share/makeplus/makeplus.mk,%,$(filter \
  %makeplus.mk,$(MAKEFILE_LIST)))

# Set MAKEPLUS variables:
MAKEPLUS_BIN := $(MAKEPLUS_ROOT)/bin
MAKEPLUS_LIB := $(MAKEPLUS_ROOT)/lib/makeplus
MAKEPLUS_PATH := $(MAKEPLUS_LIB)

# Generate the working end of MakePlus, and include the result:
include $(shell \
  $(MAKEPLUS_LIB)/makeplus-generate \
    $(firstword $(MAKEFILE_LIST)) \
    $${MAKEPLUS_MAKEFILE:-$$(mktemp)} \
    $(MAKEPLUS_ROOT) \
  || echo MAKEPLUS-MAKEFILE-GENERATION-FAILURE)
