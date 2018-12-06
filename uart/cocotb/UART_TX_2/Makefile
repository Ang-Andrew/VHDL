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

VHDL_SOURCES = $(WPWD)/../../source/uart_tx.vhd
VHDL_SOURCES += $(WPWD)/../../source/uart_tx_hello_world.vhd

TOPLEVEL = uart_tx_hello_world
MODULE = test_uart_tx_hello_world_state_machine

include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim
