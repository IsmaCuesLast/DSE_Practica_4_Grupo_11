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



entity Fantasma is
  Port ( 
    clk: in std_logic;        
    rst: in std_logic;        
    columna_fantasma : out std_logic_vector(4 downto 0); 
    fila_fantasma : out std_logic_vector(4 downto 0)
    ); 
end Fantasma;

architecture Behavioral of Fantasma is

   signal signal_fila: unsigned(4 downto 0);      
   signal signal_columna: unsigned(4 downto 0);     

   type movimiento_fan is (AR_DCHA,AB_DCHA,AR_IZD,AB_IZD);
   signal estado_actual, estado_siguiente : movimiento_fan;
   
   constant fcuenta_una_decima: natural := 10000000-1;
   signal conta: unsigned (23 downto 0);       
   signal pulso_una_decima: std_logic;
   
   
   

begin


 conta_una_decima : process (rst, clk)   
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
    
    

 Estado_inicial: process (rst, clk)
    begin
        if rst ='1' then
            estado_actual <= AB_IZD;
        elsif clk'event and clk='1' then
            if pulso_una_decima = '1' then
                 estado_actual <= estado_siguiente;
            end if;
        end if;
    end process;   
    
    

 Movimiento_fantasma: process (rst, clk)
    begin
        if rst = '1' then
            signal_fila <= (others => '0'); 
            signal_columna <= (others => '0'); 
        elsif clk'event and clk='1' then
            if pulso_una_decima = '1' then
                case estado_actual is
                    when AB_DCHA =>
                         signal_columna <= signal_columna + 1;
                         signal_fila <= signal_fila + 1;
                    when AB_IZD =>
                         signal_columna <= signal_columna - 1;
                         signal_fila <= signal_fila + 1;
                    when AR_DCHA =>
                        signal_columna <= signal_columna + 1;
                        signal_fila <= signal_fila - 1;
                    when AR_IZD =>
                        signal_columna <= signal_columna - 1;
                        signal_fila <= signal_fila - 1;
                end case;
            end if;
        end if;
    end process;
     
    
    Colisiones_borde_pantalla: process (estado_actual, signal_fila, signal_columna)        -- LIMITE DE EL FANTASMA CHOCANDO CON LOS BORDES
    begin
        estado_siguiente <= estado_actual;
             case estado_actual is
             
                 when AR_DCHA =>
                     if signal_columna < to_unsigned(30,5) and signal_fila > to_unsigned(1,5) then   
                        estado_siguiente <= AR_DCHA;
                     elsif signal_columna = to_unsigned(30,5) and signal_fila > to_unsigned(1,5) then
                        estado_siguiente <= AR_IZD;
                     elsif signal_fila = to_unsigned(1,5) and signal_columna < to_unsigned(30,5) then
                        estado_siguiente <= AB_DCHA;
                     elsif  signal_fila = to_unsigned(30,5) and signal_columna = to_unsigned(1,5) then
                        estado_siguiente <= AB_IZD;
                     end if;
                     
                 when AB_DCHA =>
                     if signal_fila < to_unsigned(28,5) and signal_columna < to_unsigned(30,5) then 
                          estado_siguiente <= AB_DCHA;
                     elsif signal_columna = to_unsigned(30,5) and signal_fila < to_unsigned(28,5) then
                        estado_siguiente <= AB_IZD;
                     elsif signal_fila = to_unsigned(28,5)and signal_columna < to_unsigned(30,5)  then
                        estado_siguiente <= AR_DCHA;
                     elsif  signal_fila = to_unsigned(28,5) and signal_columna = to_unsigned(30,5) then
                        estado_siguiente <= AR_IZD;  
                     end if;
                     
                  when AR_IZD =>
                     if signal_fila > to_unsigned(1,5) and signal_columna > to_unsigned(1,5) then 
                        estado_siguiente <= AR_IZD;
                     elsif signal_columna = to_unsigned(1,5)and signal_fila > to_unsigned(1,5) then
                        estado_siguiente <= AR_DCHA;
                     elsif signal_fila = to_unsigned(1,5) and signal_columna > to_unsigned(1,5) then
                        estado_siguiente <= AB_IZD;
                     elsif  signal_fila = to_unsigned(1,5) and signal_columna = to_unsigned(1,5) then
                        estado_siguiente <= AB_DCHA;
                     end if;
                        
                  when AB_IZD =>
                     if signal_columna > to_unsigned(1,5) and signal_fila < to_unsigned(28,5) then
                        estado_siguiente <= AB_IZD;
                     elsif signal_columna = to_unsigned(1,5)and signal_fila < to_unsigned(28,5) then
                        estado_siguiente <= AB_DCHA;
                     elsif signal_fila = to_unsigned(28,5)and signal_columna > to_unsigned(1,5) then
                        estado_siguiente <= AR_IZD;
                     elsif  signal_fila = to_unsigned(28,5) and signal_columna = to_unsigned(1,5) then
                        estado_siguiente <= AR_DCHA;
                     end if;
             end case;
    end process;
    
    
    fila_fantasma <= std_logic_vector(signal_fila);
    columna_fantasma <= std_logic_vector(signal_columna);
    


end Behavioral;
