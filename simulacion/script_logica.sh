#!/bin/bash
ghdl -s ../fuentes/logica.vhd ../fuentes/logica_tb.vhd 
ghdl -a ../fuentes/logica.vhd ../fuentes/logica_tb.vhd  
ghdl -e logica_tb
ghdl -r logica_tb --vcd=logica_tb.vcd --stop-time=1000000ns
gtkwave logica_tb.vcd
