#!/bin/bash
ghdl -s ../../fuentes/vga/ffd.vhd ../../fuentes/vga/cont_bin.vhd ../../fuentes/vga/cont_bin_10.vhd ../../fuentes/vga/comp_10_bits_n.vhd ../../fuentes/vga/hsync.vhd ../../fuentes/vga/hsync_tb.vhd
ghdl -a ../../fuentes/vga/ffd.vhd ../../fuentes/vga/cont_bin.vhd ../../fuentes/vga/cont_bin_10.vhd ../../fuentes/vga/comp_10_bits_n.vhd ../../fuentes/vga/hsync.vhd ../../fuentes/vga/hsync_tb.vhd
ghdl -e hsync_tb
ghdl -r hsync_tb --vcd=hsync_tb.vcd --stop-time=1000000ns
gtkwave hsync_tb.vcd
