-- Sol Ayelen Cataldo 
-- TB para la vga
entity vga_tb is
end entity vga_tb;

architecture vga_tb_arq of vga_tb is

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
		red_o: in bit; 
		grn_o: in bit; 
		blu_o: in bit; 
		
		hsync_out_vga: out bit; -- Señal de sincronismo horizontal
		vsync_out_vga: out bit; -- Señal de sincronismo vertical
		
		pixel_x: out bit_vector(9 downto 0); -- posición del pixel en y
		pixel_y: out bit_vector(9 downto 0); -- posición del pixel en x
		
		);
	end component;

    -- Señales --
    -- Entradas -
    signal rom_out_tb : bit := '0'; -- Esta señal va a ir a conectado al grn y al red 
    signal blu_i_tb : bit := '1'; -- Este va a quedar siempre en 1 porque la pantalla es azul
    
    
    signal ena_tb : bit := '1';
    signal clk_tb : bit := '1';
    signal rst_tb : bit := '0';
    
    -- Salidas --
    signal grn_o_tb : bit;
    signal red_o_tb : bit;
    signal blu_o_tb : bit;
   
    signal hsync_out_vga_tb: bit;
    signal vsync_out_va_tb: bit;
    
    signal pixel_x_tb: bit_vector(9 downto 0); 
    signal pixel_y_tb: bit_vector(9 downto 0);

	
    -- Entradas -
   
    
begin
    clk_tb <= not clk_tb after 10 ns; -- Reloj
    
    rom_out_tb <=  1 after 50 ns, 0 after 100 ns; -- Si es 1 es cómo si hubiese un dígito en la pantalla. Con estos tiempos cae en la zona visible

    DUT : gensinc
        port map (
        	-- Entradas--
		-- Colores --
		red_i => rom_out_tb, 
		grn_i => rom_out_tb, 
		blu_i => blu_i_tb, 
		
		clk_in => clk_tb, 
		rst_in => rst_tb, 
		ena_in => ena_tb, 
		
		
		-- Salidas--
		red_o => red_o_tb, 
		grn_o => grn_o_tb, 
		blu_o => blu_o_tb, 
		
		
		hsync_out_vga => hsync_out_vga_tb, 
		vsync_out_vga => vsync_out_vga_tb, 
		
		pixel_x => pixel_x_tb, 
		pixel_y => pixel_y_tb
		       
            
        );
end architecture vga_tb_arq;
