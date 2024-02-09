-- Sol Ayelen Cataldo 
-- Voltimetro que es la suma de todos los caracteres
entity voltimetro is
	port(
	 	clk_i : in bit;
		rst_i : in bit;
		ena_i : in bit;
	); 
end entity voltimetro;

architecture voltimetro_arq of voltimetro is

	--Declaro los componentes
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
			digito1: in bit_vector(3 downto 0); -- Este es el primer dígito (4 bits: del 0 al 9, Es lo que sale del registro)
			digito2: in bit_vector(3 downto 0); -- Segundo dígito (Decimal)
			digito3: in bit_vector(3 downto 0); -- Tercer dígito (Centesima)
			
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
			red_o: out bit; 
			grn_o: out bit; 
			blu_o: out bit; 
			
			hsync_out_vga: out bit; -- Señal de sincronismo horizontal
			vsync_out_vga: out bit; -- Señal de sincronismo vertical
			
			pixel_x: out bit_vector(9 downto 0); -- posición del pixel en y
			pixel_y: out bit_vector(9 downto 0) -- posición del pixel en x
			
			);
	end component;
	
	--- Señales 
	-- Contador Binario
	signal out_cont_bin: bit; -- Salida del contador binario 
	signal out_rst_cont_bin: bit_vector(15 downto 0);-- Salida del contador binario que resetea al contador BCD
	signal out_ena_cont_bin: bit; -- Salida del contador binario que habilita el registro 
	
	-- Contador BCD
	signal out_cont_bcd: bit_vector(19 downto 0); 
begin
	-- Mapeo los componentes
	
	-- Bloque contador binario
	-- Contador binario 
    	bloque_cont_bin: cont_bin_33k
		port map (
			clk_in => clk_i,
			rst_in => rst_i,
			ena_in => ena_i,
			q_o => out_cont_bin, -- Salida del contador binario 
			rst_o => out_rst_cont_bin, 	-- Salida que va hacia el reset del contador BCD
			ena_o => out_ena_cont_bin	-- Salida que va hacia el enable del registro
		);
	
	-- Bloque contador BCD (de unos)
	-- Contador binario 
    	bloque_cont_bcd: cont_bin_33k
		port map (
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			q_o => out_cont_bcd-- Los bits de salida 
		);
	
	-- Bloque Registro
	component registro_4bits is
    		port(
			clk_in : in bit;
			rst_in : in bit;
			ena_in : in bit;
			d_in : in bit_vector(3 downto 0); -- Entrada del registro 
			q_out : out bit_vector(3 downto 0) -- Salida del registro
		);
	end component;
	
	-- Registro
    	bloque_registro: registro_4bits
    		port(
			clk_in => clk_i,
			rst_in => rst_i,
			ena_in => ena_i,
			d_in => out_cont_bcd-- Los bits de salida 
		);


	
end architecture voltimetro_arq;
