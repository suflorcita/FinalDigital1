-- Sol Ayelen Cataldo 
-- Bloque para la vga completa 

entity vga is
	port(
		-- Entradas--
		-- Colores --
		red_i : in bit;
		grn_i : in bit;
		blu_i : in bit;
		
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		
		-- Salidas--
		red_o: in bit; 
		grn_o: in bit; 
		blu_o: in bit; 
		
		hsync_out_vga: out bit; -- Señal de sincronismo horizontal
		vsync_out_vga: out bit; -- Señal de sincronismo vertical
		
		pixel_x: out bit_vector(9 downto 0); -- posición del pixel en y
		pixel_y: out bit_vector(9 downto 0); -- posición del pixel en x
		
		
		);
	end;


architecture vga_arq of vga is
	component gensinc is -- Declaro el generador de sincronismos 
		port(
		-- Entradas--
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		
		-- Salidas--
		vidon: out bit; -- Se activa cuando los dos vidones estan on
		hsync_out_gen: out bit; -- Señal de sincronismo horizontal
		vsync_out_gen: out bit; -- Señal de sincronismo vertical
		pixel_x: out bit_vector(9 downto 0); -- posición del pixel en y
		pixel_y: out bit_vector(9 downto 0); -- posición del pixel en x
		
		-- Estas salidas las dejo para chequear
		hvidon: out bit; -- Se activa cuando está en on el vidon el hvidon
		vvidon: out bit -- Se activa cuando está en on el vidon el vvidon
		
		);
	end component; 
	
	-- Señales --
	signal vidon_aux: bit; -- Bit que determina el vidon del generador de sinconisom
	signal hvidon_aux: bit; -- Bit para el vidon horizontal
	signal vvidon_aux: bit; -- Bit para el vidon vertical 
	
	
begin

	gen_sinc: gensinc -- Mapeo en el generador de sincronismos
		port map(
			-- Entradas--
			clk_in => clk_in,
			rst_in  => clk_in,
			ena_in  => clk_in,
			
			-- Salidas--
			vidon => vidon_aux, -- Se activa cuando los dos vidones estan on
			hsync_out_gen =>  hsync_out_vga, -- Señal de sincronismo horizontal
			vsync_out_gen =>  vsync_out_vga,  -- Señal de sincronismo vertical
			pixel_x => pixel_x,  -- posición del pixel en y
			pixel_y => pixel_y,  -- posición del pixel en x
			
			-- Estas salidas las dejo para chequear
			hvidon => hvidon_aux, -- Se activa cuando está en on el vidon el hvidon
			vvidon  => vvidon_aux, -- Se activa cuando está en on el vidon el vvidon
		); 
	
	
		
	red_o 	<= red_i and vidon;
	green_o <= green_i and vidon;
	blue_o <= blue_i and vidon;
	
end;  
