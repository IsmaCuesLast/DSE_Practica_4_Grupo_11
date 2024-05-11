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



entity selector_sprites is     --declaramos entradas y salidas
  Port (
        rst: in std_logic;
        clk: in std_logic;
        
        fila : in STD_LOGIC_VECTOR(9 downto 0);
        columna : in STD_LOGIC_VECTOR(9 downto 0);
        addr: out std_logic_vector(7 downto 0);
        addr1: out std_logic_vector(4 downto 0);
        
        columna_pacman: in std_logic_vector(4 downto 0);
        fila_pacman: in std_logic_vector(4 downto 0);
        columna_fantasma: in std_logic_vector(4 downto 0);
        fila_fantasma: in std_logic_vector(4 downto 0)
        );
   
end selector_sprites;



architecture Behavioral of selector_sprites is    -- declaramos las señales necesarias

constant pacman: std_logic_vector (3 downto 0):="0011";
constant fantasma: std_logic_vector (3 downto 0):="0100";

   
    begin --proceso que selecciona el sprite del directorio
        
      Selector_sprite: process(fila,columna,fila_pacman,columna_pacman,fila_fantasma,columna_fantasma)
          begin
                if fila(8 downto 4) =  fila_pacman and columna(8 downto 4) = columna_pacman then
                    addr <= pacman & fila(3 downto 0);
                    
                elsif fila(8 downto 4) = fila_fantasma and columna(8 downto 4) = columna_fantasma then
                     addr <= fantasma & fila(3 downto 0);                
                end if;     
        end process;
        
        addr1 <= fila(8 downto 4) ;
        


end Behavioral;
