TOPLEVEL_LANG ?= vhdl

PWD=$(shell pwd)
COCOTB=/c/cocotb

ifeq ($(OS),Msys)
WPWD=$(shell sh -c 'pwd -W')
PYTHONPATH := $(WPWD)/../model;$(PYTHONPATH)
else
WPWD=$(shell pwd)
PYTHONPATH := $(WPWD)/../model:$(PYTHONPATH)
endif

ifeq ($(TOPLEVEL_LANG),verilog)
    VERILOG_SOURCES = $(WPWD)/../hdl/adder.v
else ifeq ($(TOPLEVEL_LANG),vhdl)
    VHDL_SOURCES = $(WPWD)/../../source/gray_counter.vhd
else
    $(error "A valid value (verilog or vhdl) was not provided for TOPLEVEL_LANG=$(TOPLEVEL_LANG)")
endif

TOPLEVEL := gray_counter
MODULE   := test_gray_counter

include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim
