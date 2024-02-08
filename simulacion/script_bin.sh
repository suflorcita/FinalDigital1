#!/bin/bash
ghdl -s ../fuentes/ffd.vhd ../fuentes/cont_bin.vhd ../fuentes/cont_bin_tb.vhd
ghdl -a ../fuentes/ffd.vhd ../fuentes/cont_bin.vhd ../fuentes/cont_bin_tb.vhd
ghdl -e cont_bin_tb
ghdl -r cont_bin_tb --vcd=cont_bin_tb.vcd --stop-time=100000ns
gtkwave cont_bin_tb.vcd




