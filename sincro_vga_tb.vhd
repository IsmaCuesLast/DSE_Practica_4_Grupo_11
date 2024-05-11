----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2024 19:34:47
-- Design Name: 
-- Module Name: sincro_vga_tb - Behavioral
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

entity sincro_vga_tb is
--  Port ( );
end sincro_vga_tb;

architecture Behavioral of sincro_vga_tb is


       constant ClockFrecuency : integer := 100e6;  --señales para asignar a las entradas y salidas del VGA
       constant ClockPeriod : time := 1000 ms/ClockFrecuency;  --Periodo del clock
       signal clk : std_logic :='1'; --clock lo asignamos a 1
       signal rst : std_logic;
       signal hsinc : std_logic;
       signal visible : std_logic;
       signal vsinc : std_logic;
       signal fila : unsigned(9 downto 0);     
       signal columna : unsigned(9 downto 0);

component VGA is
  Port (                       --entradas y salidas del VGA
        clk : in std_logic;
        rst : in std_logic;
        hsinc : out std_logic;     
        visible : out std_logic;     
        vsinc : out std_logic;     
        fila : out unsigned(9 downto 0);     
        columna : out unsigned(9 downto 0)     
         );
end component;
begin     --asignación de las entradas y salidas a las señales creadas

UUT :  VGA port map (clk=>clk, rst=>rst, hsinc=>hsinc, vsinc=>vsinc, visible=>visible, fila=>fila, columna=>columna);

clk <= not clk after ClockPeriod/2;  --el clock empezará en 0 y tendrá un impulso cada medio periodo
rst <= '1', '0' after 5 ns;

end Behavioral;
