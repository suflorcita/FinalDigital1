#!/bin/bash
ghdl -s ../fuentes/ffd.vhd ../fuentes/registro.vhd ../fuentes/registro_4bits.vhd  ../fuentes/registro_4bits_tb.vhd  
ghdl -a ../fuentes/ffd.vhd ../fuentes/registro.vhd ../fuentes/registro_4bits.vhd ../fuentes/registro_4bits_tb.vhd  
ghdl -e registro_4bits_tb
ghdl -r registro_4bits_tb --vcd=registro_4bits_tb.vcd --stop-time=1000000ns
gtkwave registro_4bits_tb.vcd
