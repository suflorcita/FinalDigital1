-- Sol Ayelen Cataldo 
-- Contador binario genérico de N bis

entity cont_bin is
	generic (
		N: natural  -- Cantidad de bits
	);
	port(
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		q_o : out bit_vector(N -1 downto 0) -- Salida del contador binario 
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
	
	-- Señales
	signal d_aux: bit_vector(N - 1  downto 0); -- Las entradas de cada FFD
	signal q_aux: bit_vector(N - 1 downto 0); -- Las salidas de cada FFD
	signal sal_and: bit_vector (N - 1 downto 0); -- Salidas de los and 
	signal sal_xor: bit_vector (N - 1 downto 0); -- Salidas de los xor
	signal ena_signal : bit := '1';
	
	
	
begin 
	--- Primer XOR FFD
	
	ffd_1: ffd --Primer FFD
		port map(
				clk_i	   => clk_in,
				rst_i    => rst_in, 
				ena_i   => ena_in,
				q_o        => q_aux(0),
				d_i        => sal_xor(0)
				
			);
	-- Primer AND 		
	sal_and(0) <= ena_in and q_aux(0); 
	
	-- Primer XOR
	sal_xor(0) <= q_aux(0) xor ena_in; 
	
	--- Los subsiguientes AND y FFD
	bloque_contbin: for i in 1 to N - 1 generate
		-- Defino cada FFD 
		ffd_n: ffd 
			port map(
					clk_i	=> clk_in,
					rst_i   => rst_in, 
					ena_i   => ena_in,
					d_i     => sal_xor(i),
					q_o     => q_aux(i)
				);
		
		-- Defino cada AND 
		sal_and(i) <= sal_and(i-1) and q_aux(i); 
		
		-- Defino cada XOR
		sal_xor(i) <= q_aux(i) xor sal_and(i-1); 
	
	end generate;
	
	q_o <= q_aux; -- Salida del contador (es la salida de cada FFD)
	
			
end;  
