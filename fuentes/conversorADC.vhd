-- Sol Cataldo
-- Conversor ADC 

entity conversorADC is
    port (
        clk_i   : in bit;
        rst_i   : in bit;
        ena_i   : in bit;
        d_i     : in bit;
        fback_o : out bit; -- Feedback que va a ir negado
        data_o  : out bit  -- Salida que va al bloque de procesamiento
    );
end entity conversorADC;

architecture conversorADC_arq of conversorADC is
    component ffd
        port (
            clk_i : in bit; -- clock
            rst_i : in bit; -- reset
            ena_i : in bit; -- enable
            d_i   : in bit; -- D
            q_o   : out bit -- Q
        );
    end component;

    signal q_o_aux: bit;  -- Auxiliar que va a la salida del FFD

begin
    -- Instanciación del FFD
    ffd_conversor: ffd
        port map (
            clk_i => clk_i,
            rst_i => rst_i,
            ena_i => ena_i,
            d_i   => d_i,
            q_o   => q_o_aux
        );
    
    -- Se nega el resultado del FFD para el feedback
    fback_o <= not q_o_aux;
    -- Salida del FFD
    data_o  <= q_o_aux;

end architecture conversorADC_arq;

