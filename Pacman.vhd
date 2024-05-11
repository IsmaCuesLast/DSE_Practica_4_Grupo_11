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
use IEEE.NUMERIC_STD.ALL;



entity Pacman_mov is   --declaramos entradas y salidas
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
end Pacman_mov;

architecture Behavioral of Pacman_mov is -- declaramos las señales necesarias

--   constant fcuenta_una_decima: natural := 10000000-1; --valor para la placa
   constant fcuenta_una_decima: natural := 10; --valor para la simulacion
--   signal conta: unsigned (23 downto 0);     --valor para la placa
   signal conta: unsigned (3 downto 0);       --valor para la simulacion
   signal pulso_una_decima: std_logic;
   
   signal signal_columna: unsigned(4 downto 0); 
   signal signal_fila: unsigned(4 downto 0); 

   

begin
    
    
    conta_una_decima : process (rst, clk)   -- contador de una decima
        begin
            if rst = '1' then
                conta <= (others => '0');
            elsif clk'event and clk = '1' then
                if pulso_una_decima = '1' then
                    conta <= (others => '0');
                else
                    conta <= conta + 1;
                end if;
            end if;
        end process;
    pulso_una_decima <= '1' when conta = to_unsigned(fcuenta_una_decima,24) else '0';
    
    
    movimiento_arriba_abajo: process(rst, clk)            -- proceso que efectua el movimiento vertical de nuestro jugador, en funcion de los botones de la FPGA                                     
        begin                                             -- cuando se pulsan los botones indicados y el jugador se encuntra dentro del rango admisible de la pantalla,
        if rst = '1' then                                 -- el jugador se mueve arriba o abajo.
            signal_fila <= (others => '0'); 
            
        elsif clk'event and clk='1' then  
            if  pulso_una_decima = '1' then  
                if btnu = '1' and signal_fila = to_unsigned(0,5) then
                    signal_fila <= signal_fila;
                elsif btnu = '1' and signal_fila > to_unsigned(0,5) then
                    signal_fila <= signal_fila - 1;
                elsif btnd = '1' and signal_fila = to_unsigned(29,5) then
                    signal_fila <= signal_fila;
                elsif btnd = '1' and signal_fila < to_unsigned(29,5) then
                    signal_fila <= signal_fila + 1;
                end if;
            end if;
       end if;
   end process;
       
    
   
    movimiento_izda_dcha: process(rst, clk)                                 -- proceso que efectua el movimiento horizontal de nuestro jugador, en funcion de los botones de la FPGA                
        begin                                                               -- cuando se pulsan los botones indicados y el jugador se encuntra dentro del rango admisible de la pantalla,
        if rst = '1' then                                                   -- el jugador se mueve a la izquierda o derecha.
            signal_columna <= (others => '0'); 
            
        elsif clk'event and clk='1' then
            if  pulso_una_decima = '1' then
                if btnr = '1' and signal_columna = to_unsigned(31,5) then
                    signal_columna <= signal_columna;
                elsif btnr = '1' and signal_columna < to_unsigned(31,5) then
                    signal_columna <= signal_columna + 1;
                elsif btnl = '1' and signal_columna = to_unsigned(0,5) then
                    signal_columna <= signal_columna;
                elsif btnl = '1' and signal_columna > to_unsigned(0,5) then
                    signal_columna <= signal_columna - 1;
                end if;
            end if;
       end if;
  end process;
       
   
   columna_pacman <= std_logic_vector(signal_columna);
   fila_pacman <= std_logic_vector(signal_fila);
        
          
     

end Behavioral;
