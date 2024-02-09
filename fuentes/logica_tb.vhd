-- Sol Ayelen Cataldo
-- TB para logica  

entity logica_tb is
end; 

architecture logica_tb_arq of logica_tb is
	
	component logica is 
		port(
			pixel_x : in bit_vector(9 downto 0); -- Barrido de la pantalla en X y en Y 
			pixel_y : in bit_vector(9 downto 0); 
			
			sel_mux: out bit_vector(2 downto 0); -- Selector del multiplexor 
			font_row: out bit_vector(2 downto 0); -- Fila de la ROM 
			font_col: out bit_vector(2 downto 0) -- Columna de la ROM 
			
		
		);
	
	end component; 
	
	
	-- Caracteres
	signal pixel_x_tb : bit_vector(9 downto 0):= "0000000000"; -- 0: Columna 1 
	signal pixel_y_tb : bit_vector(9 downto 0):= "0010000001"; -- 129: Fila 2 
	signal sel_mux_tb : bit_vector(2 downto 0);
	signal font_row_tb : bit_vector(2 downto 0); 
	signal font_col_tb : bit_vector(2 downto 0);
	
	signal clk_tb: bit := '1';
	
begin
    clk_tb <= not clk_tb after 20 ns;
    
    pixel_x_tb <= "0010000001" after 200 ns, "0100000001"after 400 ns, "0110000001" after 600 ns, "1000000001" after 800 ns;  
    pixel_y_tb <= "0000000000" after 1000 ns, "0100000001" after 1200 ns, "0110000001" after 1400 ns ; --- Fila 1, 3 y 4
    -- 129, 257, 385, 513
    -- Fila 1: blanco 
    
    DUT : logica
        port map (
            pixel_x => pixel_x_tb, 
            pixel_y => pixel_y_tb,
            sel_mux => sel_mux_tb, 
            font_row => font_row_tb, 
            font_col => font_col_tb
        );

 end architecture logica_tb_arq;
