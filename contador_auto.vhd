library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity contador_auto is
port(
clk: in std_logic;
inicio: in std_logic;
pulsador_suma: in std_logic;
pulsador_resta: in std_logic;
maximo: in std_logic_vector(1 downto 0);
contador: out std_logic_vector(1 downto 0);
modo: out std_logic_vector(1 downto 0)
);
end contador_auto;

architecture Behavioral of contador_auto is 

signal estado_suma: std_logic_vector (3 downto 0);
signal puls_sal_suma: std_logic;
signal estado_resta: std_logic_vector (3 downto 0);
signal puls_sal_resta: std_logic;
signal cont_filtro_suma: integer range 0 to 200000000;
signal cont_espera_suma: integer range 0 to 25000000;

signal cont_filtro_resta: integer range 0 to 200000000;
signal cont_espera_resta: integer range 0 to 25000000;

signal modo_aux: std_logic_vector(1 downto 0);

signal contador_aux: std_logic_vector(1 downto 0);

signal modo_suma: std_logic;
signal modo_resta: std_logic;

begin

contador <= contador_aux;
modo <= modo_aux;

process(inicio, clk)
begin
if inicio='1' then
   	estado_suma <="0000";
	cont_filtro_suma<=0;
	cont_espera_suma<=0;
elsif rising_edge(clk) then
case estado_suma is
when "0000" =>
	cont_filtro_suma<=0;
	cont_espera_suma<=0;
	if pulsador_suma='0' then
		estado_suma<="0000";
	else
		estado_suma<="0001";
	end if;
when "0001" => 
   	cont_filtro_suma<=cont_filtro_suma+1;
	cont_espera_suma<=0;
	if pulsador_suma ='0' then
		estado_suma<="0000";
	elsif pulsador_suma ='1' and cont_filtro_suma>=100000 then
		estado_suma<="0010";
	else
		estado_suma<="0001";
	end if;
when "0010" =>
    cont_filtro_suma <= cont_filtro_suma + 1;
	cont_espera_suma<=0;
	if pulsador_suma ='0' and cont_filtro_suma < 200000000 then
		estado_suma<="0011";
	elsif cont_filtro_suma >= 200000000 then
	   estado_suma<="1000";
	else
		estado_suma<="0010";
	end if;
when "0011"=>
	cont_filtro_suma<=0;
	cont_espera_suma<=cont_espera_suma+1;
	if pulsador_suma='1' then
	   estado_suma<="0000";
	elsif cont_espera_suma>=5000000 then
	   estado_suma<="0100";
	else 
	   estado_suma<="0011";
	end if;         
when "0100" =>
	cont_filtro_suma<=0;
	cont_espera_suma<=cont_espera_suma+1;
    if pulsador_suma='1' then
        estado_suma<="0101";
    elsif cont_espera_suma>=20000000 then
        estado_suma<="0000";
    else
        estado_suma<="0100";
    end if;        
when "0101" =>
	cont_filtro_suma<=cont_filtro_suma+1;
	cont_espera_suma<=0;
	if pulsador_suma='0' then	--rebote
		estado_suma<="0100";
	elsif pulsador_suma='1' and cont_filtro_suma>=100000 then
		estado_suma<="0110";
	else
		estado_suma<="0101";
	end if;
when "0110" =>
	cont_filtro_suma<=0;
	cont_espera_suma<=0;
	if pulsador_suma='0' then
		estado_suma<="0111";
	else
		estado_suma<="0110";
	end if;
when "0111" =>
	cont_filtro_suma<=0;
	cont_espera_suma<=0;
	estado_suma<="0000";
when "1000" =>
    estado_suma <= "0000";
when others =>
	cont_filtro_suma<=0;
	cont_espera_suma<=0;
    estado_suma<="0000";
end case;
end if;
end process; 


process(inicio, clk)
begin
if inicio='1' then
   	estado_resta<="0000";
	cont_filtro_resta<=0;
	cont_espera_resta<=0;
elsif rising_edge(clk) then
case estado_resta is
when "0000" =>
	cont_filtro_resta<=0;
	cont_espera_resta<=0;
	if pulsador_resta='0' then
		estado_resta<="0000";
	else
		estado_resta<="0001";
	end if;
