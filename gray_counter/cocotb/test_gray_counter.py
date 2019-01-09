# gray counter test
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.result import TestFailure
import random

@cocotb.test()
def gray_counter_test(dut):
    print('Started gray counter test')
    
    # Generate clock signal with frequency of 100 MHz
    cocotb.fork(Clock(dut.clock,10).start())
    
    # Drive reset line high, wait then drive low
    dut.reset <= 1
    yield Timer(100)
    dut.reset <= 0
    
    # Wait until output is 0b1000 gray or wait until counter reaches 1000
    
    counter = 0
    success = 0;
    
    while True:
        value = yield get_signal(dut.clock,dut.o_gray)
        if value == 0b1000:
            success = 1
            break
        elif counter == 999:
            break
        else:
            counter += 1;
    
    if success == 1:
        print('Gray code done')
    else:
        print('Simulation failed')
        
@cocotb.coroutine
def get_signal(clk,signal):
    
    yield RisingEdge(clk)
    return signal.value