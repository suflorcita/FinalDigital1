-- Sol Ayelen Cataldo 
-- Voltimetro que es la suma de todos los caracteres
entity voltimetro_tb is
end entity voltimetro_tb;

architecture voltimetro_tb_arq of voltimetro_tb is
	component voltimetro is 
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
	end component;
	
	signal clk_tb: bit;
	signal rst_tb: bit:= '0'; 
	
	signal sal_unos_tb: bit; 
	signal hs_tb: bit; 
	signal vs_tb: bit;
	signal red_o_tb: bit; 
	signal grn_o_tb: bit;
	signal blu_o_tb: bit;

begin
	clk_tb <= not clk_tb after 10 ns;
		
	dut: voltimetro
		port map(
			clk_in => clk_tb,
			rst_i => rst_tb, 
			ent_unos => '1', 
			
			--- Salidas 
			sal_unos => sal_unos_tb, 
			hs => hs_tb, 
			vs => vs_tb, 
			red_o => red_o_tb, 
			grn_o => grn_o_tb, 
			blu_o => blu_o_tb
		
		
		); 
	
end architecture voltimetro_tb_arq;
