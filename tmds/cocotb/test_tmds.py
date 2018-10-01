# Simple tests for an tmds encoder module
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge
from cocotb.result import TestFailure
import random

@cocotb.test()
def test_tmds(dut):
    print('Started tmds encoder test')
    
    # Generate clock signal with frequency of 100 MHz
    cocotb.fork(Clock(dut.clock,10).start())
    
    # Drive reset line high, wait then drive low
    yield Timer(10)
    dut.i_data_enable <= 1;
    dut.i_data_in <= 0b10101011
    yield Timer(10)
    dut.i_data_in <= 0b10001001
    yield Timer(10)
    dut.i_data_in <= 0b11111111
    yield Timer(10)
    dut.i_data_in <= 0b00000000
    yield Timer(10*1000)
    
    print('Simulation ended')
    
    
    
  

        
