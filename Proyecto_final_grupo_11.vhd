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


entity Proyecto_final is  -- declaramos entradas y salidas de todo nuestro sistema
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
 
end Proyecto_final;



architecture Estructural of Proyecto_final is  -- declaramos todas las señales
  signal visible: std_logic;  
  signal fila,columna:  std_logic_vector(9 downto 0);
 
  signal addr: std_logic_vector(8-1 downto 0);
  signal dout: std_logic_vector(16-1 downto 0); 
  
  signal fila_pacman:  std_logic_vector(4 downto 0);
  signal columna_pacman:  std_logic_vector(4 downto 0);
 
  signal columna_fantasma: std_logic_vector(4 downto 0);
  signal fila_fantasma: std_logic_vector(4 downto 0);
  
  signal dato_memo : std_logic;
  signal dato_fondo : std_logic_vector (2 downto 0);
  signal condicion_pinta : std_logic;
  
  signal addr1:std_logic_vector(5-1 downto 0);
  signal dato_fondo_rojo:std_logic;
  signal dato_fondo_azul:std_logic;
  signal dato_fondo_verde:std_logic;
  
  component VGA is   -- declaramos todos los sources de nuestro proyecto como components
        port(
            clk : in std_logic;
            rst : in std_logic;
            hsinc : out std_logic;     
            visible : out std_logic;     
            vsinc : out std_logic;     
            fila : out unsigned(9 downto 0);     
            columna : out unsigned(9 downto 0)
            );
   end component;
   
   
   
   component pinta is
        port (
            visible_pinta: in std_logic;
            visible_columna: in unsigned(9 downto 0);
            visible_fila: in unsigned(9 downto 0);
    
            columna_pacman: in std_logic_vector(4 downto 0);
            fila_pacman: in std_logic_vector(4 downto 0);
            columna_fantasma: in std_logic_vector(4 downto 0); 
            fila_fantasma: in std_logic_vector(4 downto 0); 
              
            dato_memo: in std_logic;
            dato_fondo: in std_logic_vector (2 downto 0);
            
            rojo:out std_logic_vector(3 downto 0);
            verde:out std_logic_vector(3 downto 0);
            azul:out std_logic_vector(3 downto 0)
            );
    end component;
    
    component Pacman_mov is
        port (
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
     
     
     component memoria is
        port (
            clk: in std_logic;
            addr: in std_logic_vector(8-1 downto 0);
            columna: in std_logic_vector(9 downto 0);
            dato_memo: out std_logic
             );
     end component;
     
     
     component selector_sprites is 
        port(
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
      end component;
     
     
     component Fantasma is
        port (
           clk : in std_logic;
           rst : in std_logic;
           columna_fantasma: out std_logic_vector(4 downto 0);
           fila_fantasma: out std_logic_vector(4 downto 0));
     end component;

component ROM1b_1f_blue_racetrack_1 is
  port (
    clk  : in  std_logic;   -- reloj
    addr : in  std_logic_vector(5-1 downto 0);
    columna : in  std_logic_vector(9 downto 0);
    dato_fondo : out std_logic 
  );
end component;

component ROM1b_1f_green_racetrack_1 is
  port (
    clk  : in  std_logic;   -- reloj
    addr : in  std_logic_vector(5-1 downto 0);
    columna : in  std_logic_vector(9 downto 0);
    dato_fondo : out std_logic 
  );
end component;

component ROM1b_1f_red_racetrack_1 is
  port (
    clk  : in  std_logic;   -- reloj
    addr : in  std_logic_vector(5-1 downto 0);
    columna : in  std_logic_vector(9 downto 0);
    dato_fondo : out std_logic 
  );
end component;
  
begin
                           --instanciamos los port maps de nuestros components
    Sincro_VGA: VGA 
    port map(
         clk => clk,
         rst => rst,
         std_logic_vector(fila) => fila, 
         std_logic_vector(columna)=> columna, 
         visible => visible,
         hsinc =>  hsinc,
         vsinc => vsinc
         );
                 
    Pinta_VGA: pinta 
    port map(
         visible_fila => unsigned(fila),
         visible_columna => unsigned(columna),
         visible_pinta => visible,
         verde => verde,
         rojo => rojo,
         azul => azul,
         columna_pacman => columna_pacman,
         fila_pacman => fila_pacman,
         fila_fantasma => fila_fantasma,
         columna_fantasma => columna_fantasma,
         dato_memo => dato_memo,
         dato_fondo => dato_fondo
         );
         
         
         
     Movimiento_Pacman: Pacman_mov 
     port map(
            clk => clk,
            rst => rst,
            btnl => btnl,
            btnr => btnr,
            btnd => btnd,
            btnu => btnu,
            columna_pacman => columna_pacman,
            fila_pacman=> fila_pacman
            );
            
            
      Memoria_Sprites: memoria 
      port map(
            clk => clk,
            addr => addr,
            columna => columna,
            dato_memo => dato_memo
            );
            
            
      Memoria_jugador : selector_sprites 
      port map(
            clk => clk,
            rst => rst,
            fila => fila,
            columna => columna,
            addr => addr,
            addr1 => addr1,
            columna_pacman => columna_pacman,
            fila_pacman => fila_pacman,
            fila_fantasma => fila_fantasma,
            columna_fantasma => columna_fantasma
            );
                
      Movimiento_Fantasma: Fantasma 
      port map(
            clk => clk,
            rst => rst,
            fila_fantasma => fila_fantasma,
            columna_fantasma => columna_fantasma
            );

       circuito_rojo : ROM1b_1f_red_racetrack_1
       port map(
            clk => clk,
            addr => addr1,
            columna => columna,
            dato_fondo => dato_fondo_rojo         
                );  
       
       circuito_verde : ROM1b_1f_green_racetrack_1
       port map(
            clk => clk,
            addr => addr1,
            columna => columna,
            dato_fondo => dato_fondo_verde         
                );
       
       circuito_azul : ROM1b_1f_blue_racetrack_1
       port map(
            clk => clk,
            addr => addr1,
            columna => columna,
            dato_fondo => dato_fondo_azul         
                );
       dato_fondo <= (dato_fondo_rojo & dato_fondo_verde & dato_fondo_azul);
end Estructural;
    