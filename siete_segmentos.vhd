library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity segmentos is
port(
clk: in std_logic;
inicio: in std_logic;
segmentos: out std_logic_vector (6 downto 0);
enable_seg: out std_logic_vector (3 downto 0);
unidades: in std_logic_vector (3 downto 0);
decenas: in std_logic_vector (3 downto 0);
centenas: in std_logic_vector (3 downto 0);
millares: in std_logic_vector (3 downto 0)
);

end segmentos;

architecture Behavioral of segmentos is

signal enable_aux: std_logic_vector (3 downto 0);
signal base_enable: integer range 0 to 10000000;
signal sal_mux: std_logic_vector (3 downto 0);

begin

process(inicio, clk)
begin
if inicio='1' then
   base_enable<=0;
elsif rising_edge(clk) then
      if base_enable=100000 then
         base_enable<=0;
      else
         base_enable<=base_enable+1;
      end if;
end if;
end process;

process(clk,inicio)
begin
if inicio='1' then
   enable_aux<="1110";
elsif rising_edge(clk) then
    if base_enable=100000 then
	      enable_aux<=enable_aux(2 downto 0)&enable_aux(3);
    end if;
end if;
end process;

enable_seg<=enable_aux;

process(enable_aux, unidades, decenas, centenas, millares)
begin
case enable_aux is
when "1110" => sal_mux<=unidades;
when "1101" => sal_mux<=decenas;
when "1011" => sal_mux<=centenas;
when "0111" => sal_mux<=millares;
when others => sal_mux<="0000";
end case;
end process;

process(sal_mux)
begin
case sal_mux is
when "0000" => segmentos<="0000001";
when "0001" => segmentos<="1001111";
when "0010" => segmentos<="0010010";
when "0011" => segmentos<="0000110";
when "0100" => segmentos<="1001100";
when "0101" => segmentos<="0100100";
when "0110" => segmentos<="1100000";
when "0111" => segmentos<="0001111";
when "1000" => segmentos<="0000000";
when "1001" => segmentos<="0001100";
when others => segmentos<="1111111";
end case;
end process;

end Behavioral;
