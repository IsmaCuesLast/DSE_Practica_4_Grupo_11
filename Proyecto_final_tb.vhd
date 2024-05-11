----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2024 15:51:40
-- Design Name: 
-- Module Name: Proyecto_final_tb - Behavioral
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

entity Proyecto_final_tb is
--  Port ( );
end Proyecto_final_tb;

architecture Behavioral of Proyecto_final_tb is

    signal clk : std_logic := '1';    -- señales para asignar al component
    signal rst : std_logic;
    constant ClockFrecuency : integer := 100e6;
    constant ClockPeriod : time := 1000ms/ClockFrecuency;
    signal btnu,btnd,btnr,btnl,hsinc,vsinc : std_logic;
    signal rojo,azul,verde : std_logic_vector (3 downto 0);

component Proyecto_final is   --entradas y salidas del Proyecto_final
  Port ( 
    clk: in std_logic;
    rst: in std_logic;
    btnu: in std_logic;
    btnd: in std_logic;
    btnr: in std_logic;
    btnl: in std_logic;
    
    hsinc: out std_logic;
    vsinc: out std_logic;
    
    rojo: out std_logic_vector(3 downto 0); 
    azul: out std_logic_vector(3 downto 0); 
    verde: out std_logic_vector(3 downto 0)
    ); 
end component;


 
begin
UUT : Proyecto_final   -- asignación de las entradas y salidas a las señales
port map(clk => clk,
         rst => rst,
         btnu => btnu,
         btnd => btnd,
         btnr => btnr,
         btnl => btnl,
         hsinc => hsinc,
         vsinc => vsinc,
         rojo => rojo,
         verde => verde,
         azul => azul);

clk <= not clk after ClockPeriod/2; -- definimos las entradas con valores para poder ver su funcionamiento en pantalla
rst <= '1', '0' after 10 ns;
btnd <= '0', '1' after 150 ns, '0' after 300 ns;
btnr <= '0', '1' after 350 ns, '0' after 500 ns;
btnu <= '0', '1' after 550 ns, '0' after 700 ns;
btnl <= '0', '1' after 750 ns, '0' after 900 ns;

end Behavioral;
