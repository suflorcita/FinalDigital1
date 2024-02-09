-- Sol Ayelen Cataldo 
-- Contador binario que va hasta 33k (16 bits)

entity cont_bin_33k is
	port(
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		q_o : out bit_vector(15 downto 0); -- Salida del contador binario 
		rst_o : out bit; 	-- Salida que va hacia el reset del contador BCD
		ena_o : out bit	-- Salida que va hacia el enable del registro
		);
	end;


architecture cont_bin_33k_arq of cont_bin_33k is	
	component cont_bin is -- Declaro el contador binario
		generic (
			N: natural := 16
		);
		port(
			clk_in : in bit;
			rst_in : in bit;
			ena_in : in bit;
			q_o : out bit_vector(N - 1 downto 0)
		); 
	end component;
	
	-- Señales
	signal q : bit_vector(15 downto 0); -- Señal auxiliar para la salida del contador 
	signal aux_33k: bit; -- Flag auxiliar que se activa cuando llega a 33k
	
	
begin 
	cont_bin_n_33k: cont_bin
		port map(
			clk_in => clk_in,
			rst_in => aux_33k, -- Se resetea cuando llega a los 33k 
			ena_in => ena_in,
			q_o => q
			 -- La salida del contador: me va a servir para la logica habilitar el reset al contador BCD y el enable al registro
		); 
		
	 -- Enable del registro dónde se guarda la cuenta en 32 999
	ena_o <=  q(0) and q(1) and q(2) and not q(3) 
		and not q(4) and q(5) and q(6) and q(7) 
		and not q(8) and not q(9) and not q(10) and not q(11)
		and not q(12) and not q(13) and not q(14) and q(15);
	
	-- Reset del contador BCD en 33000
	-- Auxiliar que se activa cuando llega a 33000
	aux_33k <=  not q(0) and not q(1) and not q(2) and q(3) 
		and not q(4) and q(5) and q(6) and q(7) 
		and not q(8) and not q(9) and not q(10) and not q(11)
		and not q(12) and not q(13) and not q(14) and q(15);
	-- Activo el reset del contador BCD
	rst_o <= aux_33k; 
	
	--Salida
	q_o <= q;
	
	
end;  
