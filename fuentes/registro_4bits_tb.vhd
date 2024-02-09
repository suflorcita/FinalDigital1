-- Sol Ayelen Cataldo 
-- TB para registro de 4 bits
entity registro_4bits_tb is
end; 

architecture registro_4bits_tb_arq of registro_4bits_tb is


    -- Componentes
    component registro_4bits is
	port(
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		d_in : in bit_vector(3 downto 0); -- Entrada del registro 
		q_out : out bit_vector(3 downto 0) -- Salida del registro
	);
    end component;

    -- Señales
    signal clk_tb : bit := '1';
    signal rst_tb : bit := '0';
    signal ena_tb : bit := '1';
    signal d_in_tb : bit_vector(3 downto 0) := "1011"; 
    signal q_out_tb : bit_vector(3 downto 0); 

begin
    clk_tb <= not clk_tb after 10 ns; -- Reloj
    

    DUT: registro_4bits
        port map (
            clk_in => clk_tb, 
            rst_in => rst_tb,
            ena_in => ena_tb,
            d_in => d_in_tb ,
            q_out => q_out_tb
        );

end architecture registro_4bits_tb_arq;
