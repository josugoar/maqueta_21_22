library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;

entity pwm_motor_DC is
port(
clk: in std_logic;
btn: in std_logic;
sw: in std_logic_vector (4 downto 0);
pwm_motor_DC: out std_logic;
sentido_motor_DC: out std_logic;
led: out std_logic_vector (6 downto 0)
);

end pwm_motor_DC;

architecture Behavioral of pwm_motor_DC is

signal reset: std_logic;
signal pwm: std_logic;
signal selector: integer range -10 to 10;
signal duty_cycle: integer range 0 to 100;
signal duty_cycle_aux: integer range 0 to 100;
signal contador_aux_duty_cycle: integer range 0 to 500000; -- 200 Hz

signal contador_base: integer range 0 to 1000000;
signal pwm_tope: integer range 0 to 10000000;
signal estado: std_logic_vector (2 downto 0) :="000";
signal frecuencia_pwm: integer range 0 to 1000;
signal frecuencia_pwm_flancos: integer range 0 to 100000000;

begin

reset<=btn;
selector<=to_integer(signed(sw));
led<=std_logic_vector(to_unsigned(duty_cycle, 7));
frecuencia_pwm<=200; --este valor controla la frecuencia del pwm

process(selector, pwm)
begin
if selector > 0 then --giro normal
    sentido_motor_DC<='0';
    pwm_motor_DC<=pwm; --para llevar la seÃƒÂ±al al motor
    duty_cycle_aux<=selector*10;
else
    sentido_motor_DC<=pwm;
    pwm_motor_DC<='0'; --para llevar la seÃƒÂ±al al motor
    duty_cycle_aux<=(-selector)*10;
end if;
end process;

-- Mientras el duty_cycle no cambie, mantiene su valor, pero cuando cambie selector y conÃ‚Â´el
-- el duty_cycle, entonces llegarÃƒÂ¡ al nuevo valor de 1% en 1%, y no de 10%, lo hace una 
-- velocidad de incremento de 200 Hz (como el pwm)
process(clk, reset)
begin
if clk='1' and clk'event then
    if reset='1' then
        duty_cycle<=0;
    else
        if contador_aux_duty_cycle=0 then
            if duty_cycle/=duty_cycle_aux then
                if duty_cycle_aux>duty_cycle then
                    duty_cycle<=duty_cycle+1;
                 elsif duty_cycle_aux<duty_cycle then
                    duty_cycle<=duty_cycle-1;
                 end if;                 
            end if;
        end if;
   end if;
end if;
end process;

-- contador para generar una seÃƒÂ±al de 200 Hz para incrementar/decrementar el duty cycle
process(clk, reset)
begin
if clk='1' and clk'event then
    if reset='1' then
        contador_aux_duty_cycle<=0;
    else
        if contador_aux_duty_cycle=500000 then
            contador_aux_duty_cycle<=0;
        else
            contador_aux_duty_cycle<= contador_aux_duty_cycle+1;
        end if;
    end if;
end if;
end process;

-- frecuencia_pwm_flancos indica cuÃƒÂ¡ntos flancos del reloj del sistema hacen
-- falta para generar el periodo de PWM contando flancos flancos.
-- Por ejemplo para 100 Hz debe contar 1250000 flancos
process(frecuencia_pwm)
begin
frecuencia_pwm_flancos<=100000000/frecuencia_pwm;
end process;

-- pwm_tope expresa en flancos cuÃƒÂ¡ntos flancos debe estar la salida a 1
process(frecuencia_pwm, duty_cycle)
begin
pwm_tope<=100000000/frecuencia_pwm*duty_cycle/100;
end process;

process(clk)
begin
if rising_edge(clk) then
    if reset='1' then
        estado<="000";
	   contador_base<=0;
    else        
        case estado is
        --estado reset
        when "000" =>   contador_base<=0;
                        if  duty_cycle=0 then
                            estado<="001";
                        else
                            estado<="010";
                        end if;
        --estado de comienzo pero duty_cycle es 0%, o sea pwm inactivo todo el rato
        when "001" =>   contador_base<=1;
                        estado<="011";
        --estado que comienza con el pwm a 1
        when "010" =>   contador_base<=1;
                        estado<="100";
        --estado que rellena los 0 hasta el final
        when "011" =>   contador_base<=contador_base+1;
                        if  contador_base<frecuencia_pwm_flancos then
                            estado<="011";
                        else 
                            if  duty_cycle=0 then
                                estado<="001";
                            else 
                                estado<="010";
                            end if;
                        end if;
        --estado que desarrolla el pwm a 1
        when "100" =>   contador_base<=contador_base+1;
                        if  contador_base=pwm_tope then
                            if  duty_cycle=100 then 
                                estado<="010";
                            else 
                                estado<="011";
                            end if;
                        else
                            estado<="100";
                        end if;
        when others =>  estado<="000";
                    contador_base<=0;
        end case;
    end if;
end if;
end process;

process(estado)
begin
case estado is
    when "000" => pwm<='0';
    when "001" => pwm<='0';
    when "010" => pwm<='1';
    when "011" => pwm<='0';
    when "100" => pwm<='1';
    when others => pwm<='0';
end case;
end process;

end Behavioral;
