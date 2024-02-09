-- Sol Ayelen Cataldo 
-- Contador De 1s: Los 5 contadores BCD en cascada 

entity cont_bcd_n is
	port(
		clk_i : in bit;
		rst_i : in bit;
		ena_i : in bit;
		q_o : out bit_vector(19 downto 0) -- Los bits de salida 
		);
	end;


architecture cont_bcd_n_arq of cont_bcd_n is
	component cont_BCD is -- Declaro un contador BCD
		port(
			clk_i : in bit;
			rst_i : in bit;
			ena_i : in bit;
			q_o : out bit_vector(3 downto 0)
			);
	end component;
	
	signal enable_aux: bit_vector(4 downto 0); -- Son los habilitadores de cada contador
	signal q_aux0: bit_vector(3 downto 0); -- Las salidas de cada contador
	signal q_aux1: bit_vector(3 downto 0); 
	signal q_aux2: bit_vector(3 downto 0); 
	signal q_aux3: bit_vector(3 downto 0); 
	signal q_aux4: bit_vector(3 downto 0); 
begin 
	enable_aux(0) <= ena_i; -- Asigno el enable de la entrada al primer contador
	
	bcd0:  cont_BCD -- Primer contador
		port map (
			clk_i => clk_i, -- Clock de la entrada
			rst_i => rst_i, -- Reset de la entrada 
			ena_i => enable_aux(0),
			q_o => q_aux0
			);
			
	enable_aux(1) <= enable_aux(0) and (q_aux0(0) and not q_aux0(1) and not q_aux0(2) and q_aux0(3)); 
	-- Cuando es un 9 habilita al proximo contador
	bcd1:  cont_BCD -- Segundo contador
		port map (
			clk_i => clk_i,
			rst_i => rst_i, 
			ena_i => enable_aux(1), 
			q_o => q_aux1
			);
			
	enable_aux(2) <= enable_aux(1) and (q_aux1(0) and not q_aux1(1) and not q_aux1(2) and q_aux1(3));
	bcd2:  cont_BCD -- Tercer contador
		port map (
			clk_i => clk_i, -- Clock de la entrada
			rst_i => rst_i, -- Reset de la entrada 
			ena_i => enable_aux(2), 
			q_o => q_aux2
			);
			
	enable_aux(3) <= enable_aux(2) and (q_aux2(0) and not q_aux2(1) and not q_aux2(2) and q_aux2(3));
	bcd3:  cont_BCD -- Cuarto contador
		port map (
			clk_i => clk_i, -- Clock de la entrada
			rst_i => rst_i, -- Reset de la entrada 
			ena_i => enable_aux(3), 
			q_o => q_aux3
			);
			
	enable_aux(4) <= enable_aux(3) and (q_aux3(0) and not q_aux3(1) and not q_aux3(2) and q_aux3(3));
	bcd4:  cont_BCD -- Quinto contador
		port map (
			clk_i => clk_i, -- Clock de la entrada
			rst_i => rst_i, -- Reset de la entrada 
			ena_i => enable_aux(4), 
			q_o => q_aux4
			);
			
	q_o <= q_aux4 & q_aux3 & q_aux2 & q_aux1 & q_aux0;
			
end;  
