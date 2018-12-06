# UART TX test
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.result import TestFailure
import random

@cocotb.test()
def uart_tx_test(dut):
    print('Started UART TX test')
    
    # Generate clock signal with frequency of 100 MHz
    cocotb.fork(Clock(dut.clock,10).start())
    
    # Drive reset line high, wait then drive low
    dut.reset <= 1
    yield Timer(100)
    dut.reset <= 0
    
    # Send data to be sent to UART TX module with valid data input
    
    dut.i_start <= 1;
    yield RisingEdge(dut.o_done)

    # Print out serial stream out
    
    yield Timer(2)
    
    print('Simulation ended')
    
    
    
  

        
