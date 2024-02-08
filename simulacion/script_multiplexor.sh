#!/bin/bash
ghdl -s ../fuentes/mux.vhd ../fuentes/mux_tb.vhd  
ghdl -a ../fuentes/mux.vhd ../fuentes/mux_tb.vhd  
ghdl -e mux_tb
ghdl -r mux_tb --vcd=mux_tb.vcd --stop-time=100000ns
gtkwave mux_tb.vcd
