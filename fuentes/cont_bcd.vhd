entity cont_bcd is
	port(
		clk_i : in bit;
		rst_i : in bit;
		ena_i : in bit;
		q_o : out bit_vector(3 downto 0) -- 4 Bits de salida del contador BCD
		);
	end;


architecture cont_bcd_arq of cont_bcd is
	component ffd is -- declaro el ffd
		port(
			clk_i: in bit; --clock
			rst_i: in bit; --reset
			ena_i: in bit; --enable
			d_i: in bit; -- D
			q_o: out bit -- Q
			 ); 
	end component;
	
	signal q_aux: bit_vector(3 downto 0); 
	signal d_aux: bit_vector(3 downto 0);


begin 
	d_aux(3) <= (q_aux(2) and q_aux(1) and q_aux(0)) or (q_aux(3) and not q_aux(0));
	d_aux(2) <= (q_aux(2) and not q_aux(1)) or (q_aux(2) and not q_aux(0)) or (not q_aux(2) and q_aux(1) and q_aux(0));
	d_aux(1) <= (q_aux(1) and not q_aux(0)) or (not q_aux(3) and not q_aux(1) and q_aux(0));
	d_aux(0) <= not q_aux(0);
	q_o <= q_aux;
	
	ffd_3: ffd
		port map(
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			d_i => d_aux(3),
			q_o => q_aux(3)
		);
	
	ffd_2: ffd
		port map(
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			d_i => d_aux(2),
			q_o => q_aux(2)
		);
		
	ffd_1: ffd
		port map(
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			d_i => d_aux(1),
			q_o => q_aux(1)
		);
	
	ffd_0: ffd
		port map(
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			d_i => d_aux(0),
			q_o => q_aux(0)
		);


end;  
