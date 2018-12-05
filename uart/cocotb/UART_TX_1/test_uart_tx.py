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
    
    dut.i_data_in <= 0x68
    dut.i_data_valid <= 1
    
    yield FallingEdge(dut.o_busy)
    dut.i_data_in <= 0x65
    
    yield FallingEdge(dut.o_busy)
    dut.i_data_in <= 0x6c
    
    yield FallingEdge(dut.o_busy)
    dut.i_data_in <= 0x6c
    
    yield FallingEdge(dut.o_busy)
    dut.i_data_in <= 0x6f
    
    yield FallingEdge(dut.o_busy)
    dut.i_data_in <= 0x20
    
    yield FallingEdge(dut.o_busy)
    dut.i_data_in <= 0x77
    
    yield FallingEdge(dut.o_busy)
    dut.i_data_in <= 0x6f
    
    yield FallingEdge(dut.o_busy)
    dut.i_data_in <= 0x72
    
    yield FallingEdge(dut.o_busy)
    dut.i_data_in <= 0x6c
    
    yield FallingEdge(dut.o_busy)
    dut.i_data_in <= 0x64
    
    yield FallingEdge(dut.o_busy)
    dut.i_data_in <= 0x0a
   
    # Print out serial stream out
    
    yield Timer(2)
    
    print('Simulation ended')
    
    
    
  

        
