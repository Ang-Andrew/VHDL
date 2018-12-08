# spi master test
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge, ClockCycles
from cocotb.result import TestFailure
import random

@cocotb.test()
def spi_master_test(dut):
    print('Started SPI master test')
    
    # Generate clock signal with frequency of 100 MHz
    cocotb.fork(Clock(dut.clock,10).start())
    
    # Drive reset line high, wait then drive low
    dut.reset <= 1
    yield Timer(100)
    dut.reset <= 0
        
    yield Timer(1000)
    print('Simulation ended')