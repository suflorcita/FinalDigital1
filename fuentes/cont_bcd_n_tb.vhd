entity cont_bcd_n_tb is
end;

architecture cont_bcd_n_tb_arq of cont_bcd_n_tb is
    
    -- Componentes
    component cont_bcd_n is
        port (
            clk_i : in bit;
            rst_i : in bit;
            ena_i : in bit;
            q_o : out bit_vector(19 downto 0) -- Los bits de salida 
        );
    end component;
    
    -- Señales
    signal clk_tb: bit := '1';
    signal rst_tb: bit := '0';
    signal ena_tb: bit := '1';
    signal q_tb: bit_vector (19 downto 0);
    
begin
    clk_tb <= not clk_tb after 5 ns;
    
    DUT: cont_bcd_n
        port map (
            clk_i => clk_tb,
            rst_i => rst_tb,
            ena_i => ena_tb,
            q_o => q_tb
        );
end architecture cont_bcd_n_tb_arq;
