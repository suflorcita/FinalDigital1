-- Sol Ayelen Cataldo 
-- Bloque para el contador vertical

entity vsync is
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
	end;


architecture vsync_arq of vsync is
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
	-- Auxiliares para el contador vertical
	signal rst_contv: bit; -- Reset del contador vertical
	signal out_contv: bit_vector(9 downto 0); -- Salida del contador vertical
	
	-- Auxiliares para el comparador 524
	signal out_comp_524: bit; 
	
	-- Auxiliares para el comparador 479
	signal out_comp_479: bit; 
	
	-- Auxiliares para el comparador 489
	signal out_comp_489: bit; 
	
	-- Auxiliares para el comparador 491
	signal out_comp_491: bit; 
	
	-- Auxiliar para el ffd del vvidon
	signal d_vvidon: bit:= '1';
	signal q_vvidon: bit; 
	signal ena_vidon: bit; 
	signal rst_vidon: bit;
	
	-- Auxiliar para el ffd del vsync
	signal d_vsync: bit:= '1';
	signal q_vsync: bit;
	signal ena_vsync: bit; 
	signal rst_vsync: bit;
	
	
begin
	cont_ver: cont_bin_10  -- Mapeo en el contador vertical
		port map(
			clk_in => clk_in,
			ena_in => ena_in,
			
			rst_in => rst_contv, 
			q_o => out_contv
		); 
		
	-- Comparadores
	comp_524: comp_10_bits_n -- Mapeo en el comparador de 524
		port map(
			a => "1000001100", -- 524
			b => out_contv,
			
			comp_out => out_comp_524
			
		); 
		
	comp_479: comp_10_bits_n -- Mapeo en el comparador de 479
		port map(
			a => "0111011111", -- 479
			b => out_contv,
			
			comp_out => out_comp_479
			
		); 
	
	comp_489: comp_10_bits_n-- Mapeo en el comparador de 489
		port map(
			a => "0111101001", -- 489
			b => out_contv,
			
			comp_out => out_comp_489
			
		);
		
	comp_491: comp_10_bits_n -- Mapeo en el comparador de 491
		port map(
			a => "0111101011" , -- 491
			b => out_contv,
			
			comp_out => out_comp_491
			
		); 

	-- Reset del contador vertical
	rst_contv <= (out_comp_524 and ena_in) or rst_in;  -- Que llegue a 524 y ademas el enable esté arriba o reset externo
	
	-- Mapeo los dos FFD que voy a usar para el vidon y el sync	
	ena_vidon <= out_comp_479 and ena_in; 
	rst_vidon <= out_comp_524 and ena_in; 
	
	ffd_vvidon : ffd 
		port map(
			clk_i => clk_in,
			rst_i => rst_vidon,
			ena_i => ena_vidon, 
			d_i => d_vvidon,
			q_o => q_vvidon
	
	); 
	
	-- Mapeo los dos FFD que voy a usar para el vidon y el sync	
	ena_vsync <= out_comp_489 and ena_in; 
	rst_vsync <= out_comp_491 and ena_in; 
	
	
	ffd_vsync : ffd 
		port map(
			clk_i => clk_in,
			rst_i => rst_vsync,
			ena_i => ena_vsync, 
			d_i => d_vsync, 
			q_o => q_vsync
	
	); 
	
	--Salida generales
	
	vvidon <= not q_vvidon; -- Se activa cuando el contador llega a 479
	vsync_out <= not q_vsync; -- Se activa cuando el contador está entre 489 y 491
	pixel_y <= out_contv; 
	
	
	
end;  
