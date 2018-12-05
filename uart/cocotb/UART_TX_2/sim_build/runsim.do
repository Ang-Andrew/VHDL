if [file exists work] {vdel -lib work -all}
vlib work
vmap -c
vmap work work
vcom -work work  D:/git_repos/VHDL/uart/cocotb/UART_TX_2/../../source/uart_tx_hello_world.vhd
vsim -onfinish exit -foreign "cocotb_init libfli.dll" uart_tx_hello_world
onbreak resume
run -all
quit
