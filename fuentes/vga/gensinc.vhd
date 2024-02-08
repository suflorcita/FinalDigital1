-- Sol Ayelen Cataldo 
-- Bloque para el generador de sincronismos 

entity gensinc is
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
	end;


architecture gensin_arq of gensinc is
	component hsync is -- Declaro el contador horizontal
		port(
			-- Entradas--
			clk_in : in bit;
			rst_in : in bit;
			ena_in : in bit;
			
			-- Salidas--
			max_cuenta: out bit; -- Se activa cuando el contador llega a 799
			hvidon: out bit; -- Se activa cuando el contador llega a 639
			hsync_out: out bit; -- Se activa cuando el contador está entre 655 y 751
			pixel_x: out bit_vector(9 downto 0) -- posición del pixel en x (10 bits porque va a llegar hasta 799)
		);
	end component; 
	
	component vsync is -- Declaro el contador vertical
		port(
			-- Entradas--
			clk_in : in bit;
			rst_in : in bit;
			ena_in : in bit;
			
			-- Salidas--
			vvidon: out bit; -- Se activa cuando el contador llega a 474
			vsync_out: out bit; -- Se activa cuando el contador está entre 489 y 491
			pixel_y: out bit_vector(9 downto 0) -- posición del pixel en y (10 bits porque va a llegar hasta 525)
		);
	end component; 
	
	
	-- Señales --
	signal enable_contv: bit; -- Es un bit que determina cuando empieza el contador vertical
	signal vvidon_out: bit; -- Auxiliar para el vidon vertical
	signal hvidon_out: bit; -- Auxiliar para el vidon horizontal
	
	
	
begin

	cont_h: hsync -- Mapeo en el contador horizontal
		port map(
			-- Entradas--
			clk_in => clk_in,
			rst_in => rst_in,
			ena_in => ena_in,
			
			-- Salidas--
			max_cuenta => enable_contv, 
			hvidon => hvidon_out, 
			hsync_out => hsync_out_gen, 
			pixel_x => pixel_x 		
		
		); 
		
	cont_v: vsync -- Mapeo en el contador vertical
		port map(
			-- Entradas--
			clk_in => clk_in,
			rst_in => rst_in,  
			ena_in => enable_contv, 
			
			-- Salidas--
			vvidon => vvidon_out,
			vsync_out => vsync_out_gen, 
			pixel_y => pixel_y 
		);
		
	vvidon <= vvidon_out; 
	hvidon <= hvidon_out; 
	vidon <= vvidon_out and hvidon_out; 
	
end;  
