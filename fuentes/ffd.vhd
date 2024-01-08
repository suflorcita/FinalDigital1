entity ffd is 
	port (
		clk_i : in bit; -- clock
		rst_i : in bit; -- reset
		ena_i : in bit; -- enable
		d_i   : in bit; -- D
		q_o   : out bit -- Q
	); 
end entity ffd;

architecture ffd_arq of ffd is
begin 
	process (clk_i)
	begin
		if clk_i'event and clk_i = '1' then -- check for rising edge
			if rst_i = '1' then
				q_o <= '0'; 
			elsif ena_i = '1' then
				q_o <= d_i; 
			end if; 
		end if; 
	end process; 
end architecture;

