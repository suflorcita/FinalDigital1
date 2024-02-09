-- Sol Ayelen Cataldo 
-- Multiplexor de 3 bits: Eligo entre los 3 Dígitos, un . y la V de Volts

entity mux is 
	port(
		-- Entradas --
		-- Dígitos --
		digito1: in bit_vector(3 downto 0); -- Este es el primer dígito (4 bits: del 0 al 9, Es lo que sale del registro)
		digito2: in bit_vector(3 downto 0); -- Segundo dígito (Decimal)
		digito3: in bit_vector(3 downto 0); -- Tercer dígito (Centesima)
		
		-- Caracteres--
--		punto: in bit_vector(3 downto 0); -- El punto. Le vamos asignar el valor 10d (1010b)
--		letra_v: in bit_vector(3 downto 0); -- La letra V de Volts. Le vamos asignar el valor 11d (1011b)
		
		-- Espacio en blanco--
--		blanco: in bit_vector(3 downto 0); 	
		
		-- Selector --
		selector: in bit_vector(2 downto 0); -- Selector de 3 bits porque elige entre 5 entradas. 
		
		-- Salidas --
		mux_out: out bit_vector(3 downto 0) -- El dígito seleccionado entre todas las entradas
		
	);
end; 

architecture mux_arq of mux is
	signal posicion: bit_vector(6 downto 0); -- Representa que posición estoy eligiendo. Tengo 6 posibilidades
	
	-- Señales de salida del and de los dígitos, el punto y la letra
	signal salida_digito1: bit_vector(3 downto 0); -- Cada una tiene 4 dígitos
	signal salida_digito2: bit_vector(3 downto 0); 
	signal salida_digito3: bit_vector(3 downto 0); 
	signal salida_punto: bit_vector(3 downto 0); 
	signal salida_letra_v: bit_vector(3 downto 0);
	signal salida_blanco: bit_vector(3 downto 0);
	 

begin 
	-- Combinaciones para seleccionar uno de los 5 entradas 
	posicion(0) <= not selector(2) and not selector(1) and not selector(0); -- Selecciono la primera posición que es el 0 (OOOb). D1
	posicion(1) <= not selector(2) and not selector(1) and selector(0); --- Segunda posición (001b). D2
	posicion(2) <= not selector(2) and selector(1) and not selector(0); -- Tercera posición (010b). D3
	posicion(3) <= not selector(2) and selector(1) and selector(0); -- Cuarto posición (011b). . 
	posicion(4) <= selector(2) and not selector(1) and not selector(0); -- Quinta posición (100b): Letra V
	posicion(5) <= selector(2) and not selector(1) and  selector(0); -- Sexta posición (101b): Blanco
	
	-- Comparo cada entrada con la selección
	salida_digito1 <= (digito1(3) and posicion(0)) & 
		          (digito1(2) and posicion(0)) & 
		          (digito1(1) and posicion(0)) & 
		          (digito1(0) and posicion(0)); 

	salida_digito2 <= (digito2(3) and posicion(1)) & 
		          (digito2(2) and posicion(1)) & 
		          (digito2(1) and posicion(1)) & 
		          (digito2(0) and posicion(1));

	salida_digito3 <= (digito3(3) and posicion(2)) & 
		          (digito3(2) and posicion(2)) & 
		          (digito3(1) and posicion(2)) & 
		          (digito3(0) and posicion(2));
	-- Punto hardcodeo un 10: '1010'
	salida_punto <= ('1' and posicion(3)) & 
		        ('0' and posicion(3)) & 
		        ('1' and posicion(3)) & 
		        ('0' and posicion(3));

	-- Volt hardcodeo un 11: '1011'
	salida_letra_v <= ('1' and posicion(4)) & 
		          ('0' and posicion(4)) & 
		          ('1' and posicion(4)) & 
		          ('1' and posicion(4));
	
	-- Blanco hardcodeo un 12: '1100'
	salida_blanco <= ('1' and posicion(5)) & 
		          ('1' and posicion(5)) & 
		          ('0' and posicion(5)) & 
		          ('0' and posicion(5));	              
		      
	-- Salida del multiplexor: Me va a quedar la que no den todos 0
	mux_out <= salida_digito1 or salida_digito2 or salida_digito3 or salida_punto or salida_letra_v or salida_blanco ; 
	
end;

