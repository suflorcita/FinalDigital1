-- Sol Ayelen Cataldo
-- TB para multiplexor 

entity mux_tb is
end; 

architecture mux_tb_arq of mux_tb is
	
	component mux is 
		port(
			-- Entradas --
			-- Dígitos --
			digito1: in bit_vector(3 downto 0); -- Este es el primer dígito (4 bits: del 0 al 9, Es lo que sale del registro)
			digito2: in bit_vector(3 downto 0); -- Segundo dígito (Decimal)
			digito3: in bit_vector(3 downto 0); -- Tercer dígito (Centesima)
			-- Caracteres--
			punto: in bit_vector(3 downto 0); -- El punto. Le vamos asignar el valor 10d (1010b)
			letra_v: in bit_vector(3 downto 0); -- La letra V de Volts. Le vamos asignar el valor 11d (1011b)
			
			-- Selector --
			selector: in bit_vector(2 downto 0); -- Selector de 3 bits porque elige entre 5 entradas. 
			
			-- Salidas --
			mux_out: out bit_vector(3 downto 0) -- El dígito seleccionado entre todas las entradas
			
		);
	end component; 
	
	
	-- Caracteres
	signal digito1_tb : bit_vector(3 downto 0) := "0010";
	signal digito2_tb : bit_vector(3 downto 0) := "0011";
	signal digito3_tb : bit_vector(3 downto 0) := "0111";
	signal punto_tb: bit_vector(3 downto 0):="1010"; 
	signal letra_v_tb : bit_vector(3 downto 0) := "1011";
	
	-- Selector
	signal selector_tb: bit_vector(2 downto 0) := "000";
	
	-- Salida
	signal mux_out_tb: bit_vector(3 downto 0);


begin
    selector_tb <= "001" after 500 ns, "010" after 1000 ns, "011" after 1500 ns, "100" after 2000 ns, "000" after 2500 ns;

    DUT : mux
        port map (
            digito1 => digito1_tb, 
            digito2 => digito2_tb,
            digito3 => digito3_tb,
            punto  => punto_tb,
            letra_v => letra_v_tb, 
            selector => selector_tb, 
            mux_out => mux_out_tb
        );

 end architecture mux_tb_arq;
