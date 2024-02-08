#!/bin/bash
ghdl -s ../../fuentes/vga/ffd.vhd ../../fuentes/vga/cont_bin.vhd ../../fuentes/vga/cont_bin_10.vhd ../../fuentes/vga/comp_10_bits_n.vhd ../../fuentes/vga/vsync.vhd ../../fuentes/vga/vsync_tb.vhd
ghdl -a ../../fuentes/vga/ffd.vhd ../../fuentes/vga/cont_bin.vhd ../../fuentes/vga/cont_bin_10.vhd ../../fuentes/vga/comp_10_bits_n.vhd ../../fuentes/vga/vsync.vhd ../../fuentes/vga/vsync_tb.vhd
ghdl -e vsync_tb
ghdl -r vsync_tb --vcd=vsync_tb.vcd --stop-time=1000000ns
gtkwave vsync_tb.vcd
