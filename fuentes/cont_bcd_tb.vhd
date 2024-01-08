
entity cont_bcd_tb is
end;

architecture cont_bcd_tb_arq of cont_bcd_tb is
	component cont_bcd is
		port(
			clk_i : in bit;
			rst_i : in bit;
			ena_i : in bit;
			q_o : out bit_vector(3 downto 0)
		);
	end component;
	
	signal clk_tb: bit := '1';
	signal rst_tb: bit := '1';
	signal ena_tb: bit := '1';
	signal q_tb: bit_vector (3 downto 0);
begin
	clk_tb <= not clk_tb after 10 ns;
	rst_tb <= '0' after 10 ns;
	
	DUT: cont_bcd
		port map(
			clk_i => clk_tb,
			rst_i => rst_tb,
			ena_i => ena_tb,
			q_o => q_tb
		);
end architecture cont_bcd_tb_arq;
