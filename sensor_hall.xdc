## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

##Buttons
set_property PACKAGE_PIN U18 [get_ports inicio]					
    set_property IOSTANDARD LVCMOS33 [get_ports inicio]

### LEDs
set_property PACKAGE_PIN U16 [get_ports {rpm[0]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm[0]}]
set_property PACKAGE_PIN E19 [get_ports {rpm[1]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm[1]}]
set_property PACKAGE_PIN U19 [get_ports {rpm[2]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm[2]}]
set_property PACKAGE_PIN V19 [get_ports {rpm[3]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm[3]}]
set_property PACKAGE_PIN W18 [get_ports {rpm[4]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm[4]}]
set_property PACKAGE_PIN U15 [get_ports {rpm[5]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm[5]}]
set_property PACKAGE_PIN U14 [get_ports {rpm[6]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm[6]}]
set_property PACKAGE_PIN V14 [get_ports {rpm[7]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm[7]}]

set_property PACKAGE_PIN L1 [get_ports {sentido}]		
	set_property IOSTANDARD LVCMOS33 [get_ports {sentido}]


##Pmod Header JB
##Sch name = JC1
set_property PACKAGE_PIN K17 [get_ports {sensor_hall_verde}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sensor_hall_verde}]
##Sch name = JC7
set_property PACKAGE_PIN L17 [get_ports {sensor_hall_azul}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sensor_hall_azul}]
