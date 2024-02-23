-- Sol Ayelen Cataldo 
-- TB para el generador de sincronismos
entity gensinc_tb is
end entity gensinc_tb;

architecture gensinc_tb_arq of gensinc_tb is

    component gensinc is
	port(
		-- Entradas--
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		
		-- Salidas--
		vidon: out bit; -- Se activa cuando los dos vidones estan on
		hsync_out_gen: out bit; -- Señal de sincronismo horizontal
		vsync_out_gen: out bit; -- Señal de sincronismo vertical
		pixel_x: out bit_vector(9 downto 0); -- posición del pixel en y
		pixel_y: out bit_vector(9 downto 0); -- posición del pixel en x
		
		-- Estas salidas las dejo para chequear
		hvidon: out bit; -- Se activa cuando está en on el vidon el hvidon
		vvidon: out bit -- Se activa cuando está en on el vidon el vvidon
		
		);
	end component;

    -- Señales --
    -- Entradas -
    signal ena_tb : bit := '1';
    signal clk_tb : bit := '1';
    signal rst_tb : bit := '0';
    
    -- Salidas --
    
    signal vidon_tb: bit;
    signal hsync_out_gen_tb: bit;
    signal vsync_out_gen_tb: bit;
    signal pixel_x_tb: bit_vector(9 downto 0); 
    signal pixel_y_tb: bit_vector(9 downto 0);

	
    signal hvidon_tb: bit;
    signal vvidon_tb: bit;
    
begin
    clk_tb <= not clk_tb after 40 ns; -- Reloj

    DUT : gensinc
        port map (
        	-- Entradas--
		clk_in => clk_tb, 
		rst_in => rst_tb, 
		ena_in => ena_tb, 
		
		-- Salidas--
		vidon => vidon_tb, 
		hsync_out_gen => hsync_out_gen_tb, 
		vsync_out_gen => vsync_out_gen_tb, 
		pixel_x => pixel_x_tb,
		pixel_y => pixel_y_tb,
		
		
		hvidon => hvidon_tb, 
		vvidon => vvidon_tb 
		       
            
        );
end architecture gensinc_tb_arq;
