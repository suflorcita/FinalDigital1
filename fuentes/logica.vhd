-- Sol Ayelen Cataldo 
-- Bloque de lógica que conecta el barrido de la pantalla.

entity logica is
	port(
		pixel_x : in bit_vector(9 downto 0); -- Barrido de la pantalla en X y en Y 
		pixel_y : in bit_vector(9 downto 0); 
		
		sel_mux: out bit_vector(2 downto 0); -- Selector del multiplexor 
		font_row: out bit_vector(2 downto 0); -- Fila de la ROM 
		font_col: out bit_vector(2 downto 0) -- Columna de la ROM 
		
		
		);
	end;


architecture logica_arq of logica is	
	
	-- Filas --
	signal fila_2: bit; 
	
	-- Columnas
	signal col_1: bit; 
	signal col_2: bit;
	signal col_3: bit; 
	signal col_4: bit;
	signal col_5: bit;
	
	-- Caracter
	signal d1: bit; -- Digito 1
	signal punto: bit; -- Punto
	signal d2: bit; -- Digito 2
	signal d3: bit; -- Digito 3	
	signal volt: bit; -- volt
	
	-- Selector auxiliar
	signal sel_aux: bit_vector(2 downto 0); 
begin 
	--- Solo voy a imprimir caracteres en pantalla en la fila 2 (001xxxxxxx) 
	fila_2 <= (not pixel_y(9)) and (not pixel_y(8)) and pixel_y(7);  
	
	--- Columnas
	col_1 <= (not pixel_x(9)) and (not pixel_x(8)) and (not pixel_y(7)); --000
	col_2 <= (not pixel_x(9)) and (not pixel_x(8)) and pixel_y(7);  --001
	col_3 <= (not pixel_x(9)) and pixel_x(8) and (not pixel_y(7)); --010
	col_4 <= (not pixel_x(9)) and pixel_x(8) and  pixel_x(7); --011
	col_5 <= (not pixel_x(9)) and pixel_x(8) and (not pixel_x(7)); --100
	
	-- Matcheo cada cuadrado de 128 x 128 con un caracter
	d1 <= fila_2 and col_1; 
	punto <= fila_2 and col_2; 
	d2 <= fila_2 and col_3;
	d3 <= fila_2 and col_4;
	volt <= fila_2 and col_5;
	
	-- Selectores del mux (hice tabla de verdad)
	sel_aux(0) <= ((not d1) and punto and (not d2) and (not d3) and (not volt)) or  
			((not d1) and (not punto) and (not d2) and d3 and (not  volt)); 
	
	sel_aux(1) <= ((not d1) and (not punto) and d2 and (not d3) and (not volt)) or  
			((not d1) and (not punto) and (not d2) and d3 and (not volt)); 
	
	sel_aux(2) <= ((not d1) and (not punto) and (not d2) and (not d3) and volt);
	
	sel_mux <= sel_aux; 
	
	-- Para seleccionar filas y columnas agarro los caracteres 4 5 y 6 de pixel x y el pixel y 
	-- que cambian cada 16 vueltas del reloj 
	
	font_col <= pixel_x(6) & pixel_x(5) & pixel_x(4); 
	font_row <= pixel_y(6) & pixel_y(5) & pixel_y(4) ; 
	
end;  
