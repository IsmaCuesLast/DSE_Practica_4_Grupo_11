----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: 
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA is
  Port ( 
    clk : in std_logic;
    rst : in std_logic;
    hsinc : out std_logic;     
    visible : out std_logic;     
    vsinc : out std_logic;     
    fila : out unsigned(9 downto 0);     
    columna : out unsigned(9 downto 0)
    );
end VGA;

architecture Behavioral of VGA is

  signal clk_contador: unsigned (1 downto 0);   --cuenta hasta 4 veces el clk
  signal col_contador: unsigned (9 downto 0);   --cuenta hasta 800 columnas y 520 lineas, ambos coinciden en el vector
  signal fil_contador: unsigned (9 downto 0);   --cuenta hasta 800 columnas y 520 lineas, ambos coinciden en el vector
  
  constant fcuenta_clk : natural:= 3; 
  constant fcuenta_col : natural:= 799;
  constant fcuenta_fil : natural:= 519; 
  
  signal pixel_nuevo: std_logic;          
  signal fila_nueva: std_logic;     
  signal sincro_ver: std_logic;     
  signal sincro_hor: std_logic;     
  signal col_visible: std_logic;     
  signal fil_visible: std_logic;     
  signal fin_fila : std_logic;     

begin


contador : process (rst, clk)   -- Contador
        begin
            if rst = '1' then
                clk_contador <= (others => '0');
            elsif clk'event and clk = '1' then
                if pixel_nuevo = '1' then
                    clk_contador <= (others => '0');
                else
                    clk_contador <= clk_contador + 1;
                end if;
            end if;
        end process;
        
   pxl_clk:  pixel_nuevo <= '1' when clk_contador = fcuenta_clk else '0';
   
   
   
   cuenta_pixeles : process (rst,clk)   -- Contador
        begin
            if rst = '1' then
                col_contador <= (others => '0');
            elsif clk 'event and clk = '1' then
                if fila_nueva = '1' then
                    col_contador <= (others => '0');
                else
                   
                    if pixel_nuevo = '1' then
                         col_contador <= col_contador + 1;
                    end if;
                end if;
            end if;
        end process;
        
   fila_nueva <= '1' when (col_contador = fcuenta_col and pixel_nuevo = '1') else '0'; -- se pone la puerta and para que cuando llegue a fin de cuenta no se cambie en el primer ciclo de relog sino cuando le diga el anterior contador
  col_visible <= '1' when col_contador < "1010000000" else '0';     -- visible cuando sea menor que 640
   
   columna <= col_contador;
  
        
   cuenta_filas : process (rst,clk)   -- Contador
        begin
            if rst = '1' then
                fil_contador <= (others => '0');
            elsif clk 'event and clk = '1' then
                if fin_fila = '1' then
                    fil_contador <= (others => '0');
                else 
                    if fila_nueva = '1' then
                        fil_contador <= fil_contador + 1;
                    end if;
                end if;
            end if;
        end process;
   fin_fila <= '1' when (fil_contador = fcuenta_fil and fila_nueva = '1') else '0';        
   
   fila <= fil_contador;
   fil_visible <= '1' when fil_contador < "0111100000" else '0';       -- visible cuando sea menor que 480
   vsinc <= sincro_ver;
   
   
   sincro_horizontal: process (col_contador)           
    begin
        if col_contador > "1010001110" and col_contador < "1011101111" then            -- cuando se encuentre entre 655 y 751 porque cambia en el siguiente flanco de subida
               sincro_hor <= '0';
        else   sincro_hor <= '1';
        end if;
    end process;
    
    
   
   sincro_vertical: process (fil_contador)
        begin
            if fil_contador > "111101000" and fil_contador < "111101011" then                 -- cuando se encuentre entre 488 y 491 por lo mismo que arriba
                   sincro_ver <= '0';
            else   sincro_ver <= '1';
            end if;
        end process;
        
    hsinc <= sincro_hor;
    vsinc <= sincro_ver;
    visible <= '1' when (col_visible = '1' and fil_visible = '1') else '0';      -- puerta anda para ver si es visible o no

end Behavioral;
