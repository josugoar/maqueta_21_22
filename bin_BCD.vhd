library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity bin_BCD is
port(
clk: in std_logic;
inicio: in std_logic;
sw: in std_logic_vector (11 downto 0);
tipo: in std_logic_vector (1 downto 0);
enable: in std_logic;
enable_seg: out std_logic_vector (3 downto 0);
segmentos: out std_logic_vector (6 downto 0)
);
end bin_BCD;

architecture Behavioral of bin_BCD is

signal num_aux: integer range 0 to 5000;
signal num_aux1: integer range 0 to 99;
signal num_aux2: integer range 0 to 99;

signal sal_mux: integer range 0 to 9;
signal unidades: integer range 0 to 9;
signal decenas: integer range 0 to 9;
signal centenas: integer range 0 to 9;
signal millares: integer range 0 to 9;
signal enable_aux: std_logic_vector (3 downto 0);
signal cont_base_enable: integer range 0 to 100000;


begin

num_aux <=to_integer(unsigned(sw(11 downto 0)));
num_aux1 <=to_integer(unsigned(sw(5 downto 0)));
num_aux2 <=to_integer(unsigned(sw(11 downto 6)));
                     

process(clk, inicio)
begin
if inicio='1' then
    unidades<=0;
    decenas<=0;
    centenas<=0;
    millares<=0;
elsif rising_edge(clk) then
    if tipo = "00" then
        unidades <= num_aux mod 10;
        decenas <= (num_aux/10)mod 10;
        centenas <= (num_aux/100)mod 10;
        millares <= (num_aux/1000)mod 10;
     elsif tipo = "01" then
        unidades <= num_aux1 mod 10;
        decenas <= (num_aux1/10)mod 10;
        centenas <= num_aux2 mod 10;
        millares <= (num_aux2/10)mod 10;
     else
        unidades <= num_aux mod 10;
        decenas <= (num_aux/10)mod 10;
        centenas <= (num_aux/100)mod 10;
        millares <= (num_aux/1000)mod 10;
     end if;
end if;
end process;                                              
                        
process(inicio, clk)
begin
if inicio='1' then
   cont_base_enable<=0;
elsif rising_edge(clk) then
      if cont_base_enable=100000 then 
         cont_base_enable<=0;
      else
         cont_base_enable<=cont_base_enable+1;
      end if;
end if;
end process;

process(clk,inicio)
begin
if inicio='1' then
   enable_aux<="1110";
elsif rising_edge(clk) then
    if cont_base_enable=100000 then
	      enable_aux<=enable_aux(2 downto 0)&enable_aux(3);
    end if;
end if;
end process;
--fin de la activaciÃ³n de los siete seg

enable_seg<=enable_aux;

--multiplexado de las entradas al 7-seg
process(enable_aux, unidades, decenas)
begin
case enable_aux is
when "1110" => sal_mux<=unidades;
when "1101" => sal_mux<=decenas;
when "1011" => sal_mux<=centenas;
when "0111" => sal_mux<=millares;
when others => sal_mux<=0;
end case;
end process;

--descripcion del decodificador BCD-7segmentos
process(sal_mux)
begin
case sal_mux is
when 0 => segmentos<="0000001";
when 1 => segmentos<="1001111";
when 2 => segmentos<="0010010";
when 3 => segmentos<="0000110";
when 4 => segmentos<="1001100";
when 5 => segmentos<="0100100";
when 6 => segmentos<="1100000";
when 7 => segmentos<="0001111";
when 8 => segmentos<="0000000";
when 9 => segmentos<="0001100";
when others => segmentos<="1111111";
end case;
end process;--final de decodificador BCD-7seg

end Behavioral;
