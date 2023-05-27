library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sensor_hall is
Port ( 
clk: in std_logic;
reset: in std_logic;
sensor_hall_verde: in std_logic;
sensor_hall_azul: in std_logic;
rpm_salida: out std_logic_vector(7 downto 0);
sentido_salida: out std_logic
);
end sensor_hall;

architecture Behavioral of sensor_hall is

signal rpm : integer range 0 to 600000;

signal estado : std_logic_vector(2 downto 0);
signal cont_base : integer range 0 to 100;
signal cont : integer range 0 to 60000;
signal hall : std_logic_vector( 1 downto 0);

signal aux_rpm : integer range 0 to 600000;
signal hallData : std_logic_vector (7 downto 0);

begin

hall <= sensor_hall_verde & sensor_hall_azul;
rpm_salida <= hallData;

process(reset, clk)
begin
if reset='1' then
   cont_base<=0;
elsif rising_edge(clk) then
      if cont_base=100 then
         cont_base<=0;
      else
         cont_base <=cont_base +1;
      end if;
end if;
end process;

--- Process para hallDC
--- Cuenta las revoluciones del motor cada segundo y luego las pasa a la variable rev_per_seg
process(clk, reset)
begin
   if reset='1' then
        estado <= "000";
    elsif rising_edge(clk) then
    if cont_base = 100 then
        case estado is
            when "000" => -- Estado_hall inicial
                cont <= 0;
                rpm <= 0;
                sentido_salida <= '0';
                estado <= "001";
            when "001" =>
                if cont >= 60000 then
                    rpm <= 0;
                    cont <= 0;
                    estado <= "001";
                elsif hall = "00" then
                    cont <= cont + 1;
                    estado <= "001";
                elsif hall = "01" then
                    cont <= cont + 1;
                    sentido_salida <= '0'; -- Sentido de giro positivo
                    estado <= "010";
                elsif hall = "10" then
                    cont <= cont + 1;
                    sentido_salida <= '1'; -- Sentido de giro negativo
                    estado <= "011";
                end if;      
            when "010" =>
               if hall = "01" then
                    cont <= cont + 1;
                    estado <= "010";
                elsif hall = "00" then
                    cont <= cont + 1;
                    estado <= "100";
                elsif cont >= 60000 then    
                    rpm <= 0;
                    cont <= 0;
                    estado <= "001";
                end if;      
             when "011" =>
                if hall = "01" then
                    cont <= cont + 1;
                    estado <= "010";
                elsif hall = "00" then
                    cont <= cont + 1;
                    estado <= "100";
                elsif cont >= 60000 then    
                    rpm <= 0;
                    cont <= 0;
                    estado <= "001"; 
                end if;
            when "100" =>
                rpm <= (60000000 / (cont * 8 * 120));
                cont <= 0;
                estado <= "001";  
            when others =>
                estado <= "000";
        end case;
    end if;
    end if;

hallData <= std_logic_vector(to_unsigned(rpm, 8));

end process;

end Behavioral;
