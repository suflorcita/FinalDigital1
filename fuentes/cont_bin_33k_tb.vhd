-- Sol Ayelen Cataldo 
-- TB para contador de 33k
entity cont_bin_33k_tb is
end entity cont_bin_33k_tb;

architecture cont_bin_33k_tb_arq of cont_bin_33k_tb is

    -- Componentes
    component cont_bin_33k
	port(
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		q_o : out bit_vector(15 downto 0); -- Salida del contador binario 
		rst_o : out bit; 	-- Salida que va hacia el reset del contador BCD
		ena_o : out bit	-- Salida que va hacia el enable del registro
		);
    end component;

    -- Señales
    signal clk_tb : bit := '1';
    signal rst_tb : bit := '0';
    signal ena_tb : bit := '1';
    signal q_tb : bit_vector(15 downto 0);
    signal rst_o_tb : bit;
    signal ena_o_tb : bit;
begin
    clk_tb <= not clk_tb after 10 ns; -- Reloj

    DUT : cont_bin_33k
        port map (
            clk_in => clk_tb,
            rst_in => rst_tb,
            ena_in => ena_tb,
            q_o => q_tb,
            rst_o => rst_o_tb,
            ena_o => ena_o_tb
        );

end architecture cont_bin_33k_tb_arq;

