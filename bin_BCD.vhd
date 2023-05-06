library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity bin_BCD is
port(
clk: in std_logic;
inicio: in std_logic;
sw: in std_logic_vector (3 downto 0);
enable: in std_logic;
fin: out std_logic;
unidades: out std_logic_vector (3 downto 0);
decenas: out std_logic_vector (3 downto 0)
);
end bin_BCD;

architecture Behavioral of bin_BCD is

signal vector_aux: std_logic_vector (11 downto 0);
signal estado: std_logic_vector (1 downto 0);
signal cont_bits: integer range 0 to 3;

begin

led(11 downto 0)<=vector_aux;

process(clk, inicio)
begin
end process;                        

process(clk, inicio)
begin
if inicio='1' then
    vector_aux<="00000000"&sw;
    estado<="00";
    cont_bits<= 0;
    unidades<="0011";
    decenas<="0011";
    fin<='0';
elsif rising_edge(clk) then
    case estado is
    when "00" =>    cont_bits<=0;
                    fin<='0';
                    vector_aux<="00000000"&sw;
                    if enable='1' then
                        estado<="01";
                    end if;        
    when "01" =>    cont_bits<=cont_bits+1;
                    fin<='0';
                    vector_aux<=vector_aux(10 downto 0)&'0';
                    if cont_bits<3 then
                        estado<="10";
                    else
                        estado<="11";
                    end if;
    when "10" =>    cont_bits<=cont_bits;
                    fin<='0';
                    if vector_aux(11 downto 8)>4 then
                        vector_aux(11 downto 8)<=vector_aux(11 downto 8)+"0011";
                    end if;
                    if vector_aux(7 downto 4)>4 then
                        vector_aux(7 downto 4)<=vector_aux(7 downto 4)+"0011";
                    end if;
                    estado<="01";
    when "11" =>    cont_bits<=0;
                    fin<='1';
                    decenas<=vector_aux(11 downto 8);
                    unidades<=vector_aux(7 downto 4);
                    estado<="00";
    when others =>  cont_bits<=0;
                    fin<='0';
                    estado<="00";
    end case;
end if;
end process;

end Behavioral;
