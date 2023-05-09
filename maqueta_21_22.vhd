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
que_ver: in std_logic_vector (1 downto 0)
);

architecture Behavioral of my_servo_v1 is
begin
end Behavioral;
