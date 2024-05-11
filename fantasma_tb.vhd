----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2024 14:59:16
-- Design Name: 
-- Module Name: fantasma_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fantasma_tb is
--  Port ( );
end fantasma_tb;

architecture Behavioral of fantasma_tb is
     signal clk : std_logic := '1';    --señales que se asignan a las entradas y salidas 
     signal rst : std_logic;
     constant ClockFrecuency : integer := 100e6;
     constant ClockPeriod : time := 1000ms/ClockFrecuency;
     signal columna_fantasma : std_logic_vector (4 downto 0);
     signal fila_fantasma : std_logic_vector (4 downto 0);

component Fantasma is    --entradas y salidas del Fantasma
  Port ( 
    clk: in std_logic;        
    rst: in std_logic;        
    columna_fantasma : out std_logic_vector(4 downto 0); 
    fila_fantasma : out std_logic_vector(4 downto 0)
    ); 
end component;


begin
UUT : Fantasma
port map(clk => clk,   --asignación de las entradas y salidas a las señales previamente creadas
         rst => rst,
         columna_fantasma => columna_fantasma,
         fila_fantasma => fila_fantasma);

clk <= not clk after ClockPeriod/2;  --solo se definen el clock y reset, ya que las demás son salidas
rst <= '1', '0' after 10 ns;
 

end Behavioral;
