#!/bin/bash -f
xv_path="/opt/Xilinx/Vivado/2017.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xelab -wto a97a15529b764f88aa205993e6f78d07 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot freq_divider_tb_behav xil_defaultlib.freq_divider_tb -log elaborate.log
