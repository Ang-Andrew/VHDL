TOPLEVEL_LANG ?= vhdl

PWD=$(shell pwd)
COCOTB=/c/cocotb-6c432ee73

ifeq ($(OS),Msys)
WPWD=$(shell sh -c 'pwd -W')
endif

VHDL_SOURCES = $(WPWD)/../source/vga_controller.vhd
TOPLEVEL := vga_controller
MODULE   := test_vga_controller

include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim
