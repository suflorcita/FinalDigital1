#!/bin/bash
ghdl -s ../fuentes/ffd.vhd ../fuentes/registro.vhd ../fuentes/registro_tb.vhd  
ghdl -a ../fuentes/ffd.vhd ../fuentes/registro.vhd ../fuentes/registro_tb.vhd 
ghdl -e registro_tb
ghdl -r registro_tb --vcd=registro_tb.vcd --stop-time=1000000ns
gtkwave registro_tb.vcd
