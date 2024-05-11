----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2024 15:21:00
-- Design Name: 
-- Module Name: pacman_tb - Behavioral
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

entity pacman_tb is
--  Port ( );
end pacman_tb;

architecture Behavioral of pacman_tb is

    signal clk : std_logic := '1';   --señales para asignar a cada entrada y salida
    signal rst : std_logic;
    constant ClockFrecuency : integer := 100e6;     -- Periodo y fecuencia del clock
    constant ClockPeriod : time := 1000ms/ClockFrecuency;
    signal btnu,btnd,btnr,btnl : std_logic;   --botones 
    signal fila_pacman,columna_pacman : std_logic_vector (4 downto 0); 
    
component Pacman_mov is      -- entradas y salidas del pacman
  Port (
            clk: in std_logic;
            rst: in std_logic;
            
            btnu : in std_logic;
            btnd : in std_logic;
            btnr : in std_logic;
            btnl : in std_logic;
            fila_pacman: out std_logic_vector(4 downto 0);
            columna_pacman: out std_logic_vector(4 downto 0)
            );
end component;


begin
UUT : Pacman_mov
port map(clk => clk,  --asignación de las entradas y salidas a las señales
         rst => rst,
         columna_pacman => columna_pacman,
         fila_pacman => fila_pacman,
         btnu => btnu,
         btnd => btnd,
         btnr => btnr,
         btnl => btnl);

clk <= not clk after ClockPeriod/2;   --definimos el clock para que empiece en 0 y tenga un pulso cada medio periodo
rst <= '1', '0' after 10 ns;     --definimos el reset a 1 al principio para comporbar que funciona y despues a 0
btnd <= '0', '1' after 150 ns, '0' after 300 ns; -- boton abajo
btnr <= '0', '1' after 350 ns, '0' after 500 ns; --boton derecha
btnu <= '0', '1' after 550 ns, '0' after 700 ns; --boton arriba
btnl <= '0', '1' after 750 ns, '0' after 900 ns; --boton izquierda

end Behavioral;
