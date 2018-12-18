# VGA controller test
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.result import TestFailure
import random

@cocotb.test()
def vga_controller_test(dut):
    print('Started VGA controller test')
    
    # Generate clock signal with frequency of 25 MHz
    cocotb.fork(Clock(dut.clock,40).start())
    
    # Drive reset line high, wait then drive low
    dut.reset <= 1
    yield Timer(100)
    dut.reset <= 0
    
    
    yield RisingEdge(dut.o_done)

    # Print out serial stream out
    
    yield Timer(2)
    
    print('Simulation ended')
    
    
    
  

        
