library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity bin_BCD is
port(
clk: in std_logic;
inicio: in std_logic;
sw: in std_logic_vector (13 downto 0);
enable: in std_logic;
led: out std_logic_vector (29 downto 0);
enable_seg: out std_logic_vector (3 downto 0);
segmentos: out std_logic_vector (6 downto 0)
);
end bin_BCD;

architecture Behavioral of bin_BCD is

signal vector_aux: std_logic_vector (29 downto 0);
signal estado: std_logic_vector (1 downto 0);
signal cont_bits: integer range 0 to 3;
signal fin: std_logic;

signal sal_mux: std_logic_vector (3 downto 0);
signal unidades: std_logic_vector (3 downto 0);
signal decenas: std_logic_vector (3 downto 0);
signal centenas: std_logic_vector (3 downto 0);
signal millares: std_logic_vector (3 downto 0);
signal enable_aux: std_logic_vector (3 downto 0);
signal cont_base_enable: integer range 0 to 100000;

signal cont: integer range 0 to 100000000;

begin

led(29 downto 0)<=vector_aux;

process(clk, inicio)
begin
if inicio='1' then
    cont<=0;
elsif rising_edge(clk) then
    if cont=100000000 then
        cont<=0;
    else
        cont<=cont+1;
    end if;
end if;
end process;                        

process(clk, inicio)
begin
if inicio='1' then
    vector_aux<="0000000000000000"&sw;
    estado<="00";
    cont_bits<= 0;
    millares<="0011";
    centenas<="0011";
    unidades<="0011";
    decenas<="0011";
    fin<='0';
elsif rising_edge(clk) then
--if cont=0 then
    case estado is
    when "00" =>    cont_bits<=0;
                    fin<='0';
                    vector_aux<="0000000000000000"&sw;
                    if enable='1' then
                        estado<="01";
                    end if;        
    when "01" =>    cont_bits<=cont_bits+1;
                    fin<='0';
                    vector_aux<=vector_aux(28 downto 0)&'0';
                    if cont_bits<3 then
                        estado<="10";
                    else
                        estado<="11";
                    end if;
    when "10" =>    cont_bits<=cont_bits;
                    fin<='0';
                    if vector_aux(29 downto 26)>4 then
                        vector_aux(29 downto 26)<=vector_aux(29 downto 26)+"0011";
                    end if;
                    if vector_aux(25 downto 22)>4 then
                        vector_aux(25 downto 22)<=vector_aux(25 downto 22)+"0011";
                    end if;
                    if vector_aux(21 downto 18)>4 then
                        vector_aux(21 downto 18)<=vector_aux(21 downto 18)+"0011";
                    end if;
                    if vector_aux(17 downto 14)>4 then
                        vector_aux(17 downto 14)<=vector_aux(17 downto 14)+"0011";
                    end if;
                    estado<="01";
    when "11" =>    cont_bits<=0;
                    fin<='1';
                    millares<=vector_aux(29 downto 26);
                    centenas<=vector_aux(25 downto 22);
                    decenas<=vector_aux(21 downto 18);
                    unidades<=vector_aux(17 downto 14);
                    estado<="00";
    when others =>  cont_bits<=0;
                    fin<='0';
                    estado<="00";
    end case;
end if;
--end if;
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
--fin de la activación de los siete seg

enable_seg<=enable_aux;

--multiplexado de las entradas al 7-seg
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

--descripcion del decodificador BCD-7segmentos
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
end process;--final de decodificador BCD-7seg

end Behavioral;
