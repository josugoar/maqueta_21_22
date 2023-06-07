library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Contador que avanza de 0 a 9 al ritmo del dedo en un pulsador
-- El contador avanza al soltar, no al apretar
entity button_behaviour is
port(
clk: in std_logic;
inicio: in std_logic;
pulsador_suma: in std_logic;
pulsador_resta: in std_logic;
valor: out std_logic_vector (5 downto 0);
maximo: in std_logic_vector (5 downto 0)
);
end button_behaviour;

architecture Behavioral of button_behaviour is

signal estado_suma: std_logic_vector (1 downto 0);
signal cont_filtro_suma: integer range 0 to 250000;
signal salida_suma: std_logic ;
signal estado_resta: std_logic_vector (1 downto 0);
signal salida_resta: std_logic;
signal cont_filtro_resta: integer range 0 to 250000;
signal consigna: std_logic_vector(5 downto 0);

begin

valor <= consigna;

process(clk, inicio)
begin
if inicio='1' then	
	estado_suma<="00";
elsif rising_edge(clk) then
	case estado_suma is
	when "00" => 	cont_filtro_suma<=0;
					if pulsador_suma='0' then
						estado_suma<="00";
					else
						estado_suma<="01";
					end if;
	when "01" =>	
	                if cont_filtro_suma >= 250000 and pulsador_suma = '1' then
	                   estado_suma <= "10";
	                elsif cont_filtro_suma >= 250000 and pulsador_suma = '1' then
	                   estado_suma <= "10";
	                end if;
	                cont_filtro_suma <= cont_filtro_suma + 1;
	when "10" => 
	               if pulsador_suma = '0' then
	                   estado_suma <= "11";
	               end if;
	when others => 	cont_filtro_suma<=0;
					estado_suma<="00";
	end case;
end if;
end process;

process(clk, inicio)
begin
if inicio='1' then	
	estado_resta<="00";
elsif rising_edge(clk) then
	case estado_resta is
	when "00" => 	cont_filtro_resta<=0;
					if pulsador_resta='0' then
						estado_resta<="00";
					else
						estado_resta<="01";
					end if;
	when "01" =>	
	                if cont_filtro_resta >= 250000 and pulsador_resta = '1' then
	                   estado_resta <= "10";
	                elsif cont_filtro_resta >= 250000 and pulsador_resta = '1' then
	                   estado_resta <= "10";
	                end if;
	                cont_filtro_resta <= cont_filtro_resta + 1;
	when "10" => 
	               if pulsador_resta = '0' then
	                   estado_resta <= "11";
	               end if;
	       
	when others => 	cont_filtro_resta<=0;
					estado_resta<="00";
	end case;
end if;
end process;


process(estado_suma)
begin
case estado_suma is
	when "00" => salida_suma<='0';
	when "01" => salida_suma<='0';
	when "10" => salida_suma<='0';
	when "11" => salida_suma<='1';
	when others => salida_suma<='0';
end case;
end process;

process(estado_resta)
begin
case estado_resta is
	when "00" => salida_resta<='0';
	when "01" => salida_resta<='0';
	when "10" => salida_resta<='0';
	when "11" => salida_resta<='1';
	when others => salida_resta<='0';
end case;
end process;


process(inicio, clk)
begin
if inicio='1' then
	consigna<="000000";
elsif rising_edge(clk) then
	if salida_suma='1' then
		if consigna>=maximo then
			consigna<=maximo;
		else
			consigna<=consigna+1;
		end if;
	elsif salida_resta='1' then
        if consigna=0 then
                consigna<="000000";
            else
                consigna<=consigna-1;
            end if;
	end if;
end if;
end process;

end Behavioral;
