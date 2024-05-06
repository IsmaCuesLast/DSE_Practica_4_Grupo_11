------- ROM creada automaticamente por ppm2rom -----------
------- Felipe Machado -----------------------------------
------- Departamento de Tecnologia Electronica -----------
------- Universidad Rey Juan Carlos ----------------------
------- http://gtebim.es ---------------------------------
----------------------------------------------------------
--------Datos de la imagen -------------------------------
--- Fichero original    : racetrack_1.ppm 
--- Filas    : 30 
--- Columnas : 32 
--- Color    :  Blanco y negro. 2 niveles (1 bit)



------ Puertos -------------------------------------------
-- Entradas ----------------------------------------------
--    clk  :  senal de reloj
--    addr :  direccion de la memoria
-- Salidas  ----------------------------------------------
--    dout :  dato de 32 bits de la direccion addr (un ciclo despues)


library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
  use IEEE.NUMERIC_STD.ALL;


entity ROM1b_1f_green_racetrack_1 is
  port (
    clk  : in  std_logic;   -- reloj
    addr : in  std_logic_vector(5-1 downto 0);
    columna : in  std_logic_vector(9 downto 0);
    dato_fondo : out std_logic  
  );
end ROM1b_1f_green_racetrack_1;


architecture BEHAVIORAL of ROM1b_1f_green_racetrack_1 is
  signal dout : std_logic_vector(32-1 downto 0) := (others => '0');
  signal addr_int  : natural range 0 to 2**5-1;
  type memostruct is array (natural range<>) of std_logic_vector(32-1 downto 0);
  constant filaimg : memostruct := (
       "11111111111111111111111111111111",
       "11111000000000000111111111111111",
       "11100011111111110011111111111111",
       "11001111111111111001111111111111",
       "10011111111111111100111111111111",
       "10111111111111111110000000001111",
       "10111111111000111111111111100111",
       "10111111100010011111111111110011",
       "10111111001111001111111111111011",
       "10111111011111100000000011111001",
       "10111110011111111111111001111101",
       "10111110111111111110000011111101",
       "10111110111111111100111111111101",
       "10111110011111111101111111111001",
       "10111111000111111101111111100011",
       "10111111110011111101110000001111",
       "10111111111001111101110000001111",
       "10011111111100111101111111100111",
       "11001111111110011101111111110011",
       "11100111111111011100111111111001",
       "11110000111111011110000011111101",
       "11111110011111011111111011111101",
       "11111111011111000000000011111101",
       "11111111011111111011111111111101",
       "11111111011111111011111111111101",
       "11111111011111111011111111111101",
       "11111111001111111011111111111001",
       "11111111100111111011111111110011",
       "11111111110000000000000000000111",
       "11111111111111111111111111111111"
        );

begin

  addr_int <= TO_INTEGER(unsigned(addr));

  P_ROM: process (clk)
  begin
    if clk'event and clk='1' then
      dout <= filaimg(addr_int);
    end if;
  end process;
  
   dato_fondo <= dout(0) when columna(9 downto 4)="000000" else 
                dout(1) when columna(9 downto 4)="000001" else
                dout(2) when columna(9 downto 4)="000010" else
                dout(3) when columna(9 downto 4)="000011" else
                dout(4) when columna(9 downto 4)="000100" else
                dout(5) when columna(9 downto 4)="000101" else
                dout(6) when columna(9 downto 4)="000110" else
                dout(7) when columna(9 downto 4)="000111" else
                dout(8) when columna(9 downto 4)="001000" else
                dout(9) when columna(9 downto 4)="001001" else
                dout(10) when columna(9 downto 4) ="001010" else
                dout(11) when columna(9 downto 4) ="001011" else
                dout(12) when columna(9 downto 4) ="001100" else
                dout(13) when columna(9 downto 4) ="001101" else
                dout(14) when columna(9 downto 4) ="001110" else
                dout(15) when columna(9 downto 4)="001111" else 
                dout(16) when columna(9 downto 4)="010000" else
                dout(17) when columna(9 downto 4)="010001" else
                dout(18) when columna(9 downto 4)="010010" else
                dout(19) when columna(9 downto 4)="010011" else
                dout(20) when columna(9 downto 4)="010100" else
                dout(21) when columna(9 downto 4)="010101" else
                dout(22) when columna(9 downto 4)="010110" else
                dout(23) when columna(9 downto 4)="010111" else
                dout(24) when columna(9 downto 4)="011000" else
                dout(25) when columna(9 downto 4) ="011001" else
                dout(26) when columna(9 downto 4) ="011010" else
                dout(27) when columna(9 downto 4) ="011011" else
                dout(28) when columna(9 downto 4) ="011100" else
                dout(29) when columna(9 downto 4) ="011101" else
                dout(30) when columna(9 downto 4) ="011110" else
                dout(31); 

end BEHAVIORAL;

