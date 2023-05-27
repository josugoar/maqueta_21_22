## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
## Switches
set_property PACKAGE_PIN V17 [get_ports {sw[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property PACKAGE_PIN V16 [get_ports {sw[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property PACKAGE_PIN W16 [get_ports {sw[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property PACKAGE_PIN W17 [get_ports {sw[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
set_property PACKAGE_PIN R2 [get_ports {enable}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {enable}]
 

## LEDs
set_property PACKAGE_PIN U16 [get_ports {led[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property PACKAGE_PIN E19 [get_ports {led[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property PACKAGE_PIN U19 [get_ports {led[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property PACKAGE_PIN V19 [get_ports {led[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property PACKAGE_PIN W18 [get_ports {led[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property PACKAGE_PIN U15 [get_ports {led[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property PACKAGE_PIN U14 [get_ports {led[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
set_property PACKAGE_PIN V14 [get_ports {led[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
set_property PACKAGE_PIN V13 [get_ports {led[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
set_property PACKAGE_PIN V3 [get_ports {led[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]
set_property PACKAGE_PIN W3 [get_ports {led[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]
set_property PACKAGE_PIN U3 [get_ports {led[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]
	
	
##7 segment display
set_property PACKAGE_PIN W7 [get_ports {segmentos[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {segmentos[6]}]
set_property PACKAGE_PIN W6 [get_ports {segmentos[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {segmentos[5]}]
set_property PACKAGE_PIN U8 [get_ports {segmentos[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {segmentos[4]}]
set_property PACKAGE_PIN V8 [get_ports {segmentos[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {segmentos[3]}]
set_property PACKAGE_PIN U5 [get_ports {segmentos[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {segmentos[2]}]
set_property PACKAGE_PIN V5 [get_ports {segmentos[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {segmentos[1]}]
set_property PACKAGE_PIN U7 [get_ports {segmentos[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {segmentos[0]}]

#set_property PACKAGE_PIN V7 [get_ports dp]							
	#set_property IOSTANDARD LVCMOS33 [get_ports dp]

set_property PACKAGE_PIN U2 [get_ports {enable_seg[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {enable_seg[0]}]
set_property PACKAGE_PIN U4 [get_ports {enable_seg[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {enable_seg[1]}]
set_property PACKAGE_PIN V4 [get_ports {enable_seg[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {enable_seg[2]}]
set_property PACKAGE_PIN W4 [get_ports {enable_seg[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {enable_seg[3]}]


##Buttons
set_property PACKAGE_PIN U18 [get_ports inicio]						
	set_property IOSTANDARD LVCMOS33 [get_ports inicio]
