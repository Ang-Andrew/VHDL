# Simple tests for an l module
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge
from cocotb.result import TestFailure
import random

@cocotb.test()
def lfsr_test(dut):
    print('Started lfsr test')
    
    # Generate clock signal with frequency of 100 MHz
    cocotb.fork(Clock(dut.clock,10).start())
    
    # Drive reset line high, wait then drive low
    dut.reset <= 1
    yield Timer(100)
    dut.reset <= 0
    
    yield Timer(100)
    
    print('Simulation ended')
    
    
    
  

        
