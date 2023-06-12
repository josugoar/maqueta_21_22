library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity my_quimat is
port(
clk: in std_logic; -- clk es el reloj de 125 MHz que da el propio Zynq/Zybo
reset: in std_logic;
enable: in std_logic;
dir: in std_logic;
enable_sal: out std_logic;
dir_sal: out std_logic;
frecuencia_paso_paso: in std_logic_vector (8 downto 0);
step: out std_logic --control del motor paso a paso con la secuencia con el driver A4988 (solo un pulso)
);
end my_quimat;

architecture Behavioral of my_quimat is

signal reloj_paso_paso: integer range 0 to 10000000; --para generar la frecuencia de 50 Hz
signal paso_paso_aux: std_logic; --para generar la salida
signal tope_frecuencia_paso_paso: integer range 0 to 1000000000; --para controlar la velocidad
signal frecuencia_paso_paso_entero: integer range 0 to 10000;
signal reset_aux: std_logic;
signal enable_aux: std_logic;

begin

frecuencia_paso_paso_entero<=to_integer(unsigned(frecuencia_paso_paso));

tope_frecuencia_paso_paso<=(100000000/(frecuencia_paso_paso_entero*40))/2;

process(clk, reset)
begin
if reset='1' then
    reloj_paso_paso<=0;
elsif rising_edge(clk) then
   if reloj_paso_paso=tope_frecuencia_paso_paso then --0 then
        reloj_paso_paso<=0;
   else
        reloj_paso_paso<=reloj_paso_paso+1;
   end if;
end if;
end process;

process(clk)
begin
if clk='1' and clk'event then
    if reloj_paso_paso=0 then -- con el A
        paso_paso_aux<=not(paso_paso_aux);
    end if;
end if;
end process;

enable_sal<=enable;
dir_sal<=dir;

step<=paso_paso_aux;

end Behavioral;
