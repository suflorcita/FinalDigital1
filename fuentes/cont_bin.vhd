-- Sol Ayelen Cataldo 
-- Contador binario que va hasta 33000

entity cont_bin is
	generic (
		N: natural := 16; -- Cantidad de bits
	);
	port(
		clk_i : in bit;
		rst_i : in bit;
		ena_i : in bit;
		q_o : out bit_vector(N - 1 downto 0) -- Salida del contador binario
		rst_o : out bit; -- Salida que va hacia el reset del contador BCD
		ena_o : out bit; -- Salida que va hacia el enable del registro
		);
	end;


architecture cont_bin_arq of cont_bin is	
	component ffd is -- declaro el ffd
		port(
			clk_i: in bit; --clock
			rst_i: in bit; --reset
			ena_i: in bit; --enable
			d_i: in bit; -- D
			q_o: out bit -- Q
			 ); 
	end component;
	
	signal d_aux: bit_vector(N down to 0); -- Las entradas de cada FFD
	signal q_aux: bit_vector(N down to 0); -- Las salidas de cada FFD
begin 
	
			
end;  
