-- Sol Ayelen Cataldo 
-- TB para la rom de caracteres
entity rom_tb is
end entity rom_tb;

architecture rom_tb_arq of rom_tb is

    component rom is
	port(
		-- Entradas--
		char_address: in bit_vector(3 downto 0); -- Es donde "empieza" el caracter
		font_row: in bit_vector(2 downto 0); --- Fila donde va a ir el caracter
		font_col: in bit_vector(2 downto 0); --- Columna dónde v a ir el caracter
		
		-- Salidas--
		rom_out: out bit -- Salida de la rom
		);
	end component;

    -- Señales 
    -- Entradas
    signal char_address_tb : bit_vector(3 downto 0) := "0000";
    signal font_row_tb : bit_vector(2 downto 0) := "000";
    signal font_col_tb: bit_vector(2 downto 0) := "000";
    
    -- Salidas
    signal rom_out_tb: bit; 
   
begin
	char_address_tb <=  "0001" after 50 ns, -- Numero 1
			"0010" after 100 ns, -- Numero 2
			"1010" after 150 ns, -- Punto
			"1011" after 200 ns, -- Voltaje
			"0001" after 250 ns;
	
	
	font_row_tb <=  "010" after 50 ns, -- Fila 2 (3)
			"011" after 100 ns, -- Fila 3 (4)
			"101" after 150 ns, -- Fila 5 (6)
			"111" after 200 ns, -- Fila 7 (8)
			"001" after 250 ns;
			
	font_col_tb <=  "011" after 50 ns, -- Columna 4(3)
			"100" after 100 ns, -- Columna 5(4)
			"011" after 150 ns, -- Columna 3(4)
			"111" after 200 ns, -- Columna 7 (8)
			"001" after 250 ns;
			
	-- El primero deberia dar 0 (0)
	-- El segundo deberia dar 1 (1)
	-- El tercero deberia dar 0 (2)
	-- El cuarto deberia dar 1 (.)
	-- El quinto deberia dar 0 (V)
	
	
    DUT : rom
	port map (
		char_address => char_address_tb, 
		font_row => font_row_tb,
		font_col => font_col_tb,		
		rom_out => rom_out_tb	      
	);
end architecture rom_tb_arq;
