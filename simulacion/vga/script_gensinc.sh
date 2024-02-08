#!/bin/bash
ghdl -s ../../fuentes/vga/ffd.vhd ../../fuentes/vga/cont_bin.vhd ../../fuentes/vga/cont_bin_10.vhd ../../fuentes/vga/comp_10_bits_n.vhd ../../fuentes/vga/hsync.vhd ../../fuentes/vga/vsync.vhd ../../fuentes/vga/gensinc.vhd ../../fuentes/vga/gensinc_tb.vhd
ghdl -a ../../fuentes/vga/ffd.vhd ../../fuentes/vga/cont_bin.vhd ../../fuentes/vga/cont_bin_10.vhd ../../fuentes/vga/comp_10_bits_n.vhd ../../fuentes/vga/hsync.vhd ../../fuentes/vga/vsync.vhd ../../fuentes/vga/gensinc.vhd ../../fuentes/vga/gensinc_tb.vhd
ghdl -e gensinc_tb
ghdl -r gensinc_tb --vcd=gensinc_tb.vcd --stop-time=10000000ns
gtkwave gensinc_tb.vcd
