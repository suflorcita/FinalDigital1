-- Sol Ayelen Cataldo 
-- Registro de n bits

entity registro is
	generic (
		N: natural  -- Cantidad de bits que almaceno en el registro
	);
	port(
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		d_in : in bit_vector(N-1 downto 0); -- Entrada del registro 
		q_out : out bit_vector(N-1 downto 0) -- Salida del registro
		);
	end;


architecture registro_arq of registro is	
	component ffd is -- declaro el ffd
		port(
			clk_i: in bit; --clock
			rst_i: in bit; --reset
			ena_i: in bit; --enable
			d_i: in bit; -- D
			q_o: out bit -- Q
			 ); 
	end component;
	
	signal q_ffd : bit_vector(N-1 downto 0); -- Señal temporal para almacenar las salidas de los ffd

	
begin 
	bloque_registro: for i in 0 to N-1 generate
		-- Defino cada FFD del registro 
		ffd_n: ffd 
			port map(
					clk_i	=> clk_in,
					rst_i   => rst_in, 
					ena_i   => ena_in,
					d_i     => d_in(i),
					q_o     => q_ffd(i)
				);
	end generate; 
	
	q_out <= q_ffd; -- Conecto la señal temporal al registro de salida

	
end architecture registro_arq;  
