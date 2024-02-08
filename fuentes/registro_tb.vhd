-- Sol Ayelen Cataldo 
-- TB para registro de N bits
entity registro_tb is
end; 

architecture registro_tb_arq of registro_tb is
    constant N: natural := 9;  -- Cantidad de bits

    -- Componentes
    component registro is
    	generic (
            N: natural
        );
	port(
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		d_in : in bit_vector(N -1 downto 0); -- Entrada del registro 
		q_out : out bit_vector(N -1 downto 0) -- Salida del registro
	);
    end component;

    -- Señales
    signal clk_tb : bit := '1';
    signal rst_tb : bit := '0';
    signal ena_tb : bit := '1';
    signal d_in_tb : bit_vector(N - 1 downto 0) := "100100101"; 
    signal q_out_tb : bit_vector(N -1 downto 0); 

begin
    clk_tb <= not clk_tb after 10 ns; -- Reloj
    

    DUT: registro
    	generic map (
            N => N
        )
        port map (
            clk_in => clk_tb, 
            rst_in => rst_tb,
            ena_in => ena_tb,
            d_in => d_in_tb ,
            q_out => q_out_tb
        );

end architecture registro_tb_arq;
