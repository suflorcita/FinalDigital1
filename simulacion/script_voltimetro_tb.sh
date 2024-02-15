#!/bin/bash
ghdl -s ../fuentes/conversorADC.vhd ../fuentes/cont_bin_33k.vhd ../fuentes/cont_bin.vhd ../fuentes/cont_bcd_n.vhd ../fuentes/cont_bcd.vhd ../fuentes/registro_4bits.vhd ../fuentes/mux.vhd ../fuentes/logica.vhd ../fuentes/rom.vhd ../fuentes/ffd.vhd ../fuentes/cont_bin_10.vhd ../fuentes/comp_10_bits_n.vhd ../fuentes/hsync.vhd ../fuentes/vsync.vhd ../fuentes/gensinc.vhd ../fuentes/vga.vhd ../fuentes/cont_2bits.vhd ../fuentes/voltimetro.vhd ../fuentes/voltimetro_tb.vhd
ghdl -a ../fuentes/conversorADC.vhd ../fuentes/cont_bin_33k.vhd ../fuentes/cont_bin.vhd ../fuentes/cont_bcd_n.vhd ../fuentes/cont_bcd.vhd ../fuentes/registro_4bits.vhd ../fuentes/mux.vhd ../fuentes/logica.vhd ../fuentes/rom.vhd ../fuentes/ffd.vhd  ../fuentes/cont_bin_10.vhd ../fuentes/comp_10_bits_n.vhd ../fuentes/hsync.vhd ../fuentes/vsync.vhd ../fuentes/gensinc.vhd ../fuentes/vga.vhd ../fuentes/cont_2bits.vhd ../fuentes/voltimetro.vhd ../fuentes/voltimetro_tb.vhd
ghdl -e voltimetro_tb
ghdl -r voltimetro_tb --vcd=voltimetro_tb.vcd --stop-time=50000000ns
gtkwave voltimetro_tb.vcd
