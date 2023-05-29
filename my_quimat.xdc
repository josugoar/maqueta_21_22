## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

##Buttons
set_property PACKAGE_PIN U18 [get_ports inicio]					
    set_property IOSTANDARD LVCMOS33 [get_ports inicio]

## Switches
set_property PACKAGE_PIN V17 [get_ports {frecuencia_paso_paso[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {frecuencia_paso_paso[0]}]
set_property PACKAGE_PIN V16 [get_ports {frecuencia_paso_paso[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {frecuencia_paso_paso[1]}]
set_property PACKAGE_PIN W16 [get_ports {frecuencia_paso_paso[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {frecuencia_paso_paso[2]}]
set_property PACKAGE_PIN W17 [get_ports {frecuencia_paso_paso[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {frecuencia_paso_paso[3]}]
set_property PACKAGE_PIN W15 [get_ports {frecuencia_paso_paso[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {frecuencia_paso_paso[4]}]
set_property PACKAGE_PIN V15 [get_ports {frecuencia_paso_paso[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {frecuencia_paso_paso[5]}]
set_property PACKAGE_PIN W14 [get_ports {frecuencia_paso_paso[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {frecuencia_paso_paso[6]}]
set_property PACKAGE_PIN W13 [get_ports {frecuencia_paso_paso[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {frecuencia_paso_paso[7]}]
set_property PACKAGE_PIN V2 [get_ports {frecuencia_paso_paso[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {frecuencia_paso_paso[8]}]

set_property PACKAGE_PIN T1 [get_ports {enable}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {enable}]
	
set_property PACKAGE_PIN R2 [get_ports {sentido}]		
	set_property IOSTANDARD LVCMOS33 [get_ports {sentido}]


##Pmod Header JB
##Sch name = JB9
set_property PACKAGE_PIN C15 [get_ports {enable_sal}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {enable_sal}]
##Sch name = JB3
set_property PACKAGE_PIN B15 [get_ports {dir_sal}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dir_sal}]
##Sch name = JB8
set_property PACKAGE_PIN A17 [get_ports {step}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {step}]
