#!/bin/bash
ghdl -s ../../fuentes/vga/ffd.vhd ../../fuentes/vga/cont_bin.vhd ../../fuentes/vga/cont_bin_10.vhd ../../fuentes/vga/comp_10_bits_n.vhd ../../fuentes/vga/hsync.vhd ../../fuentes/vga/vsync.vhd ../../fuentes/vga/gensinc.vhd ../../fuentes/vga/vga.vhd ../../fuentes/vga/vga_tb.vhd
ghdl -a ../../fuentes/vga/ffd.vhd ../../fuentes/vga/cont_bin.vhd ../../fuentes/vga/cont_bin_10.vhd ../../fuentes/vga/comp_10_bits_n.vhd ../../fuentes/vga/hsync.vhd ../../fuentes/vga/vsync.vhd ../../fuentes/vga/gensinc.vhd  ../../fuentes/vga/vga.vhd ../../fuentes/vga/vga_tb.vhd
ghdl -e vga_tb
ghdl -r vga_tb --vcd=vga_tb.vcd --stop-time=10000000ns
gtkwave vga_tb.vcd
