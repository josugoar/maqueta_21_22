## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

##Buttons
set_property PACKAGE_PIN U18 [get_ports start]					
    set_property IOSTANDARD LVCMOS33 [get_ports start]
set_property PACKAGE_PIN T18 [get_ports button_up]						
	set_property IOSTANDARD LVCMOS33 [get_ports button_up]
set_property PACKAGE_PIN U17 [get_ports button_down]						
	set_property IOSTANDARD LVCMOS33 [get_ports button_down]
set_property PACKAGE_PIN W19 [get_ports button_left]						
	set_property IOSTANDARD LVCMOS33 [get_ports button_left]
set_property PACKAGE_PIN T17 [get_ports button_right]						
	set_property IOSTANDARD LVCMOS33 [get_ports button_right]
	
## Switches
set_property PACKAGE_PIN V17 [get_ports {speed[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {speed[0]}]
set_property PACKAGE_PIN V16 [get_ports {speed[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {speed[1]}]
set_property PACKAGE_PIN W16 [get_ports {speed[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {speed[2]}]
set_property PACKAGE_PIN W17 [get_ports {speed[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {speed[3]}]

set_property PACKAGE_PIN W14 [get_ports {que_ver[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {que_ver[0]}]
set_property PACKAGE_PIN W13 [get_ports {que_ver[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {que_ver[1]}]
	
set_property PACKAGE_PIN R2 [get_ports {sentido}]		
	set_property IOSTANDARD LVCMOS33 [get_ports {sentido}]

set_property PACKAGE_PIN T1 [get_ports {inicio}]		
	set_property IOSTANDARD LVCMOS33 [get_ports {inicio}]

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
    
set_property PACKAGE_PIN U2 [get_ports {enable_seg[0]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {enable_seg[0]}]
set_property PACKAGE_PIN U4 [get_ports {enable_seg[1]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {enable_seg[1]}]
set_property PACKAGE_PIN V4 [get_ports {enable_seg[2]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {enable_seg[2]}]
set_property PACKAGE_PIN W4 [get_ports {enable_seg[3]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {enable_seg[3]}]

### LEDs
set_property PACKAGE_PIN U16 [get_ports {rpm_salida[0]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm_salida[0]}]
set_property PACKAGE_PIN E19 [get_ports {rpm_salida[1]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm_salida[1]}]
set_property PACKAGE_PIN U19 [get_ports {rpm_salida[2]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm_salida[2]}]
set_property PACKAGE_PIN V19 [get_ports {rpm_salida[3]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm_salida[3]}]
set_property PACKAGE_PIN W18 [get_ports {rpm_salida[4]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm_salida[4]}]
set_property PACKAGE_PIN U15 [get_ports {rpm_salida[5]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm_salida[5]}]
set_property PACKAGE_PIN U14 [get_ports {rpm_salida[6]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm_salida[6]}]
set_property PACKAGE_PIN V14 [get_ports {rpm_salida[7]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {rpm_salida[7]}]
	
set_property PACKAGE_PIN W3 [get_ports {modo[0]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {modo[0]}]
set_property PACKAGE_PIN U3 [get_ports {modo[1]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {modo[1]}]
	

set_property PACKAGE_PIN N3 [get_ports {led[0]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property PACKAGE_PIN P3 [get_ports {led[1]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]

set_property PACKAGE_PIN L1 [get_ports {sentido_salida}]		
	set_property IOSTANDARD LVCMOS33 [get_ports {sentido_salida}]

set_property PACKAGE_PIN V3 [get_ports {crc_en}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {crc_en}]

##Pmod Header JA
##Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {servo_pwm}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {servo_pwm}]

##Pmod Header JB
##Sch name = JB4
set_property PACKAGE_PIN B16 [get_ports {pwm_motor_DC[0]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {pwm_motor_DC[0]}]
##Sch name = JB10
set_property PACKAGE_PIN C16 [get_ports {pwm_motor_DC[1]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {pwm_motor_DC[1]}]
##Sch name = JC1
set_property PACKAGE_PIN K17 [get_ports {sensor_hall_verde}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sensor_hall_verde}]
##Sch name = JC7
set_property PACKAGE_PIN L17 [get_ports {sensor_hall_azul}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sensor_hall_azul}]
##Sch name = JB9
set_property PACKAGE_PIN C15 [get_ports {enable_sal}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {enable_sal}]
##Sch name = JB3
set_property PACKAGE_PIN B15 [get_ports {dir_sal}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dir_sal}]
##Sch name = JB8
set_property PACKAGE_PIN A17 [get_ports {step}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {step}]

##Pmod Header JB
##Sch name = JC3
set_property PACKAGE_PIN N17 [get_ports {FC1}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {FC1}]
##Sch name = JC9
set_property PACKAGE_PIN P17 [get_ports {FC2}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {FC2}]
##Sch name = JB2	
set_property PACKAGE_PIN A16 [get_ports {calefactor}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {calefactor}]
##Sch name = JC8
set_property PACKAGE_PIN M19 [get_ports trigger]                    
    set_property IOSTANDARD LVCMOS33 [get_ports trigger]
##Sch name = JC2
set_property PACKAGE_PIN M18 [get_ports echo]    
    set_property IOSTANDARD LVCMOS33 [get_ports echo]        

##Pmod Header JC
##Sch name = JC10
set_property PACKAGE_PIN R18 [get_ports {ds_data_bus}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {ds_data_bus}]
