--------------------------------------------------------------------------------
-- Felipe Machado Sanchez
-- Departameto de Tecnologia Electronica
-- Universidad Rey Juan Carlos
-- http://gtebim.es/~fmachado
--
-- Pinta barras para la XUPV2P


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pinta is  --declaramos las entradas y  salidas
  Port ( 
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
end pinta;



architecture Behavioral of pinta is  --declaramos las señales

  constant c_bar_width : natural := 64;
  constant c_nb_red : natural := 4;
  constant c_nb_green : natural := 4;
  constant c_nb_blue : natural := 4;
  constant c_pxl_visible : natural := 640;
  constant c_line_visible : natural := 480;
  
  signal columna_interna: std_logic_vector(3 downto 0);
  signal fila_interna: std_logic_vector(3 downto 0);
  signal fila_cuadricula: std_logic_vector(5 downto 0);
  signal columna_cuadricula: std_logic_vector(5 downto 0);
  signal columna: std_logic_vector(9 downto 0);     
  signal fila: std_logic_vector(9 downto 0);     
  signal fantasma_pintar: std_logic;
  signal pacman_pintar: std_logic;
  signal pintar: std_logic;


begin
columna<= std_logic_vector(visible_columna);
fila<= std_logic_vector(visible_fila);
  
    
  Pinta_juego: Process (visible_pinta, visible_columna, visible_fila,dato_fondo)
  begin                             -- inicio todo rn negro
    rojo   <= (others=>'0');
    verde  <= (others=>'0');
    azul   <= (others=>'0');
    
    if visible_pinta = '1' then   -- declaracion para ver cuando se pinta el pacman/fantasma
                  
        if columna(9 downto 4)= ('0' & std_logic_vector(columna_pacman)) and fila (8 downto 4)= std_logic_vector(fila_pacman)then
                 pacman_pintar <= '1';
        end if;
             
        if columna(9 downto 4)=('0' & std_logic_vector(columna_fantasma)) and fila (8 downto 4)= std_logic_vector(fila_fantasma)then
                fantasma_pintar <= '1';
        end if;
           
        if fantasma_pintar = '1' or pacman_pintar = '1' then
             pintar <= '1';
        end if;
        
        
        
        if dato_fondo(2) = '1' then                         -- asignamos los distintos colores en funcion de la memoria del circuito que usemos para pintar el circuito a colores  
            rojo   <= (others=>'1');
        else    
            rojo   <= (others=>'0');  
        end if;
        if dato_fondo(1) = '1' then     
            verde  <= (others=>'1');
        else    
            verde  <= (others=>'0');
        end if;                    
        if dato_fondo(0) = '1' then      
            azul   <= (others=>'1');
        else    
            azul   <= (others=>'0');   
        end if; 
        
        if visible_columna > 511 then  -- pintamos el recuadro final (parte que nos sobra de la pantalla que no ocupa la memoria del circuito)
               rojo   <= (others=>'1');
               verde  <= (others=>'1');
               azul   <= (others=>'1');
        end if;
        
                         
        if pintar = '1' then                        --declaracion para actualizar el fondo de la memoria del pacman cuando se mueva, y adquiera el color del fondo.
            if pacman_pintar = '1' then                         
                if dato_memo = '1' then                      
                    if dato_fondo(2) = '1' then                                                       
                        rojo   <= (others=>'1');
                        else    
                        rojo   <= (others=>'0');  
                    end if;
                    if dato_fondo(1) = '1' then     
                        verde  <= (others=>'1');
                        else    
                        verde  <= (others=>'0');
                    end if;                    
                    if dato_fondo(0) = '1' then      
                        azul   <= (others=>'1');
                    else    
                        azul   <= (others=>'0');   
                    end if; 
             else                                         
                rojo   <= (others=>'1');
                verde  <= (others=>'1');
                azul   <= (others=>'0');
            end if;


            elsif fantasma_pintar = '1' then                 --declaracion para actualizar el fondo de la memoria del fantasma cuando se mueva, y adquiera el color del fondo.         
                 if dato_memo = '1' then                       
                    if dato_fondo(2) = '1' then                                                    
                        rojo   <= (others=>'1');
                        else    
                        rojo   <= (others=>'0');  
                    end if;
                    if dato_fondo(1) = '1' then     
                        verde  <= (others=>'1');
                        else    
                        verde  <= (others=>'0');
                    end if;                    
                    if dato_fondo(0) = '1' then      
                        azul   <= (others=>'1');
                    else    
                        azul   <= (others=>'0');   
                    end if; 
            else                                             
               rojo   <= (others=>'1');
               verde  <= (others=>'0');
               azul   <= (others=>'1');
                end if;
            end if;
         end if;
    end if;

  end process;
  
end Behavioral;













