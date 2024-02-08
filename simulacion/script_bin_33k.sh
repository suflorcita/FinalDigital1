#!/bin/bash
ghdl -s ../fuentes/ffd.vhd ../fuentes/cont_bin.vhd ../fuentes/cont_bin_33k.vhd  ../fuentes/cont_bin_33k_tb.vhd
ghdl -a ../fuentes/ffd.vhd ../fuentes/cont_bin.vhd ../fuentes/cont_bin_33k.vhd ../fuentes/cont_bin_33k_tb.vhd
ghdl -e cont_bin_33k_tb
ghdl -r cont_bin_33k_tb --vcd=cont_bin_33k_tb.vcd --stop-time=1000000ns
gtkwave cont_bin_33k_tb.vcd
