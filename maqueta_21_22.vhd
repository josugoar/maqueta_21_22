library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity maqueta_21_22 is
port(
clk: in std_logic;
inicio: in std_logic;
start: in std_logic;
button_up: in std_logic ;
button_down: in std_logic ;
button_left: in std_logic ;
button_right: in std_logic ;
segmentos: out std_logic_vector (6 downto 0);
enable_seg: out std_logic_vector (3 downto 0);
FC1: in std_logic;
FC2: in std_logic;
led: out std_logic_vector (1 downto 0);
sentido: in std_logic;
pwm_motor_DC: out std_logic_vector(1 downto 0);
sensor_hall_verde: in std_logic;
sensor_hall_azul: in std_logic;
rpm_salida: out std_logic_vector (7 downto 0);
sentido_salida: out std_logic;
dir_sal: out std_logic;
step: out std_logic;
enable_sal: out std_logic;
echo: in std_logic; 
trigger: out std_logic;
crc_en	: OUT		STD_LOGIC;
ds_data_bus	: INOUT	STD_LOGIC;
speed: in std_logic_vector (3 downto 0);
servo_pwm: out std_logic;
modo: out std_logic_vector(1 downto 0)
);

end entity;

architecture Behavioral of maqueta_21_22 is

signal sw: std_logic_vector (4 downto 0);
signal enable: std_logic;

signal distancia_cm: integer range 0 to 500;
signal salida: std_logic_vector (11 downto 0);

signal data_out_lsb: std_logic_vector (7 downto 0);
signal data_out_msb: std_logic_vector (3 downto 0);

signal consigna: std_logic_vector(5 downto 0);

signal dir: std_logic;

signal parar: std_logic;

signal mode: std_logic_vector(1 downto 0);

signal rpm_visualize : std_logic_vector(7 downto 0);

signal temp:  std_logic_vector(7 downto 0);

signal speedTemp:  std_logic_vector(3 downto 0);

signal visualizacion : std_logic_vector(1 downto 0);

signal dir_modo2: std_logic;
signal direccion: std_logic;

begin

temp <= data_out_msb & data_out_lsb(7 downto 4);

led(1)<=FC2;
led(0)<=FC1;

modo <= mode;

rpm_salida <= rpm_visualize;

process(temp)
begin
if unsigned(temp) < 28 then
speedTemp <= "0000";
elsif unsigned(temp) > 35 then
speedTemp <= "1111";
else
speedTemp <= std_logic_vector(to_unsigned( 15 - 2 * ( 35 - to_integer(unsigned(temp))), 4));
end if;
end process;

process(speedTemp, sentido, direccion, speed, mode)
begin
if mode = "00" then
    sw <= sentido & speedTemp;
else
    sw <= direccion & speed;
end if;
end process;

work_pwm_motor_DC : entity work.pwm_motor_DC
port map (
clk => clk,
btn => inicio,
sw => sw,
pwm_motor_DC => pwm_motor_DC(0),
sentido_motor_DC => pwm_motor_DC(1)
);

process(clk, inicio, start, visualizacion, consigna, distancia_cm, sentido)
begin
if inicio = '1' then
    parar <= '1';
elsif rising_edge(clk) then
if FC1 = '1' then
    if dir = '1' then
        parar <= '1';
    end if;
elsif FC2 = '1' then
    if dir = '0' then
        parar <= '1';
    end if;
end if;
if start = '1' then
    if unsigned(consigna) = distancia_cm then
        parar <= '1';
    else
        parar <= '0';
    end if;
else
if mode = "10" then
    if unsigned(consigna) < distancia_cm then
        dir <= '0';
    elsif unsigned(consigna) > distancia_cm then
        dir <= '1';
    else
        parar <= '1';
        dir <= '0';
    end if;
else
    dir <= sentido;
end if;
end if;
end if;
end process;

enable <= '1' when (((parar = '0') and mode = "00") or (mode  = "01") or ((parar = '0') and mode = "10")) and inicio = '0' else '0';

work_visualizacion_behaviour : entity work.contador_auto  
port map (
clk => clk,
inicio => inicio,
pulsador_suma => button_up,
pulsador_resta => button_down,
maximo_ver =>"11",
maximo_modo => "10",
contador => visualizacion,
modo => mode
);

process (clk, inicio)
begin
if inicio = '1' then
    dir_modo2 <= '1';
elsif rising_edge(clk) then
if FC1 = '1' then
    dir_modo2 <= '0';
elsif FC2 = '1' then
    dir_modo2 <= '1';
end if;
end if;
end process;

direccion <= dir when mode = "00" or mode = "10" else dir_modo2;

work_consigna_behaviour : entity work.button_behaviour 
port map (
clk => clk,
inicio => inicio,
pulsador_suma => button_right,
pulsador_resta => button_left,
valor => consigna,
maximo => "100011"

);

work_my_quimat : entity work.my_quimat
port map (
clk => clk,
reset => inicio,
enable => enable,
dir => direccion,
enable_sal => enable_sal ,
dir_sal => dir_sal,
frecuencia_paso_paso => "000000111",
step => step
);

work_my_servo_v1 : entity work.my_servo_v1
port map (
clk => clk,
inicio => inicio,
selector => speedTemp,
servo_pwm => servo_pwm
);

process(visualizacion, distancia_cm, consigna, temp, rpm_visualize)
begin
if visualizacion = "00" then
    salida <= std_logic_vector(to_unsigned(distancia_cm, 12));
elsif visualizacion = "01"  then
    salida <= consigna & std_logic_vector(to_unsigned(distancia_cm, 6));
elsif visualizacion = "10" then
    salida <= "0000" & temp;
elsif visualizacion  = "11" then
   salida  <=  "0000" & rpm_visualize;
else
    salida <= "000000000000";
    
end if;

end process;

instance_bin : entity work.bin_BCD
port map (
    clk => clk,
    tipo => visualizacion,
    inicio => inicio,
    sw => salida,
    enable => '1',
    enable_seg => enable_seg,
    segmentos => segmentos
);

instance_HCSR4 : entity work.HC_SR04
port map (
    clk => clk, -- al ser con ARM es de 100 MHz, no de 125 MHz
    reset => inicio,
    echo => echo,
    trigger => trigger,
    distancia_cm => distancia_cm
);

work_sensTemp : entity work.sensTemp
port map (
  clk1m	=> clk,
  crc_en => crc_en,
  ds_data_bus => ds_data_bus,
  data_out_lsb => data_out_lsb,
  data_out_msb => data_out_msb
);

work_sensHall : entity work.sensor_hall
port map (
  clk => clk,
  reset => inicio,
  sentido => sentido_salida,
  a => sensor_hall_verde,
  b => sensor_hall_azul,
  led => rpm_visualize
);

end Behavioral;
