-- Sol Ayelen Cataldo 
-- Bloque para un contador de entrada (tengo una frecuencia inicial de 100 MHz y la divido por 4 para obtener una de 25 MHz)

entity cont_2bits is
	port(
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		q_o : out bit_vector(1 downto 0) -- Salida del contador binario 
		);
	end;


architecture cont_2bits_arq of cont_2bits is	
	component cont_bin is -- Declaro el contador binario
		generic (
			N: natural := 2
		);
		port(
			clk_in : in bit;
			rst_in : in bit;
			ena_in : in bit;
			q_o : out bit_vector(N - 1 downto 0)
		); 
	end component;
	
	
	
	
	
begin 
	contador_2bits: cont_bin
		port map(
			clk_in => clk_in,
			rst_in => rst_in, 
			ena_in => ena_in,
			q_o => q_o -- La salida del contador
		); 
	
end;  
