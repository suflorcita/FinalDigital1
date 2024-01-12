#!/bin/bash
ghdl -s ../fuentes/ffd.vhd ../fuentes/cont_bcd.vhd ../fuentes/cont_bcd_tb.vhd
ghdl -a ../fuentes/ffd.vhd ../fuentes/cont_bcd.vhd ../fuentes/cont_bcd_tb.vhd
ghdl -e cont_bcd_tb
ghdl -r cont_bcd_tb --vcd=cont_bcd_tb.vcd --stop-time=1000000ns
gtkwave cont_bcd_tb.vcd




