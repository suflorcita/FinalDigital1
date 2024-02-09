-- Sol Ayelen Cataldo 
-- TB para vsync
entity vsync_tb is
end entity vsync_tb;

architecture vsync_tb_arq of vsync_tb is

    component vsync is
	port(
		-- Entradas--
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		
		-- Salidas--
		vvidon: out bit; -- Se activa cuando el contador llega a 474
		vsync_out: out bit; -- Se activa cuando el contador está entre 489 y 491
		pixel_y: out bit_vector(9 downto 0) -- posición del pixel en y (10 bits porque va a llegar hasta 525)
		);
	end component;

    -- Señales 
    -- Entradas
    signal ena_tb : bit := '1';
    signal clk_tb : bit := '1';
    signal rst_tb : bit := '0';
    
    -- Salidas
    signal vvidon_tb: bit; 
    signal vsync_out_tb: bit; 
    signal pixel_y_tb: bit_vector(9 downto 0); 
    
begin
    clk_tb <= not clk_tb after 10 ns; -- Reloj

    DUT : vsync
        port map (
            clk_in => clk_tb,
            rst_in => rst_tb,
            ena_in => ena_tb,
       
            vvidon => vvidon_tb,
            vsync_out => vsync_out_tb, 
            pixel_y => pixel_y_tb
    
        );
end architecture vsync_tb_arq;
