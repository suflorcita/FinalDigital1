-- Sol Ayelen Cataldo 
-- TB para contador de 2bits

entity cont_2bits_tb is
end entity cont_2bits_tb;

architecture cont_2bits_tb_arq of cont_2bits_tb is

    -- Componentes
    component cont_2bits
	port(
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		q_o : out bit_vector(1 downto 0) -- Salida del contador binario 
		);
    end component;

    -- Señales
    signal clk_tb : bit := '1';
    signal rst_tb : bit := '0';
    signal ena_tb : bit := '1';
    signal q_tb : bit_vector(1 downto 0);

begin
    clk_tb <= not clk_tb after 10 ns; -- Reloj

    DUT : cont_2bits
        port map (
            clk_in => clk_tb,
            rst_in => rst_tb,
            ena_in => ena_tb,
            q_o => q_tb
        );

end architecture cont_2bits_tb_arq;

