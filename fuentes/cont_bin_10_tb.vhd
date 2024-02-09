-- Sol Ayelen Cataldo 
-- TB para contador de 10
entity cont_bin_10_tb is
end entity cont_bin_10_tb;

architecture cont_bin_10_tb_arq of cont_bin_10_tb is

    -- Componentes
    component cont_bin_10
        generic (
		N: natural := 10  -- Cantidad de bits
	);
	port(
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		q_o : out bit_vector(N - 1 downto 0) -- Salida del contador binario 
		);
    end component;

    -- Señales
    signal clk_tb : bit := '1';
    signal rst_tb : bit := '0';
    signal ena_tb : bit := '1';
    signal q_tb : bit_vector(9 downto 0);
  
begin
    clk_tb <= not clk_tb after 10 ns; -- Reloj

    DUT : cont_bin_10
        port map (
            clk_in => clk_tb,
            rst_in => rst_tb,
            ena_in => ena_tb,
            q_o => q_tb
        );

end architecture cont_bin_10_tb_arq;