when "0001" => 
   	cont_filtro_resta<=cont_filtro_resta+1;
	cont_espera_resta<=0;
	if pulsador_resta ='0' then
		estado_resta<="0000";
	elsif pulsador_resta ='1' and cont_filtro_resta>=100000 then
		estado_resta<="0010";
	else
		estado_resta<="0001";
	end if;
when "0010" =>
	cont_filtro_resta<=cont_filtro_resta+1;
	cont_espera_resta<=0;
	if pulsador_resta ='0' and cont_filtro_resta < 200000000 then
		estado_resta<="0011";
	elsif cont_filtro_resta >= 200000000 then
	   estado_resta<="1000";
	else
		estado_resta<="0010";
	end if;
when "0011"=>
	cont_filtro_resta<=0;
	cont_espera_resta<=cont_espera_resta+1;
	if pulsador_resta='1' then
	   estado_resta<="0000";
	elsif cont_espera_resta>=5000000 then
	   estado_resta<="0100";
	else 
	   estado_resta<="0011";
	end if;         
when "0100" =>
	cont_filtro_resta<=0;
	cont_espera_resta<=cont_espera_resta+1;
    if pulsador_resta='1' then
        estado_resta<="0101";
    elsif cont_espera_resta>=20000000 then
        estado_resta<="0000";
    else
        estado_resta<="0100";
    end if;        
when "0101" =>
	cont_filtro_resta<=cont_filtro_resta+1;
	cont_espera_resta<=0;
	if pulsador_resta='0' then	--rebote
		estado_resta<="0100";
	elsif pulsador_resta='1' and cont_filtro_resta>=100000 then
		estado_resta<="0110";
	else
		estado_resta<="0101";
	end if;
when "0110" =>
	cont_filtro_resta<=0;
	cont_espera_resta<=0;
	if pulsador_resta='0' then
		estado_resta<="0111";
	else
		estado_resta<="0110";
	end if;
when "0111" =>
	cont_filtro_resta<=0;
	cont_espera_resta<=0;
	estado_resta<="0000";
when "1000" =>
    estado_resta <= "0000";
when others =>
	cont_filtro_resta<=0;
	cont_espera_resta<=0;
    estado_resta<="0000";
end case;
end if;
end process;


process(modo_suma, modo_resta)
begin
if inicio='1' then
modo_aux<="00";
elsif rising_edge(clk) then
if modo_suma = '1' and modo_aux < maximo then
modo_aux <= modo_aux + 1;
elsif modo_resta = '1' and modo_aux > "00"  then
modo_aux <= modo_aux - 1;
end if;
end if;
end process;

process(estado_suma)
begin
modo_suma <= '0';
puls_sal_suma <= '0';
case estado_suma is
when "0000" => puls_sal_suma<='0';
when "0001" => puls_sal_suma<='0';
when "0010" => puls_sal_suma<='0';
when "0011" => puls_sal_suma<='0';
when "0100" => puls_sal_suma<='0';
when "0101" => puls_sal_suma<='0';
when "0110" => puls_sal_suma<='0';
when "0111" => puls_sal_suma<='1';
when "1000" => modo_suma <='1';
when others => puls_sal_suma<='0';
end case;
end process;

process(estado_resta)
begin
modo_resta <= '0';
puls_sal_resta <= '0';
case estado_resta is
when "0000" => puls_sal_resta<='0';
when "0001" => puls_sal_resta<='0';
when "0010" => puls_sal_resta<='0';
when "0011" => puls_sal_resta<='0';
when "0100" => puls_sal_resta<='0';
when "0101" => puls_sal_resta<='0';
when "0110" => puls_sal_resta<='0';
when "0111" => puls_sal_resta<='1';
when "1000" => modo_resta <='1';
when others => puls_sal_resta<='0';
end case;
end process;

process(inicio, clk)
begin
if inicio='1' then
contador_aux<="00";
elsif rising_edge(clk) then
	if puls_sal_suma='1' then
		if contador_aux=maximo then
         		contador_aux<=maximo;
     		else
         		contador_aux<=contador_aux+1;
      	end if;
      	elsif puls_sal_resta= '1' then
      	 if contador_aux="00" then
         		contador_aux<="00";
     		else
         		contador_aux<=contador_aux-1;
      	end if;
	end if;
end if;
end process;

end Behavioral;
