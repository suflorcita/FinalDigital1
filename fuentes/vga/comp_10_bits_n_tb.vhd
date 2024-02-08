-- Sol Ayelen Cataldo 
-- TB para comparador de 10 bits
entity comp_10_bits_n_tb is
end entity comp_10_bits_n_tb;

architecture comp_10_bits_n_tb_arq of comp_10_bits_n_tb is

    -- Componentes
    component comp_10_bits_n is 
        generic (
		N: natural := 10  -- Cantidad de bits
	);
	port(
		a: in bit_vector(N - 1 downto 0); -- Número a comparar 
		b: in bit_vector(N - 1 downto 0); -- Número a comparar 
		comp_out: out bit -- Salida del comparador: es 1 si son iguales, 0 en cualquier otro caso 
		);
    end component;

    -- Señales a comparar 

    signal a_tb : bit_vector(9 downto 0) := "0000000000"; 
    signal b_tb : bit_vector(9 downto 0) := "0000000000";
    signal comp_out_tb : bit;
    
begin
    a_tb <= "1100011111" after 200 ns,  -- 799 = en binario es '1100011111'
    	  "1001111111" after 400 ns, -- 639 = en binario es '1001111111'
    	  "1010001111" after 600 ns, -- 655 = en binario es '1010001111'
    	  "1011101111" after 800 ns; -- 751 = en binario es '1011101111'
   
    b_tb <= "1100011111" after 200 ns, -- 799 = en binario es '1100011111' 
    	"1101111111" after 300 ns, -- valor random
    	"1001111111" after 400 ns,  -- 639 = en binario es '1001111111'
    	"1111011111" after 500 ns, -- valor random
    	"1010001111" after 600 ns,-- 655 = en binario es '1010001111'
    	"1111101111" after 700 ns, -- valor random
    	"1011101111" after 800 ns, -- 751 = en binario es '1011101111'
    	"1111111111" after 900 ns; -- valor random
    
    DUT : comp_10_bits_n
        port map (
        	a => a_tb, 
        	b => b_tb,
        	comp_out => comp_out_tb
        );

end architecture comp_10_bits_n_tb_arq;

