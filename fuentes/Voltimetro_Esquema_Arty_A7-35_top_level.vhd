----------------------------------------------------------------------------------
-- Modulo: 		Voltimetro_toplevel
-- Descripcion: Voltimetro implementado con un modulador sigma-delta
-- Autor: 		Electronica Digital I
--        		Universidad de San Martn - Escuela de Ciencia y Tecnologia
--
-- Fecha: 		01/09/20
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Voltimetro_toplevel is
	port(
		clk_i			: in bit;
		rst_i			: in bit;
		data_volt_in_i		: in bit;
		data_volt_out_o	: out bit;
		hs_o 			: out bit;
		vs_o 			: out bit;
		red_o 			: out bit;
		grn_o 			: out bit;
        	blu_o 			: out bit
       	);
	
	-- Mapeo de pines para el kit Arty A7-35
	attribute loc		: string;
	attribute iostandard: string;
	
	attribute loc 			of clk_i    : signal is "E3";					-- reloj del sistema (100 MHz)
	attribute iostandard 	of clk_i    : signal is "LVCMOS33";	
	attribute loc 			of rst_i    : signal is "D9";					-- senal de reset (boton 0)
    	attribute iostandard 	of rst_i    : signal is "LVCMOS33";
    	
	-- Entradas simple
	attribute loc 			of data_volt_in_i: signal is "D4";			-- entrada
	attribute iostandard 	of data_volt_in_i: signal is "LVCMOS33";

	-- Salida realimentada
	attribute loc 			of data_volt_out_o: signal is "F3";			-- realimentacion
	attribute iostandard 	of data_volt_out_o: signal is "LVCMOS33";
	
	-- VGA
	attribute loc 			of hs_o     : signal is "D12";					-- sincronismo horizontal
	attribute iostandard 	of hs_o     : signal is "LVCMOS33";
	attribute loc 			of vs_o     : signal is "K16";					-- sincronismo vertical
	attribute iostandard 	of vs_o     : signal is "LVCMOS33";
	attribute loc 			of red_o    : signal is "G13";					-- salida color rojo
	attribute iostandard 	of red_o    : signal is "LVCMOS33";
	attribute loc 			of grn_o    : signal is "B11";					-- salida color verde
	attribute iostandard 	of grn_o    : signal is "LVCMOS33";
	attribute loc 			of blu_o    : signal is "A11";					-- salida color azul
	attribute iostandard 	of blu_o    : signal is "LVCMOS33";
    
    
end Voltimetro_toplevel;

architecture Voltimetro_toplevel_arq of Voltimetro_toplevel is

	-- Declaracion del componente voltimetro
	component Voltimetro is
		port(
			clk_in : in bit;
			rst_i : in bit;
			ent_unos: in bit;  --- Entrada de unos 
			
			--- Salidas 
			sal_unos: out bit; 
			hs: out bit; -- Sincronismo horizontal
			vs: out bit; -- Sincronismo vertical
			red_o: out bit; -- Rojo
			grn_o: out bit; -- Verde
			blu_o: out bit  -- Azul


		);
	end component Voltimetro;
	
	
begin
	-- Instancia del bloque voltimetro
	inst_voltimetro: Voltimetro
		port map(
			clk_in => clk_i,
			rst_i => rst_i,
			ent_unos =>data_volt_in_i,  --- Entrada de unos 
			
			sal_unos => data_volt_out_o, 
			hs => hs_o, 
			vs => vs_o, 
			red_o => red_o, 
			grn_o => grn_o, 
			blu_o => blu_o
        );


end Voltimetro_toplevel_arq;
