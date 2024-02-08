-- Sol Ayelen Cataldo 
-- Registro de 4 bits

entity registro_4bits is
	generic (
		N: natural := 4 -- Registro de 4 bits
	);
	port(
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		d_in : in bit_vector(N-1 downto 0); -- Entrada del registro 
		q_out : out bit_vector(N-1 downto 0) -- Salida del registro
		);
	end;


architecture registro_4bits_arq of registro_4bits is	
	component registro is -- Declaro registro de N bits que tengo en registro.vhd
		generic (
			N: natural := 4 -- Es un registro de 4 bits
		);
		port(
			clk_in : in bit;
			rst_in : in bit;
			ena_in : in bit;
			d_in : in bit_vector(N-1 downto 0); -- Entrada del registro 
			q_out : out bit_vector(N-1 downto 0) -- Salida del registro
			 ); 
	end component;
	
	signal q_ffd : bit_vector(N-1 downto 0); -- Señal temporal para almacenar la salidas de los ffd

	
begin 
	registro_4_bits: registro
		port map(
				clk_in	=> clk_in,
				rst_in   => rst_in, 
				ena_in   => ena_in,
				d_in     => d_in,
				q_out     => q_ffd
			);
	
	-- Salida
	q_out <= q_ffd; -- Conecto la señal temporal al registro de salida 

	
end architecture registro_4bits_arq;  
