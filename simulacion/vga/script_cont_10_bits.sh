#!/bin/bash
ghdl -s ../../fuentes/vga/ffd.vhd ../../fuentes/vga/cont_bin.vhd ../../fuentes/vga/cont_bin_10.vhd ../../fuentes/vga/cont_bin_10_tb.vhd
ghdl -a ../../fuentes/vga/ffd.vhd ../../fuentes/vga/cont_bin.vhd ../../fuentes/vga/cont_bin_10.vhd ../../fuentes/vga/cont_bin_10_tb.vhd
ghdl -e cont_bin_10_tb
ghdl -r cont_bin_10_tb --vcd=cont_bin_10_tb.vcd --stop-time=1000000ns
gtkwave cont_bin_10_tb.vcd
