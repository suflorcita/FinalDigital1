-- Sol Ayelen Cataldo 
-- TB para contador binario
entity cont_bin_tb is
end entity cont_bin_tb;

architecture cont_bin_tb_arq of cont_bin_tb is
    constant N: natural := 5; -- Cantidad de bits

    -- Componentes
    component cont_bin
        generic (
            N: natural
        );
        port (
            clk_in : in bit;
            rst_in : in bit;
            ena_in : in bit;
            q_o : out bit_vector(N - 1 downto 0)
        );
    end component;

    -- Señales
    signal clk_tb : bit := '1';
    signal rst_tb : bit := '0';
    signal ena_tb : bit := '1';
    signal q_tb : bit_vector(N - 1 downto 0);
begin
    clk_tb <= not clk_tb after 10 ns;

    DUT : cont_bin
        generic map (
            N => N
        )
        port map (
            clk_in => clk_tb,
            rst_in => rst_tb,
            ena_in => ena_tb,
            q_o => q_tb
        );

end architecture cont_bin_tb_arq;

