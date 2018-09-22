if [file exists work] {vdel -lib work -all}
vlib work
vmap -c
vmap work work
vcom -work work  D:/git_repos/VHDL/lfsr/cocotb/../source/lfsr.vhd
vsim -onfinish stop -foreign "cocotb_init libfli.dll" work.lfsr
add wave -recursive /*
