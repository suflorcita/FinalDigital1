-- Sol Ayelen Cataldo 
-- Bloque para la ROM de caracteres

entity rom is
	port(
		-- Entradas--
		char_address: in bit_vector(3 downto 0); -- Es donde "empieza" el caracter
		font_row: in bit_vector(2 downto 0); --- Fila donde va a ir el caracter
		font_col: in bit_vector(2 downto 0); --- Columna dónde v a ir el caracter
		
		-- Salidas--
		rom_out: out bit -- Salida de la rom
		);
	end;


architecture rom_arq of rom is
	type mat_char is array(0 to 95) of bit_vector(0 to 7); -- Es una matriz dónde tengo 12 caracteres de 8 filas cada uno. Es como un vector de vectores de 8. (12*8 = 96)
	signal char_address_aux: bit_vector(6 downto 0); -- Fila dónde va a comenzar el caracters
	
	constant chars: mat_char:= (  --- Esto son los caracteres
		
							"00000000",
							"00111100",
							"01000010",
							"01000010", -- 0
							"01000010",
							"01000010",
							"00111100",
							"00000000", 
	
						
							"00000000",
							"00001000",
							"00011000",
							"00101000", -- 1
							"00001000", 
							"00001000",
							"00111100",
							"00000000",
							
							"00000000",
							"00111100",
							"01000010",
							"00000100", -- 2
							"00001000",
							"00110000",
							"01111110",
							"00000000",

							"00000000",
							"01111100",
							"00000010",
							"00111110", -- 3
							"00000010",
							"00000010",
							"01111100",
							"00000000",

							"00000000",
							"01000100",
							"01000100",
							"01000100", -- 4
							"01111110",
							"00000100",
							"00000100",
							"00000000",

							"00000000",
							"01111100",
							"01000000",
							"01111100", -- 5
							"00000010",
							"00000010",
							"01111100",
							"00000000",

							"00000000",
							"00111100",
							"01000000",
							"01111100", -- 6
							"01000010",
							"01000010",
							"00111100",
							"00000000",

							"00000000",
							"01111110",
							"00000110",
							"00001000", -- 7
							"00010000",
							"00100000",
							"00100000",
							"00000000",

							"00000000",
							"00111100",
							"01000010",
							"01111110", -- 8
							"01000010",
							"01000010",
							"00111100",
							"00000000",

							"00000000",
							"00111100",
							"01000010",
							"01000010", -- 9
							"00111110",
							"00000010",
							"01111100",
							"00000000",

							"00000000",
							"00000000",
							"00000000",
							"00000000", -- . (punto)
							"00000000",
							"00011000",
							"00011000",
							"00000000",

							"00000000",
							"11000011",
							"11000011",
							"01100110", -- V (para volts)
							"00100100",
							"00100100",
							"00011000",
							"00000000"
	);
	
	-----FUNCION PARA CONERTIR A ENTERO-----

	function conv_int(word:bit_vector) return integer is

	variable resultado: integer:= 0 ;

	begin
	for i in word'range loop
		if (word(i)= '1') then
			resultado:= resultado + 2**i;
		end if;
	end loop;
	return resultado;
	end conv_int;
	-----------------------------------------

begin
	char_address_aux <= char_address & font_row; 
	rom_out <= chars(conv_int(char_address_aux))(conv_int(font_col));
end;  
