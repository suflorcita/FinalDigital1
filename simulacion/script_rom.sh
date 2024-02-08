#!/bin/bash
ghdl -s ../fuentes/rom.vhd ../fuentes/rom_tb.vhd  
ghdl -a ../fuentes/rom.vhd ../fuentes/rom_tb.vhd  
ghdl -e rom_tb
ghdl -r rom_tb --vcd=rom_tb.vcd --stop-time=100000ns
gtkwave rom_tb.vcd
