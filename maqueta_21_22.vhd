library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity maqueta_21_22 is
port(
clk: in std_logic;
inicio: in std_logic;
segmentos: out std_logic_vector (6 downto 0);
enable_seg: out std_logic_vector (3 downto 0);
FC1: in std_logic;
FC2: in std_logic;
calefactor: out std_logic;
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
que_ver: in std_logic_vector (1 downto 0);
servo_pwm: out std_logic
);
end maqueta_21_22;

architecture Behavioral of maqueta_21_22 is

signal enable_my_quimat: std_logic;

signal distancia_cm: integer range 0 to 500; 

signal data_out_lsb: std_logic_vector (7 downto 0);
signal data_out_msb: std_logic_vector (3 downto 0);

signal tipo_servo: std_logic_vector (2 downto 0);

signal sw_bin_BCD: std_logic_vector (13 downto 0);
signal enable_bin_BCD: std_logic;

begin

led(1) <= FC2;
led(0) <= FC1;

calefactor <= '0';

work_pwm_motor_DC : entity work.pwm_motor_DC
port map(
clk => clk,
btn => inicio,
sw => sentido & speed,
pwm_motor_DC => pwm_motor_DC(0),
sentido_motor_DC => pwm_motor_DC(1)
);

work_sensor_hall : entity work.sensor_hall
port map( 
clk => clk,
inicio => inicio,
sensor_hall_verde => sensor_hall_verde,
sensor_hall_azul => sensor_hall_azul,
rpm => rpm_salida,
sentido => sentido_salida
);

enable_my_quimat <= '1';
work_my_quimat : entity work.my_quimat
port map(
clk => clk,
reset => inicio,
enable => enable_my_quimat,
dir => sentido,
enable_sal => enable_sal,
dir_sal => dir_sal,
frecuencia_paso_paso => "00000" & speed,
step => step
);

work_HC_SR04 : entity work.HC_SR04
port map(
clk => clk,
reset => inicio,
echo => echo,
distancia_cm => distancia_cm,
trigger => trigger
);

work_ST_DS18B20 : entity work.ST_DS18B20
port map(
clk1m => clk,
crc_en => crc_en,
data_out_lsb => data_out_lsb,
data_out_msb => data_out_msb,
ds_data_bus => ds_data_bus
);

tipo_servo <= "001";
work_my_servo_v1 : entity work.my_servo_v1
port map(
clk => clk,
reset => inicio,
selector => speed,
tipo_servo => tipo_servo,
servo_pwm => servo_pwm
);

enable_bin_BCD <= '1';
work_bin_BCD : entity work.bin_BCD
port map(
clk => clk,
inicio => inicio,
sw => sw_bin_BCD,
enable => enable_bin_BCD,
enable_seg => enable_seg,
segmentos => segmentos
);

end Behavioral;
