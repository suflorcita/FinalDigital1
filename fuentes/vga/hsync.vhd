-- Sol Ayelen Cataldo 
-- Bloque para el contador horizontal

entity hsync is
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
	end;


architecture hsync_arq of hsync is
	component ffd is -- Declaro el FFD
		port(
			clk_i: in bit; --clock
			rst_i: in bit; --reset
			ena_i: in bit; --enable
			d_i: in bit; -- D
			q_o: out bit -- Q
		); 
	end component;


	component cont_bin_10 is -- Declaro el contador de 10 bits
		generic (
			N: natural := 10
		);
		port(
			clk_in : in bit;
			rst_in : in bit;
			ena_in : in bit;
			q_o : out bit_vector(N -1 downto 0) -- Salida del contador binario 
		);
	end component;
	
	component comp_10_bits_n is -- Declaro el comparador de 10 bits
		generic (
			N: natural  := 10 -- Cantidad de bits, es 10, puedo comparar números hasta el 1024
		);
		port(
			a: in bit_vector(N - 1 downto 0); -- Número a comparar 
			b: in bit_vector(N - 1 downto 0); -- Número a comparar 
			comp_out: out bit -- Salida del comparador: es 1 si son iguales, 0 en cualquier otro caso 
			);
	end component;
	
	-- Señales --
	-- Auxiliares para el contador horizontal
	signal rst_conth: bit; -- Reset del contador horizontal
	signal out_conth: bit_vector(9 downto 0); -- Salida del contador horizontal
	
	-- Auxiliares para el comparador 799
	signal out_comp_799: bit; 
	
	-- Auxiliares para el comparador 639
	signal out_comp_639: bit; 
	
	-- Auxiliares para el comparador 655
	signal out_comp_655: bit; 
	
	-- Auxiliares para el com	parador 751
	signal out_comp_751: bit; 
	
	-- Auxiliar para el ffd del hvidon
	signal d_hvidon: bit:= '1';
	signal q_hvidon: bit; 
	
	-- Auxiliar para el ffd del hsync
	signal d_hsync: bit:= '1';
	signal q_hsync: bit;
	
	
begin
	cont_hor: cont_bin_10  -- Mapeo en el contador horizontal
		port map(
			clk_in => clk_in,
			ena_in => ena_in,
			
			rst_in => rst_conth, 
			q_o => out_conth
		); 
		
	-- Comparadores
	comp_799: comp_10_bits_n -- Mapeo en el comparador de 799
		port map(
			a => "1100011111", -- 799
			b => out_conth,
			
			comp_out => out_comp_799
			
		); 
		
	comp_639: comp_10_bits_n -- Mapeo en el comparador de 639
		port map(
			a => "1001111111", -- 639
			b => out_conth,
			
			comp_out => out_comp_639
			
		); 
	
	comp_655: comp_10_bits_n-- Mapeo en el comparador de 655
		port map(
			a => "1010001111", -- 655
			b => out_conth,
			
			comp_out => out_comp_655
			
		);
		
	comp_751: comp_10_bits_n -- Mapeo en el comparador de 751
		port map(
			a => "1011101111" , -- 755
			b => out_conth,
			
			comp_out => out_comp_751
			
		); 

	-- Reset del contador horizontal
	rst_conth <= out_comp_799 or rst_in; 
	
	-- Mapeo los dos FFD que voy a usar para el vidon y el sync	
	ffd_hvidon : ffd 
		port map(
			clk_i => clk_in,
			rst_i => out_comp_799,
			ena_i => out_comp_639, 
			d_i => d_hvidon,
			q_o => q_hvidon
	
	); 
	
	ffd_hsync : ffd 
		port map(
			clk_i => clk_in,
			rst_i => out_comp_751,
			ena_i => out_comp_655, 
			d_i => d_hsync, 
			q_o => q_hsync
	
	); 
	
	--Salida generals
	max_cuenta <= out_comp_799; -- Se activa cuando el contador llega a 799
	hvidon <= not q_hvidon; -- Se activa cuando el contador llega a 639
	hsync_out <= not q_hsync; -- Se activa cuando el contador está entre 655 y 751
	pixel_x <= out_conth; 
	
	
	
end;  
