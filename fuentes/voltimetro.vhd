-- Sol Ayelen Cataldo 
-- Voltimetro que es la suma de todos los componentes
entity voltimetro is
	port(
	 	clk_in : in bit;
		rst_i : in bit;
		ent_unos: in bit;  --- Entrada de unos 
		
		--- Salidas 
		sal_unos: out bit; 
		hs: out bit; -- Sincronismo horizontal
		vs: out bit; -- Sincronismo vertical
		red_o: out bit; -- Rojo
		grn_o: out bit; -- Verde
		blu_o: out bit  -- Azul
	); 
end entity voltimetro;

architecture voltimetro_arq of voltimetro is

	--Declaro los componentes
	-- Contador que divide el reloj de entrada 
	component cont_2bits
		port(
			clk_in : in bit;
			rst_in : in bit;
			ena_in : in bit;
			q_o : out bit_vector(1 downto 0) -- Salida del contador binario 
			);
	end component;
	
	
	
	
	-- Conversor ADC (ffd con retroalimentacion)	
	component conversorADC
		port(
			clk_i	: in bit;  
			rst_i	: in bit; 
			ena_i   : in bit;
			d_i	: in bit;
			
			fback_o : out bit; -- Feedback que va a ir negado
			data_o	: out bit -- Salida que va al bloque de procesamiento s
		); 
	end component;
	
	-- Contador binario 
    	component cont_bin_33k
		port(
			clk_in : in bit;
			rst_in : in bit;
			ena_in : in bit;
			q_o : out bit_vector(15 downto 0); -- Salida del contador binario 
			rst_o : out bit; 	-- Salida que va hacia el reset del contador BCD
			ena_o : out bit	-- Salida que va hacia el enable del registro
		);
	end component;


	--Contador BCD de 5 dígitos 
	component cont_bcd_n is
		port (
		    clk_i : in bit;
		    rst_i : in bit;
		    ena_i : in bit;
		    q_o : out bit_vector(19 downto 0) -- Los bits de salida 
		);
    	end component;
    	
    	
    	--Registro de 4 bits
    	component registro_4bits is
    		port(
			clk_in : in bit;
			rst_in : in bit;
			ena_in : in bit;
			d_in : in bit_vector(3 downto 0); -- Entrada del registro 
			q_out : out bit_vector(3 downto 0) -- Salida del registro
		);
	end component;

    	--- Multiplexor
    	component mux is 
		port(
			-- Entradas --
			-- Dígitos --
			digito_2: in bit_vector(3 downto 0); -- Este es el primer dígito (4 bits: del 0 al 9, Es lo que sale del registro)
			digito_1: in bit_vector(3 downto 0); -- Segundo dígito (Decimal)
			digito_0: in bit_vector(3 downto 0); -- Tercer dígito (Centesima)
			
			-- Selector --
			
			selector: in bit_vector(2 downto 0); -- Selector de 3 bits porque elige entre 5 entradas. 
			-- Salidas --
			mux_out: out bit_vector(3 downto 0) -- El dígito seleccionado entre todas las entradas
			
		);
	end component;
	
	--- Logica
    	component logica is 
		port(
			pixel_x : in bit_vector(9 downto 0); -- Barrido de la pantalla en X y en Y 
			pixel_y : in bit_vector(9 downto 0); 
			
			sel_mux: out bit_vector(2 downto 0); -- Selector del multiplexor 
			font_row: out bit_vector(2 downto 0); -- Fila de la ROM 
			font_col: out bit_vector(2 downto 0) -- Columna de la ROM 		
		);
	
	end component; 
	
	-- ROM 
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
	
	
	-- VGA
	
	component vga is
		port(
			-- Entradas--
			-- Colores --
			red_i : in bit;
			grn_i : in bit;
			blu_i : in bit;
			
			clk_in : in bit;
			rst_in : in bit;
			ena_in : in bit;
			
			-- Salidas--
			grn_o: out bit; 
			red_o: out bit; 
			blu_o: out bit; 
			
			hsync_out_vga: out bit; -- Señal de sincronismo horizontal
			vsync_out_vga: out bit; -- Señal de sincronismo vertical
			
			pixel_x: out bit_vector(9 downto 0); -- posición del pixel en y
			pixel_y: out bit_vector(9 downto 0) -- posición del pixel en x
			
			);
	end component;
	
	--- Señales 
	-- Auxiliar para convertir los 100 MHz en 25 MHz 
	signal clk_aux: bit_vector(1 downto 0); 
	signal clk_i_aux: bit; 
	
	-- Conversor ADC 
	signal out_ena_cont_bcd: bit; -- Salida que sirve para habilitar al contador BCD 
	
	-- Contador Binario
	signal out_cont_bin: bit_vector(15 downto 0); -- Salida del contador binario 
	signal out_rst_cont_bin: bit;-- Salida del contador binario que resetea al contador BCD
	signal out_ena_cont_bin: bit; -- Salida del contador binario que habilita el registro 
	
	-- Contador BCD
	signal out_cont_bcd: bit_vector(19 downto 0); 
	
	-- Digitos del BCD 
	-- Contador
	signal digito_2_bcd: bit_vector(3 downto 0); -- Es el de la unidad. Va a ser los bit 19-18-17 del BCD
	signal digito_1_bcd: bit_vector(3 downto 0); -- Es el de las decimas.  Va a ser los bit 16-15-14 del BCD
	signal digito_0_bcd: bit_vector(3 downto 0); -- Es el de las centesimas.  Va a ser los bit 13-12-11 del BCD
	
	-- Registro
	signal digito_2_reg: bit_vector(3 downto 0); -- Es el de la unidad. Va a ser los bit 19-18-17 del BCD
	signal digito_1_reg: bit_vector(3 downto 0); -- Es el de las decimas.  Va a ser los bit 16-15-14 del BCD
	signal digito_0_reg: bit_vector(3 downto 0); -- Es el de las centesimas.  Va a ser los bit 13-12-11 del BCD
	
	-- Mux 
	signal salida_mux: bit_vector(3 downto 0); -- Salida del mux que es la entrada a la ROM de caracteres (char_address)
	
	-- ROM 
	signal rom_out_to_vga: bit; 	
	
	-- Salidas de la lógica
	signal selector_logica: bit_vector(2 downto 0); -- Selector para el Mux que sale del bloque de lógica
	signal font_row_logica: bit_vector(2 downto 0); -- Fila de la ROM 
	signal font_col_logica: bit_vector(2 downto 0); -- Columna de la ROM 
	
	--- Salidas del VGA
	
	-- Sincronismos
	signal hs_aux: bit; -- Sincronismo horizontal auxiliar VGA
	signal vs_aux: bit; -- Sincronismo vertical auxiliar VGA
	
	-- Colores
	signal red_o_aux: bit; -- Rojo
	signal grn_o_aux: bit; -- Verde
	signal blu_o_aux: bit; -- Verde
	
	-- Posición de píxeles
	signal pixel_x_vga: bit_vector(9 downto 0);
	signal pixel_y_vga: bit_vector(9 downto 0);
	
	-- Habilitación
	--signal ena_i: bit:= '1';
	
