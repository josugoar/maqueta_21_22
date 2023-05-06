library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity servo is
port(
clk: in std_logic;
reset: in std_logic;
selector: in std_logic_vector (3 downto 0);
tipo_servo: in std_logic_vector (2 downto 0);
servo_pwm: out std_logic
);
end servo;

architecture Behavioral of servo is

signal contador_base: integer range 0 to 2500000;
signal pwm_tope: integer range 0 to 12500000;
signal frecuencia_pwm_flancos: integer range 0 to 125000000;
signal pos_grados: integer range 0 to 180;
signal frecuencia_clk: integer range 0 to 125000000;
signal frecuencia_pwm: integer range 0 to 1000; -- en Hz

type nombre_estados is (EST_RESET, START, A_UNO, A_CERO, T2);
signal estado: nombre_estados;


begin

frecuencia_clk<=100000000; -- 100 MHz o 125 MHz
frecuencia_pwm<=50;

frecuencia_pwm_flancos<=frecuencia_clk/frecuencia_pwm; --anchura total del opwm en pulsos, a 50 Hz son 20 ms

--la posición en grados va de 0 a 180 grados de la posición final del servo, no gira mas
process(selector)
begin
case selector is
when "0000" => pos_grados<=0;
when "0001" => pos_grados<=15;
when "0010" => pos_grados<=30;
when "0011" => pos_grados<=45;
when "0100" => pos_grados<=60;
when "0101" => pos_grados<=75;
when "0110" => pos_grados<=90;
when "0111" => pos_grados<=105;
when "1000" => pos_grados<=120;
when "1001" => pos_grados<=135;
when "1010" => pos_grados<=150;
when "1011" => pos_grados<=165;
when "1100" => pos_grados<=180;
when others => pos_grados<=0;
end case;
end process;


-- Duracion del pulso
process(tipo_servo)
begin
case tipo_servo is
when "000" => -- pulso de 1 ms a 2 ms
                pwm_tope<=100000+555*pos_grados;
when "001" => -- pulso de 0,5 ms a 2,5 ms SG90
                pwm_tope<=50000+1111*pos_grados;
when "010" => -- pulso de 0,3 ms a 2,3 ms FUTABA 3003
                pwm_tope<=30000+1111*pos_grados;
-- en los casos libres se pueden poner otros pulsos                
when others =>  pwm_tope<=0;
end case;
end process;                

process(clk, reset)
begin
if clk='1' and clk'event then
    if reset='1' then
        estado<=EST_RESET;
        contador_base<=0;
    else        
        case estado is
        --estado reset
        when EST_RESET =>   contador_base<=0;
                        estado<=START;

        when START =>   contador_base<=1;
                        estado<=A_UNO;
                                                       
        when A_UNO =>   contador_base<=contador_base+1;
                        if contador_base=pwm_tope then
                            estado<=A_CERO;
                        end if;
        when A_CERO =>      contador_base<=contador_base+1;
                        if  contador_base=frecuencia_pwm_flancos then 
                            estado<=START;
                        end if;
        when others =>      estado<=EST_RESET;
                        contador_base<=0;
        end case;
    end if;
end if;
end process;

process(estado)
begin
case estado is
    when EST_RESET => servo_pwm<='0';
    when START => servo_pwm<='1';
    when A_UNO => servo_pwm<='1';    
    when A_CERO => servo_pwm<='0';
    when others => servo_pwm<='0';
end case;
end process;

end Behavioral;
