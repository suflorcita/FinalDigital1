#!/bin/bash
ghdl -s ../fuentes/ffd.vhd ../fuentes/cont_bin.vhd ../fuentes/cont_2bits.vhd  ../fuentes/cont_2bits_tb.vhd
ghdl -a ../fuentes/ffd.vhd ../fuentes/cont_bin.vhd ../fuentes/cont_2bits.vhd ../fuentes/cont_2bits_tb.vhd
ghdl -e cont_2bits_tb
ghdl -r cont_2bits_tb --vcd=cont_2bits_tb.vcd --stop-time=1000000ns
gtkwave cont_2bits_tb.vcd
