TOPLEVEL_LANG ?= vhdl

PWD=$(shell pwd)
COCOTB=/c/cocotb-6c432ee73

ifeq ($(OS),Msys)
WPWD=$(shell sh -c 'pwd -W')
endif

VHDL_SOURCES = $(WPWD)/../source/tmds_encoder.vhd
TOPLEVEL := tmds_encoder
MODULE   := test_tmds

include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim
