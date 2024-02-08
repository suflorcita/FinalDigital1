-- Sol Ayelen Cataldo 
-- Contador binario de 10 bits (va hasta 1024)

entity cont_bin_10 is
	generic (
		N: natural := 10  -- Cantidad de bits
	);
	port(
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		q_o : out bit_vector(N -1 downto 0) -- Salida del contador binario 
		);
	end;


architecture cont_bin_10_arq of cont_bin_10 is	
	component cont_bin is -- Declaro el contador binario
		generic (
			N: natural := 10
		);
		port(
			clk_in : in bit;
			rst_in : in bit;
			ena_in : in bit;
			q_o : out bit_vector(N - 1 downto 0)
		); 
	end component;
	
	
begin 
	cont_bin10: cont_bin
		port map(
			clk_in => clk_in,
			rst_in => rst_in, 
			ena_in => ena_in,
			q_o => q_o
		); 
	
end;  
