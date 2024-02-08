#!/bin/bash
ghdl -s ../../fuentes/vga/comp_10_bits_n.vhd ../../fuentes/vga/comp_10_bits_n_tb.vhd
ghdl -a ../../fuentes/vga/comp_10_bits_n.vhd ../../fuentes/vga/comp_10_bits_n_tb.vhd
ghdl -e comp_10_bits_n_tb
ghdl -r comp_10_bits_n_tb --vcd=comp_10_bits_n_tb.vcd --stop-time=1000000ns
gtkwave comp_10_bits_n_tb.vcd
