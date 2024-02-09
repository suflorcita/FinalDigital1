-- Sol Ayelen Cataldo 
-- Comparador de 10 bits

entity comp_10_bits_n is
	generic (
		N: natural  := 10 -- Cantidad de bits, es 10, puedo comparar números hasta el 1024
	);
	port(
		a: in bit_vector(N - 1 downto 0); -- Número a comparar 
		b: in bit_vector(N - 1 downto 0); -- Número a comparar 
		comp_out: out bit -- Salida del comparador: es 1 si son iguales, 0 en cualquier otro caso 
		);
	end;


architecture comp_10_bits_n_arq of comp_10_bits_n is	
	-- Señales
	signal aux: bit_vector(N - 1 downto 0); -- Auxiliar que va evaluando si los dígitos son iguales
	
begin
	
	bloque_comp_10_bits_n: for i in 0 to N - 1 generate
		aux(i) <= not( a(i) xor b(i)); -- Comparo los dos digitos y me da 1 si son iguales o 0 si son distintos 
	end generate; 	
	
	comp_out <= aux(0) and aux(1) and aux(2) and aux(3) and aux(4) and aux(5) and aux(6) and aux(7) and aux(8) and aux(9); 

		
end;  
