## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
	
##Buttons
    set_property PACKAGE_PIN U18 [get_ports reset]                        
    set_property IOSTANDARD LVCMOS33 [get_ports reset]
    
##Pmod Header JA
    ##Sch name = JA1
    set_property PACKAGE_PIN J1 [get_ports trigger]                    
        set_property IOSTANDARD LVCMOS33 [get_ports trigger]
    ##Sch name = JA2
    set_property PACKAGE_PIN L2 [get_ports echo]                    
        set_property IOSTANDARD LVCMOS33 [get_ports echo]        

## LEDs
set_property PACKAGE_PIN U16 [get_ports {distancia_cm[0]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {distancia_cm[0]}]
set_property PACKAGE_PIN E19 [get_ports {distancia_cm[1]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {distancia_cm[1]}]
set_property PACKAGE_PIN U19 [get_ports {distancia_cm[2]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {distancia_cm[2]}]
set_property PACKAGE_PIN V19 [get_ports {distancia_cm[3]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {distancia_cm[3]}]
set_property PACKAGE_PIN W18 [get_ports {distancia_cm[4]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {distancia_cm[4]}]
set_property PACKAGE_PIN U15 [get_ports {distancia_cm[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {distancia_cm[5]}]
set_property PACKAGE_PIN U14 [get_ports {distancia_cm[6]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {distancia_cm[6]}]
set_property PACKAGE_PIN V14 [get_ports {distancia_cm[7]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {distancia_cm[7]}]
set_property PACKAGE_PIN V13 [get_ports {distancia_cm[8]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {distancia_cm[8]}]
set_property PACKAGE_PIN V3 [get_ports {distancia_cm[9]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {distancia_cm[9]}]
