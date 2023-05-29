## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

##Buttons
set_property PACKAGE_PIN U18 [get_ports inicio]					
    set_property IOSTANDARD LVCMOS33 [get_ports inicio]

### LEDs
set_property PACKAGE_PIN U16 [get_ports {data_out_lsb[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_out_lsb[0]}]
set_property PACKAGE_PIN E19 [get_ports {data_out_lsb[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_out_lsb[1]}]
set_property PACKAGE_PIN U19 [get_ports {data_out_lsb[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_out_lsb[2]}]
set_property PACKAGE_PIN V19 [get_ports {data_out_lsb[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_out_lsb[3]}]
set_property PACKAGE_PIN W18 [get_ports {data_out_lsb[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_out_lsb[4]}]
set_property PACKAGE_PIN U15 [get_ports {data_out_lsb[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_out_lsb[5]}]
set_property PACKAGE_PIN U14 [get_ports {data_out_lsb[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_out_lsb[6]}]
set_property PACKAGE_PIN V14 [get_ports {data_out_lsb[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_out_lsb[7]}]

set_property PACKAGE_PIN V13 [get_ports {data_out_msb[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_out_msb[0]}]
set_property PACKAGE_PIN V3 [get_ports {data_out_msb[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_out_msb[1]}]
set_property PACKAGE_PIN W3 [get_ports {data_out_msb[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_out_msb[2]}]
set_property PACKAGE_PIN U3 [get_ports {data_out_msb[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_out_msb[3]}]

set_property PACKAGE_PIN L1 [get_ports {crc_en}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {crc_en}]

##Pmod Header JC
##Sch name = JC10
set_property PACKAGE_PIN R18 [get_ports {ds_data_bus}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {ds_data_bus}]
