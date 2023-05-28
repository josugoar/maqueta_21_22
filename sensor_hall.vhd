library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sensor_hall is
Port ( 
clk: in std_logic;
inicio: in std_logic;
sensor_hall_verde: in std_logic;
sensor_hall_azul: in std_logic;
rpm: out std_logic_vector (7 downto 0);
sentido: out std_logic
);
end sensor_hall;

architecture Behavioral of sensor_hall is

signal hall: std_logic_vector (1 downto 0);

signal cont_base: integer range 0 to 100;

signal estado: std_logic_vector (2 downto 0);
signal cont_micros: integer range 0 to 60000;

begin

hall <= sensor_hall_verde & sensor_hall_azul;

process(clk, inicio)
begin
if inicio = '1' then
   cont_base <= 0;
elsif rising_edge(clk) then
      if cont_base = 100 then
         cont_base <= 0;
      else
         cont_base <= cont_base + 1;
      end if;
end if;
end process;

process(clk, inicio)
begin
if inicio = '1' then
    cont_micros <= 0;
    rpm <= "00000000";
    sentido <= '0';
    estado <= "000";
elsif rising_edge(clk) then
    if cont_base = 100 then
        case estado is
        when "000" =>
            cont_micros <= 0;
            estado <= "001";
        when "001" =>
            if cont_micros = 60000 then
                cont_micros <= 0;
                estado <= "001";
            elsif hall = "00" then
                cont_micros <= cont_micros + 1;
                estado <= "001";
            elsif hall = "01" then
                cont_micros <= cont_micros + 1;
                sentido <= '0';
                estado <= "010";
            elsif hall = "10" then
                cont_micros <= cont_micros + 1;
                sentido <= '1';
                estado <= "011";
            end if;
        when "010" =>
            if cont_micros = 60000 then    
                cont_micros <= 0;
                estado <= "001";
            elsif hall /= "00" then
                cont_micros <= cont_micros + 1;
                estado <= "010";
            elsif hall = "00" then
                cont_micros <= cont_micros + 1;
                estado <= "100";
            end if;
         when "011" =>
            if cont_micros >= 60000 then    
                cont_micros <= 0;
                estado <= "001"; 
            elsif hall /= "00" then
                cont_micros <= cont_micros + 1;
                estado <= "010";
            elsif hall = "00" then
                cont_micros <= cont_micros + 1;
                estado <= "100";
            end if;
        when "100" =>
            cont_micros <= 0;
            rpm <= std_logic_vector(to_unsigned(60000000 / (cont_micros * 8 * 120), 8));
            estado <= "001";  
        when others =>
            cont_micros <= 0;
            estado <= "000";
        end case;
    end if;
end if;
end process;

end Behavioral;
