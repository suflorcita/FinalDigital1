-- Sol Ayelen Cataldo 
-- TB para hsync
entity hsync_tb is
end entity hsync_tb;

architecture hsync_tb_arq of hsync_tb is

    component hsync is
	port(
		-- Entradas--
		clk_in : in bit;
		rst_in : in bit;
		ena_in : in bit;
		
		-- Salidas--
		max_cuenta: out bit; -- Se activa cuando el contador llega a 799
		hvidon: out bit; -- Se activa cuando el contador llega a 639
		hsync_out: out bit; -- Se activa cuando el contador está entre 655 y 751
		pixel_x: out bit_vector(9 downto 0) -- posición del pixel en x
		);
	end component;

    -- Señales 
    -- Entradas
    signal ena_tb : bit := '1';
    signal clk_tb : bit := '1';
    signal rst_tb : bit := '0';
    
    -- Salidas
    signal max_cuenta_tb: bit; 
    signal hvidon_tb: bit; 
    signal hsync_out_tb: bit; 
    signal pixel_x_tb: bit_vector(9 downto 0); 
    
begin
    clk_tb <= not clk_tb after 10 ns; -- Reloj

    DUT : hsync
        port map (
            clk_in => clk_tb,
            rst_in => rst_tb,
            ena_in => ena_tb,
            
            max_cuenta => max_cuenta_tb,
            hvidon => hvidon_tb,
            hsync_out => hsync_out_tb, 
            pixel_x => pixel_x_tb
    
        );
end architecture hsync_tb_arq;