begin
	-- Mapeo los componentes
	
	-- Contador 2 bits que divide el reloj de la frecuencia de 100 MHz en uno de 25 MHz 	
	bloque_con2bits: cont_2bits
		port map (
			clk_in => clk_in,
			rst_in => '0',
			ena_in => '1',
			q_o => clk_aux
		);
	
	clk_i_aux <= clk_aux(1); 
	

    	
    	-- Conversor ADC: FFD que está a la entrada
    	bloque_conversorADC: conversorADC
		port map (
			clk_i => clk_i_aux,
			rst_i => rst_i,
			ena_i => '1',
			
			d_i => ent_unos, -- Entrada de los unos 
			fback_o => sal_unos, 	-- Salida negada que va a dar el feedback
			data_o => out_ena_cont_bcd	-- Salida que va hacia el enable del contador bcd 
		);
	
	
	
	-- Bloque contador binario	
	-- Contador binario 
    	bloque_cont_bin_voltimetro: cont_bin_33k
		port map (
			clk_in => clk_i_aux,
			rst_in => rst_i,
			ena_in => '1',
			q_o => out_cont_bin, -- Salida del contador binario 
			rst_o => out_rst_cont_bin, 	-- Salida que va hacia el reset del contador BCD
			ena_o => out_ena_cont_bin	-- Salida que va hacia el enable del registro
		);
	
	-- Bloque contador BCD (de unos)
	-- Contador binario 
    	bloque_cont_bcd: cont_bcd_n
		port map (
			clk_i => clk_i_aux,
			rst_i => out_rst_cont_bin, 
			ena_i => out_ena_cont_bcd, -- Cuenta cuando hay una señal del conversor
			q_o => out_cont_bcd-- Los bits de salida 
		);
	
	digito_2_bcd <= out_cont_bcd(19) & out_cont_bcd(18) & out_cont_bcd(17) & out_cont_bcd(16);
	digito_1_bcd <= out_cont_bcd(15) & out_cont_bcd(14) & out_cont_bcd(13) & out_cont_bcd(12);
	digito_0_bcd <= out_cont_bcd(11) & out_cont_bcd(10) & out_cont_bcd(9) & out_cont_bcd(8);
	
	-- Hago 3 registro de 4 bits
	-- Bit 2 - Unidad 
    	registro_bit_2: registro_4bits
    		port map(
			clk_in => clk_i_aux,
			rst_in => rst_i,
			ena_in => out_ena_cont_bin, -- Se habilita cuando deja de contar
			d_in => digito_2_bcd, 
			q_out => digito_2_reg 
		);
		
	-- Bit 1 - Decima
    	registro_bit_1: registro_4bits
    		port map(
			clk_in => clk_i_aux,
			rst_in => rst_i,
			ena_in => out_ena_cont_bin, -- Se habilita cuando deja de contar
			d_in => digito_1_bcd, 
			q_out => digito_1_reg 
		);
		
	
	-- Bit 0 - Céntima 
    	registro_bit_0: registro_4bits
    		port map(
			clk_in => clk_i_aux,
			rst_in => rst_i,
			ena_in => out_ena_cont_bin, -- Se habilita cuando deja de contar
			d_in => digito_0_bcd, 
			q_out => digito_0_reg 
		);
		
	
	-- Multiplexor
    	bloque_mux: mux
    		port map(
			digito_2 => digito_2_reg,
			digito_1 => digito_1_reg,
			digito_0 => digito_0_reg,
			selector => selector_logica, 
			mux_out => salida_mux
		);
		
		
	-- ROM
   	bloque_rom: rom
    		port map(
    			char_address => salida_mux, -- Entra la salida del mux (el dígito o caracter)
    			font_row => font_row_logica,
    			font_col => font_col_logica,
    			rom_out => rom_out_to_vga 
		);
	

    	bloque_logica: logica
    		port map(
    			-- Pixeles que salen de la VGA
    			pixel_x => pixel_x_vga,
    			pixel_y => pixel_y_vga, 
    			
    			-- Salidas de la logica
    			sel_mux => selector_logica, 
    			font_row => font_row_logica, 
    			font_col => font_col_logica
			
		);
			
	
	
	-- VGA 
	bloque_vga: vga
		port map(
			red_i => rom_out_to_vga, -- Salida de la ROM de caracteres
			grn_i => rom_out_to_vga, -- Salida de la ROM de caracteres
			-- La salida de la ROM determinar si se enciende ademas del azul el rojo y el verde 
			blu_i => '1', -- Siempre está en uno pues el fondo de pantalla es azul
			
			clk_in => clk_i_aux,
			rst_in => rst_i,
			ena_in => '1',
			
			red_o => red_o_aux,
			grn_o => grn_o_aux,
			blu_o => blu_o_aux,
			
			-- Sincronismos --
			hsync_out_vga => hs_aux,
			vsync_out_vga => vs_aux,
			
			pixel_x => pixel_x_vga,
			pixel_y => pixel_y_vga
		); 	
		
		
	-- Salidas del Voltímetro
	hs <= hs_aux; 
	vs <= vs_aux; 
	
	red_o <= red_o_aux; 
	grn_o <= grn_o_aux; 
	blu_o <= blu_o_aux; 
	
	
	
end architecture voltimetro_arq;
